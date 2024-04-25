import os

from cs50 import SQL
from flask import Flask, flash, redirect, render_template, request, session
from flask_session import Session
from tempfile import mkdtemp
from werkzeug.exceptions import default_exceptions, HTTPException, InternalServerError
from werkzeug.security import check_password_hash, generate_password_hash

from helpers import apology, login_required, lookup, usd

# Configure application
app = Flask(__name__)

# Ensure templates are auto-reloaded
app.config["TEMPLATES_AUTO_RELOAD"] = True


# Ensure responses aren't cached
@app.after_request
def after_request(response):
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response


# Custom filter
app.jinja_env.filters["usd"] = usd

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_FILE_DIR"] = mkdtemp()
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# Configure CS50 Library to use SQLite database
db = SQL("sqlite:///finance.db")

# Make sure API key is set
if not os.environ.get("API_KEY"):
    raise RuntimeError("API_KEY not set")


@app.route("/")
@login_required
def index():
    """Show portfolio of stocks"""
    listicle = db.execute('SELECT symbol, SUM(shares) as shares FROM transact WHERE user_id = ? GROUP BY symbol',
                          session['user_id'])
    companies = []

    for company in listicle:
        companies.append(lookup(company['symbol']))
        companies[-1]['shares'] = company['shares']
    cash = db.execute('SELECT cash FROM users WHERE id = ?',
                      session['user_id'])[0]['cash']
    total = 0
    for company in companies:
        total += company['shares'] * company['price']
    return render_template('index.html', companies=companies, cash=cash, total=total)


@app.route("/buy", methods=["GET", "POST"])
@login_required
def buy():
    """Buy shares of stock"""
    if request.method == 'GET':
        return render_template("buy.html")
    if request.method == 'POST':
        symbol = request.form.get('symbol').upper()
        shares = request.form.get('shares')
        try:
            shares = int(shares)
        except:
            return apology('Invalid number of shares')
        if shares <= 0:
            return apology('Invalid number of shares')
        company = lookup(symbol)
        shares = int(shares)
        if not company:
            return apology('INVALID SYMBOL')
        price = company['price']
        balance = db.execute('SELECT cash FROM users WHERE id = ?', session['user_id'])
        print(balance)
        monie = balance[0]
        if monie['cash'] < shares*price:
            return apology("CAN'T AFFORD")
        else:
            db.execute("UPDATE users SET cash = cash - ? WHERE id = ?",
                       shares*price, session['user_id'])
            db.execute("INSERT INTO transact(user_id, symbol, shares, price, time) VALUES(?, ?, ?, ?, datetime()) ",
                       session['user_id'], symbol, shares, price)
    return redirect("/")


@app.route("/history")
@login_required
def history():
    """Show history of transactions"""
    historydict = db.execute("SELECT symbol, shares, price, time FROM transact WHERE user_id = ? ORDER BY time",
                             session['user_id'])
    print(historydict)
    return render_template('history.html', historydict=historydict)


@app.route("/login", methods=["GET", "POST"])
def login():
    """Log user in"""

    # Forget any user_id
    session.clear()

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":

        # Ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username", 403)

        # Ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password", 403)

        # Query database for username
        rows = db.execute("SELECT * FROM users WHERE username = ?", request.form.get("username"))

        # Ensure username exists and password is correct
        if len(rows) != 1 or not check_password_hash(rows[0]["hash"], request.form.get("password")):
            return apology("invalid username and/or password", 403)

        # Remember which user has logged in
        session["user_id"] = rows[0]["id"]

        # Redirect user to home page
        return redirect("/")

    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("login.html")


@app.route("/logout")
def logout():
    """Log user out"""

    # Forget any user_id
    session.clear()

    # Redirect user to login form
    return redirect("/")


@app.route("/quote", methods=["GET", "POST"])
@login_required
def quote():
    """Get stock quote."""
    if request.method == "GET":
        return render_template('quote.html')
    if request.method == "POST":
        symbol = request.form.get('symbol').upper()
        company = lookup(symbol)
        if company is None:
            return apology('Invalid Symbol')
        return render_template('quoted.html', name=company['name'], symbol=company['symbol'], price=company['price'])
    return apology("TODO")


@app.route("/register", methods=["GET", "POST"])
def register():
    """Register user"""
    if request.method == "GET":
        return render_template('register.html')
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        confirmpassword = request.form.get('confirmation')
        users_list = db.execute('SELECT username FROM users')
        if username == '':
            return apology('Please enter a username')
        for user in users_list:
            if user['username'] == username:
                return apology('Username already in use')
        if password == None or password == '' or confirmpassword == None or confirmpassword == '':
            return apology("Please enter a password")
        if password != confirmpassword:
            return apology("Passwords don't match")
        else:
            db.execute('INSERT INTO users(username, hash) VALUES(?, ?)', username, generate_password_hash(password))
            return redirect("/login")


@app.route("/sell", methods=["GET", "POST"])
@login_required
def sell():
    """Sell shares of stock"""
    if request.method == "GET":
        companiesSymbol = db.execute('SELECT DISTINCT symbol FROM transact WHERE user_id = ?', session["user_id"])
        companies = []
        for company in companiesSymbol:
            companies.append(lookup(company['symbol']))
        return render_template('sell.html', companies=companies)

    if request.method == "POST":
        shares = int(request.form.get('shares'))
        symbol = request.form.get('symbol').upper()
        company = lookup(symbol)
        if company is None:
            return apology('Invalid Symbol')
        price = lookup(symbol)['price']
        money = shares*price
        owned = db.execute('SELECT SUM(shares) as shares FROM transact WHERE (user_id = ? AND symbol LIKE ?)',
                           session['user_id'], symbol)[0]['shares']
        print(owned)
        if shares > owned:
            return apology("YOU DON'T HAVE THAT MANY SHARES")
        else:
            db.execute('INSERT INTO transact(user_id, symbol,  shares, price, time) VALUES(?, ?, ?, ?, datetime())',
                       session['user_id'], symbol, -shares, price)
            db.execute('UPDATE users SET cash = cash + ? WHERE id = ?',
                       money, session['user_id'])
    return redirect('/')


def errorhandler(e):
    """Handle error"""
    if not isinstance(e, HTTPException):
        e = InternalServerError()
    return apology(e.name, e.code)


@app.route("/changepass", methods=['GET', 'POST'])
@login_required
def changepass():
    """Change password"""
    if request.method == 'GET':
        return render_template('pass.html')
    if request.method == 'POST':
        pass_hash = db.execute('SELECT hash FROM users WHERE id = ?', session['user_id'])
        pass_given = request.form.get('oldpass')
        pass1 = request.form.get('pass1')
        pass2 = request.form.get('pass2')
        if check_password_hash(pass_given, pass_hash[0]['hash']):
            print(generate_password_hash(pass_given))
            print(pass_hash[0]['hash'])
            return apology('Incorrect Password')
        elif pass1 != pass2:
            return apology("Passwords don't match")
        else:
            db.execute('UPDATE users SET hash = ? WHERE id = ?', generate_password_hash(pass1), session['user_id'])
            return redirect('/')


# Listen for errors
for code in default_exceptions:
    app.errorhandler(code)(errorhandler)
