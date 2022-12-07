library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- use IEEE.std_logic_arith.all;



entity snakepos is
    port (
        clk: in std_logic;
        reset_in: in std_logic;

        grow_snake_in: in std_logic;

        -- Direction should be 0-3 (Up, Down, Left, Right)
        dir_in: in unsigned(1 downto 0); 
		-- Gabriel Note: dirtype is not defined, need to fix dirtype declaration or remove entirely
        -- 00 = up
        -- 01 = down
        -- 10 = left
        -- 11 = right
        snake_head_out: out unsigned(6 downto 0);
        snake_tail_out: out unsigned(6 downto 0);
        snake_arr_out: out std_logic_vector(99 downto 0) := 100b"0";
        
        snake_dead_out: out std_logic := '0'
    );
end snakepos;

architecture synth of snakepos is

signal snake_head: unsigned(6 downto 0) := 7d"44";
signal snake_tail: unsigned(6 downto 0) := 7d"42";

TYPE DirType is (UP, DOWN, LEFT, RIGHT); -- Need to fix this!
TYPE DirArray is ARRAY (0 to 99) of DirType;

signal prev_dir: unsigned(1 downto 0) := "11";
signal snake_dir: DirType;


signal arr_left: unsigned(6 downto 0) := 7d"96"; -- 0 (HEAD)
signal arr_right: unsigned(6 downto 0) := 7d"99"; -- 3 (TAIL)
-- From left to right, direction from head to tails
signal dir_arr: DirArray := (others => RIGHT); -- Errors! Fix Type Declarations
signal snake_arr: std_logic_vector(99 downto 0) := 99d"0";

signal snake_dead: std_logic := '0';
-- signal snake_coord: unsigned(7 downto 0);
signal counter: unsigned(29 downto 0) := 30d"0";
signal snakeCLK: std_logic;
signal slow_test_counter: unsigned(6 downto 0) := 7d"0";
begin
    process(clk) is
    begin
        if rising_edge(clk) then
            counter <= counter + 1;
        end if;
    end process;
    snakeCLK <= counter(23);

    process(snakeCLK) is
    begin
        if rising_edge(snakeCLK) then
            snake_arr(to_integer(slow_test_counter)) <= '1';
            slow_test_counter <= slow_test_counter + 1;
            if reset_in = '1' then
                slow_test_counter <= 0;
                arr_left <= 8d"96";
                arr_right <= 8d"99";
                snake_head <= 8d"44";
                dir_arr <= (others => RIGHT);
                snake_arr <= (44 downto 42 => '1', others => '0');
			end if;
                -- for i in 99 downto 0 loop
                                --     snake_arr(i) <= '0';
                -- end loop;
        -- -- Check direction is valid
        --     if prev_dir(1) /= dir_in(1) then
        --         prev_dir <= dir_in;
        --     end if;
        --     -- Convert to type
        --     case prev_dir is
        --         when "00" => snake_dir <= UP;
        --         when "01" => snake_dir <= DOWN;
        --         when "10" => snake_dir <= LEFT;
        --         when "11" => snake_dir <= RIGHT;
        --     end case;

        --     -- Remove / update tail if we are not growing
        --     if grow_snake_in = '0' then
        --         arr_right <= arr_right - 1;
        --     end if;

        --     -- Update snake head coordinate
        --     arr_left <= arr_left - 1;
        --     if snake_dir = UP then
        --         if snake_head < 10 then
        --             snake_dead <= '1';
        --         end if;
        --         snake_head <= snake_head - 10;
        --     elsif snake_dir = DOWN then
        --         if snake_head > 89 then
        --             snake_dead <= '1';
        --         end if;
        --         snake_head <= snake_head + 10;
        --     elsif snake_dir = LEFT then
        --         if snake_head mod 10 = 0 then
        --             snake_dead <= '1';
        --         end if;
        --         snake_head <= snake_head - 1;
        --     elsif snake_dir = RIGHT then
        --         if snake_head mod 10 = 9 then
        --             snake_dead <= '1';
        --         end if;
        --         snake_head <= snake_head + 1;
        --     end if;
            
            
        --     dir_arr(to_integer(arr_left)) <= snake_dir;
        end if;
    end process;
	
	
	
    -- -- Draw the snake onto the 2d array
    -- process (snake_head, dir_arr) is
    --     variable snake_coord: unsigned(6 downto 0);
    -- begin
    --     snake_coord := snake_head;
    --     snake_arr(to_integer(snake_coord)) <= '1';

    --     for i in to_integer(arr_left) to to_integer(arr_right) loop
    --         case dir_arr(i) is
    --             when UP => snake_coord := snake_coord - 10;
    --             when DOWN => snake_coord := snake_coord + 10;
    --             when LEFT => snake_coord := snake_coord - 1;
    --             when RIGHT => snake_coord := snake_coord + 1;
    --         end case;
    --         snake_arr(to_integer(snake_coord)) <= '1';
    --     end loop;
    --     snake_tail <= snake_coord;
    -- end process;

    snake_dead_out <= snake_dead;

    snake_head_out <= snake_head;
    snake_arr_out <= snake_arr;
    snake_tail_out <= snake_tail;

end;
