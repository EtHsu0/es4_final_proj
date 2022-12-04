library IEEE;
use IEEE.math_real.uniform;
use IEEE.math_real.floor;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- use IEEE.std_logic_arith.all;

entity snakePos is
    port (
        clk: in std_logic;

        -- Whether to continue the game
        enable: in std_logic;
        -- Direction should be 0-3 (Up, Down, Left, Right)
        dir: in std_logic_vector(2 downto 0);
        -- 00 = up
        -- 01 = down
        -- 10 = left
        -- 11 = right
        snake_head_coord: out std_logic_vector(7 downto 0);
        snake_pos: out std_logic_vector(99 downto 0);
    );
end snakePos;

architecture synth of snakePos is

signal counter: unsigned(29 downto 0) := 29d"0";
signal snakeCLK: std_logic

signal snake_dir: std_logic_vector(2 downto 0);
signal snake_head: std_logic_vector(7 downto 0);
signal snake_tail: std_logic_vector(7 downto 0);
signal snake_pos_grid: std_logic_vector(99 downto 0);
begin
    process (clk) is
    begin
        if rising_edge(clk) then
            counter <= counter + '1';
        end if;
    end process;

    snakeClk <= counter(29);

    process(snakeCLK) is
    begin
        if rising_edge(snakeCLK) then
            -- Check direction is valid
            if snake_dir(1) /= dir(1) then
                snake_dir <= dir;
            end if;
            
            -- Remove / update tail
            

        end if;
    end process;
	-- Update the snake head position, use that information to check collision with apple
		-- If collieded with apple, set a state and generate anoother apple.
	-- snakePos -> Get updated snake position based on the new head position
	-- Check collision with body / wall based on the new snake position
	
end;
