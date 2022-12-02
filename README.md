# es4_final_proj

Read me!


What setting options do we want? (Also is this our lowest priority to implement)

How do we want to store the location of snakes? Mark each coordinates, store
corners, 


Modules Hierachy:

Top:
    - Take inputs through NES module
    - Use display module to produce the inputs VGA need, 
        the board will take NES module input.
    - Produce outputs through VGA module

VGA:
        Ivan
NES:
        Gabriel

Display:
    - Throw inputs into the board / menu module depends on which one we need
        - We might scale the board based on what is the size of the board.
    - Concat board and menu together and handle paddings, to produce an output
        for VGA module.

Menu:
    - Before the game start, provide list and instructions.
    - The output of this menu will need to satisfy the followings
        - Enough information for Display module to populate the display.
        - Enough information for our module to know what game settings we are on.

Board:
    - Here we stores constants using generic.
    - If the game starts, we take the inputs and start doing works.
    - The output will need to indicate the following:
        - Whether the game is over
        - Enough information to populate the display such as position of snakes
          and apples.

randomPos:
    - This module will randomly generate a x and y coordinate.

snakePos:
    - This module will take inputs and decide the next location of the snake
    - Perhaps the Module will also return an output that tells us whether the
        snake has collisioned with himself / border.

