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
        dir_in: in unsigned(1 downto 0); 
		-- Gabriel Note: dirtype is not defined, need to fix dirtype declaration or remove entirely
        -- 00 = up
        -- 01 = down
        -- 10 = left
        -- 11 = right
        snake_head_out: out unsigned(7 downto 0);
        snake_pos_out: out unsigned(99 downto 0) := 100b"0";
        
        snake_dead: out std_logic := '0'
    );
end snakePos;

architecture synth of snakePos is

signal snake_head: unsigned(7 downto 0) := 8d"44";

TYPE DirType is (UP, DOWN, LEFT, RIGHT); -- Need to fix this!
TYPE DirArray is ARRAY (0 to 99) of DirType;

signal prev_dir: unsigned(1 downto 0) := "11";
signal snake_dir: DirType;


signal arr_left: unsigned(7 downto 0) := (8d"96"); -- 0 (HEAD)
signal arr_right: unsigned(7 downto 0) := (8d"99"); -- 3 (TAIL)
-- From left to right, direction from head to tails
signal snake_array: DirArray := (others => RIGHT); -- Errors! Fix Type Declarations

signal snake_coord: unsigned(7 downto 0);

begin
    process(snakeCLK) is
    begin
        if rising_edge(snakeCLK) then
            if reset = '1' then
                arr_left <= 8d"96";
                arr_right <= 8d"99";
                snake_head <= 8d"44";
                snake_array <= (others => RIGHT);
            end if;
        -- Check direction is valid
            if prev_dir(1) /= dir_in(1) then
                prev_dir <= dir_in;
            end if;
            -- Convert to type
            case prev_dir is
                when "00" => snake_dir <= UP;
                when "01" => snake_dir <= DOWN;
                when "10" => snake_dir <= LEFT;
                when "11" => snake_dir <= RIGHT;
            end case;

            -- Remove / update tail if we are not growing
            if grow_snake = '0' then
                arr_right <= arr_right - 1;
            end if;

            -- Update snake head coordinate
            arr_left <= arr_left - 1;
            if snake_dir = UP then
                if snake_head < 10 then
                    snake_dead <= '1';
                end if;
                snake_head <= snake_head - 10;
            elsif snake_dir = DOWN then
                if snake_head > 89 then
                    snake_dead <= '1';
                end if;
                snake_head <= snake_head + 10;
            elsif snake_dir = LEFT then
                if snake_head mod 10 = 0 then
                    snake_dead <= '1';
                end if;
                snake_head <= snake_head - 1;
            elsif snake_dir = RIGHT then
                if snake_head mod 10 = 9 then
                    snake_dead <= '1';
                end if;
                snake_head <= snake_head + 1;
            end if;
            
            
            snake_array(to_integer(arr_left)) <= snake_dir;
            

        end if;
    end process;
	
	
    -- Draw the snake onto the 2d array
    process is 
    begin
        snake_coord <= snake_head;
        snake_pos_out(to_integer(snake_coord)) <= '1';

        for i in to_integer(arr_left) to to_integer(arr_right) loop
            case snake_array(i) is
                when UP => snake_coord <= snake_coord - 10;
                when DOWN => snake_coord <= snake_coord + 10;
                when LEFT => snake_coord <= snake_coord - 1;
                when RIGHT => snake_coord <= snake_coord + 1;
            end case;
            snake_pos_out(to_integer(snake_coord)) <= '1';
        end loop;
    end process;

end;
