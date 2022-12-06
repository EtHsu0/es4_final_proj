library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- use IEEE.std_logic_arith.all;

entity board is
    port (
        clk: in std_logic;
        -- 00 is RESET/BEGIN
        game_state: out unsigned(1 downto 0) := "00";

        digital_in: in unsigned(7 downto 0);

        snake_head_out: out unsigned(6 downto 0);
        -- Return the cell ID (0-99)
        apple_out: out unsigned(8 downto 0);
        
        -- Return whether snake is in each cell (0-99)
        snake_arr_out: out std_logic_vector(99 downto 0);

        scores_out: out unsigned(6 downto 0)
    );
end board;

architecture synth of board is
    component snakePos is
        port (
            snakeCLK: in std_logic;
            reset: in std_logic;
    
            grow_snake: in std_logic;

            dir_in: in unsigned(1 downto 0); 
            -- 00 = up
            -- 01 = down
            -- 10 = left
            -- 11 = right
            snake_head_out_out: out unsigned(7 downto 0);
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

    signal apple_id: unsigned (7 downto 0) := 8d"0";
    signal snake_head: unsigned (6 downto 0);
    signal snake_array: std_logic_vector(99 downto 0); -- := (40 => '1', 41 => '1', 42 => '1'),(others => '0'); -- TODO: Fix Syntax Error!
    signal counter: unsigned (29 downto 0) := 30d"0";
    signal reset: std_logic := '1';
    signal growSnake: std_logic := '0';

    TYPE buttons is (A, B, START, SEL, UP, DOWN, LEFT, RIGHT);
    signal button: buttons;
    -- Gabe / Chris TODO, turn NES digital_in -> buttons TYPE

    signal dir: unsigned(1 to 0);
    -- I need to convert button to dir;
    signal snake_dead: std_logic;
    --signal game_state: unsigned(1 downto 0);

    signal enable: std_logic := '0';
begin
    process(clk) is
    begin
        if rising_edge(clk) then
            counter <= counter + 1;
        end if;
    end process;

    dir <= "00" when digital_in(3) = '0' else
           "01" when digital_in(2) = '0' else
           "10" when digital_in(1) = '0' else
           "11";

    snakePos_inst: snakePos port map (counter(29),reset,growSnake,dir,snake_head,snake_arr_out,snake_dead);

    apple_random: randomPos port map (enable, clk, apple_out);

    -- Check collision with apple
    process (snake_head) is begin
        -- If snake head is on apple's coordinate
        if snake_head_out = apple_out then
            -- Create artifical rising edge for enable signal
            enable <= '0';
            wait for 5 ns;
            enable <= '1';
            -- Create this signal until we generate a valid apple id (apple can not spawn on snake)
            --while (snake(apple_out) = '1' or apple_out = snake_head_out) loop
                --enable <= '0';
                --wait for 5 ns;
                --enable <= '1';
            --end loop;
        end if;
    end process;
    game_state <= "00";
    scores_out <= "0";
    snake_head_out <= snake_head;
end;
