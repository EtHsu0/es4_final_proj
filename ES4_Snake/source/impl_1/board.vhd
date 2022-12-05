library IEEE;
use IEEE.math_real.uniform;
use IEEE.math_real.floor;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- use IEEE.std_logic_arith.all;

entity board is
        port (
            clk: in std_logic;
            digital: in std_logic_vector(7 downto 0);

            snake_head: out unsigned(7 downto 0);
            -- Return the cell ID (0-99)
            apple_id: out unsigned(7 downto 0);
            -- Return whether snake is in each cell (0-99)
            snake: out unsigned(99 downto 0)
        );
end board;

architecture synth of board is
    component randomPos is
        port (
            enable: in std_logic;
            clk: in std_logic;
            coord: in unsigned(7 downto 0);
            bound: in unsigned(10 downto 0);
            out_coord: out unsigned(7 downto 0)
        );
    end component;

    
    component snakePos is
        port (
            snakeCLK: in std_logic;
            reset: in std_logic;
    
            grow_snake: in std_logic;
    
            -- Direction should be 0-3 (Up, Down, Left, Right)
            dir_in: in std_logic_vector(1 downto 0); 
            -- Gabriel Note: dirtype is not defined, need to fix dirtype declaration or remove entirely
            -- 00 = up
            -- 01 = down
            -- 10 = left
            -- 11 = right
            snake_head_out: out std_logic_vector(7 downto 0);
            snake_pos_out: out std_logic_vector(99 downto 0) := 100b"0";
            
            snake_dead: out std_logic := '0'
        );
    end component;

    component randomPos is
        port (
                enable: in std_logic;
                clk: in std_logic;
                out_coord: out unsigned(7 downto 0)
        );
    end component;

    signal apple: unsigned (7 downto 0) := 8d"0";
    signal snakePosition: unsigned(99 downto 0) -- := (40 => '1', 41 => '1', 42 => '1'),(others => '0'); -- TODO: Fix Syntax Error!
    signal counter: unsigned (29 downto 0) := 30d"0";
    signal reset: std_logic := '0';
    signal growSnake: std_logic := '0';

    TYPE buttons is (A, B, START, SEL, UP, DOWN, LEFT, RIGHT);
    signal button: buttons;
    -- Gabe / Chris TODO, turn NES digital -> buttons TYPE

    signal dir: std_vector_logic(1 to 0);
    -- I need to convert button to dir;
    signal snake_dead: std_logic;
    signal game_state: std_logic_vector(1 downto 0);

    signal enable: std_logic := '0';
begin
    if rising_edge(clk) then
        counter <= counter + 1;
    end if;

    snakePos_inst: snakePos port map (
        counter(29),
        reset,
        dir,
        snake_head,
        snake,
        snake_dead,
    )

    apple_random: randomPos port map (
        enable, 
        clk, 
        apple_id
    );

    -- Check collision with apple
    process is begin
        -- If snake head is on apple's coordinate
        if snake_head = apple_id then
            -- Create artifical rising edge for enable signal
            enable <= '0';
            wait for 5 ns;
            enable <= '1';
            -- Create this signal until we generate a valid apple id (apple can not spawn on snake)
            while (snake(apple_id) = '1' or apple_id = snake_head) loop
                enable <= '0';
                wait for 5 ns;
                enable <= '1';
            end loop;
        end if;
    end process;

    -- Update the snake head position, use that information to check collision with apple
        -- If collieded with apple, set a state and generate anoother apple.
    -- snakePos -> Get updated snake position based on the new head position
    -- Check collision with body / wall based on the new snake position
    
end;
