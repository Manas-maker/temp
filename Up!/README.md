# Up!
## Video Demo: [Up!   CS50x 2021](https://youtu.be/eV2q_epOl38)
### Description:
A platformer where the the goal is to reach the top. You can use the arrow keys to move. Built on Love2D using Lua.
classic.lua is the library used to add classes to lua.
entity.lua defines the basic entity object on which the rest of the game objects are defined and has most of the code for collision resolution. Learning to resolve collisions did take some effort but in the end it was very rewarding.
crate.lua defines a box which can only be pushed from the side that isn't red, this is to prevent the player from pushing the crate of the platformer and get stuck with no way of moving forward.
box.lua defines a box you can jump through. wall.lua, dirtfull.lua and grasstop.lua define non moving tiles.
rock.lua defines rocks which cannot be moved by the player but are affected by gravity unlike the previously defined wall.lua, dirtfull.lua and grasstop.lua.
player.lua defines the player which can be moved by the arrow keys.
main.lua is the main file that runs the game, it has the map data, allows the player to jump, defines how long to keep checking for collision resolution and moves the camera with the player. In the first part the camera only moves vertically.
When the player reaches the credits area the camera also moves horizontally to keep the player on screen
The rest of the files are assests used in the game.
I was inspired by games like Downwell, and infinite survival game where you keep moving down and Jump Knight, a Foddian platformer where you have to reach the top of the map, in building a vertical platformer.
Though this might seem like a somewhat bland and uninspired video game, this is insanely important to me. Growing up playing games I wanted nothing more than to make my own.
I tried learning a language called SIMPLE about six-seven years ago.
But my ADHD and a very unhealthy obsession with content consumption pretty much meant I couldn’t get very far. What all of these years have somewhat amounted up to are essentially six years of procrastination.
I wanted to build the game out further but learning this new language and framework already took a lot of time and I regret I couldn't have invested any more time than this, but,
the sheer fact that I have reached this point where I can actually build a game is completely surreal to me. I cannot thank the CS50 team enough for leading me here. Have Fun!

#### Credits:
A big big thanks to the team at [CS50x](https://cs50.harvard.edu/x/2021/) for providing this course for free. Another big thanks to [OpenCourseWare](https://ocw.mit.edu/index.htm) for making it possible.
Special thanks to David and Bryan for being exceptional teachers, Guy White for suggesting working on Love2D and also using Sheepolution's guide. [Sheepolution](https://sheepolution.com/learn) for providing an extremely helpful guide.
Music: [Biogas](https://freemusicarchive.org/music/defrini/single/biogas) by [Defrini](https://freemusicarchive.org/music/defrini) licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)