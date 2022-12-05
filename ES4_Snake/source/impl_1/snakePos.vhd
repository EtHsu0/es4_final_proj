library IEEE;
use IEEE.math_real.uniform;
use IEEE.math_real.floor;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- use IEEE.std_logic_arith.all;



entity snakePos is
    port (
        snakeCLK: in std_logic;
        reset: in std_logic;

        grow_snake: in std_logic;

        -- Direction should be 0-3 (Up, Down, Left, Right)
        dir: in std_logic_vector(1 downto 0); 
		-- Gabriel Note: dirtype is not defined, need to fix dirtype declaration or remove entirely
        -- 00 = up
        -- 01 = down
        -- 10 = left
        -- 11 = right
        snake_head_out: out std_logic_vector(7 downto 0);
        snake_pos_out: out std_logic_vector(99 downto 0);
        
    );
end snakePos;

architecture synth of snakePos is

signal snake_dir: std_logic_vector(2 downto 0) := "11";
signal snake_head: std_logic_vector(7 downto 0);
signal snake_tail: std_logic_vector(7 downto 0);

TYPE DirType is (UP, DOWN, LEFT, RIGHT); -- Need to fix this!
TYPE DirArray is ARRAY (0 to 99) of DirType;

signal pos_dir_left: unsigned(7 downto 0) := (8d"124"); -- 0 (HEAD)
signal pos_dir_right: unsigned(7 downto 0) := (8d"127"); -- 3 (TAIL)
-- From left to right, direction from head to tails
signal snake_array: DirArray := (others => RIGHT); -- Errors! Fix Type Declarations
-- signal snake_array: DirArray; -- temp replacement

begin
    process(snakeCLK) is
    begin
        if rising_edge(snakeCLK) then
            -- Check direction is valid
            if snake_dir(1) /= dir(1) then
                snake_dir <= dir;
            end if;

            -- Remove / update tail if we are not growing
            if grow_snake = '0' then
                pos_dir_right <= pos_dir_right - 1;
            end if;

            -- Update snake head coordinate
            case snake_dir is
                when LEFT => snake_head <= snake_head - 1, 
                                snake_array(pos_dir_left - 1) <= LEFT;
            end case;

            

        end if;
    end process;

    process is begin

    end process;
	
end;
