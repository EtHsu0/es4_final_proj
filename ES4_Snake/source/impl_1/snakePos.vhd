library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- use IEEE.std_logic_arith.all;



entity snakepos is
    port (
        clk: in std_logic;
        
        digital_in: in unsigned(7 downto 0);
        
        game_state_in: in unsigned(1 downto 0);

        grow_snake_in: in std_logic;

        -- Direction should be 0-3 (Up, Down, Left, Right)
        --dir_in: in unsigned(1 downto 0) := "11"; 
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

TYPE DirType is (UP, DOWN, LEFT, RIGHT);
TYPE DirArray is ARRAY (0 to 99) of DirType;

signal prev_dir: unsigned(1 downto 0) := "11";
signal snake_dir: unsigned(1 downto 0);


signal arr_length: integer := 2;
-- From left to right, direction from head to tails
signal snake_dir_arr: DirArray := (others => LEFT); -- Errors! Fix Type Declarations
signal snake_arr: std_logic_vector(99 downto 0) := 99d"0";

signal snake_dead: std_logic := '0';
-- signal snake_coord: unsigned(7 downto 0);
signal counter: unsigned(29 downto 0) := 30d"0";
signal snakeCLK: std_logic;
signal slow_test_counter: unsigned(6 downto 0) := 7d"0";

signal dir_signal: unsigned(1 downto 0);
begin

    process(clk) is
        variable snake_coord: unsigned(6 downto 0);
    begin
        if rising_edge(clk) then
            counter <= counter + 1;
            if digital_in(3) = '0' then 
                dir_signal <= "00";
            elsif digital_in(2) = '0' then
                dir_signal <= "01";
            elsif digital_in(1) = '0' then
                dir_signal <= "10";
            elsif digital_in(0) = '0' then
                dir_signal <= "11";
            else
                dir_signal <= dir_signal;
            end if;

            snake_arr <= (others => '0');
            snake_coord := snake_head;
            snake_arr(to_integer(snake_coord)) <= '1';

            for i in 0 to 99 loop
              exit when i = arr_length;
              case snake_dir_arr(i) is
                 when UP => snake_coord := snake_coord - 10;
                 when DOWN => snake_coord := snake_coord + 10;
                 when LEFT => snake_coord := snake_coord - 1;
                 when RIGHT => snake_coord := snake_coord + 1;
              end case;
              snake_arr(to_integer(snake_coord)) <= '1';
            end loop;

            if prev_dir(1) /= dir_signal(1) then
                snake_dir <= dir_signal;
            end if;
        end if;
    end process;
    snakeCLK <= counter(22);

    process(snakeCLK) is

    begin
        if rising_edge(snakeCLK) then
            if game_state_in = "00" then
                -- snake_arr <= (44 downto 42 => '1', others => '0');
                snake_dead <= '0';
                arr_length <= 6;
                snake_head <= 8d"44";
                snake_dir_arr <= (others => LEFT);
            --snake_dir_arr(0) <= RIGHT;
            --	snake_dir_arr(1) <= UP;
            --	snake_dir_arr(2) <= UP;
            --snake_dir_arr(3) <= LEFT;
            elsif game_state_in = "01" then
                -- if prev_dir(1) /= dir_signal(1) then
                    -- prev_dir <= dir_signal;
                -- else
                    -- prev_dir <= prev_dir;
                -- end if;
                /*
                if grow_snake_in = '0' then
                    arr_length <= arr_length + 1;
                end if;
				*/
                
                prev_dir <= snake_dir;

                -- Update snake head coordinate
                if snake_dir = "00" then
                    if snake_head < 10 then
                        snake_dead <= '1';
                    end if;
                    snake_head <= snake_head - 10;
                    for i in 0 to 98 loop
                        snake_dir_arr(i + 1) <= snake_dir_arr(i);
                    end loop;
                    snake_dir_arr(0) <= DOWN;
                elsif snake_dir = "01" then
                    if snake_head > 89 then
                        snake_dead <= '1';
                    end if;
                    snake_head <= snake_head + 10;
                    for i in 0 to 98 loop
                        snake_dir_arr(i + 1) <= snake_dir_arr(i);
                    end loop;
                    snake_dir_arr(0) <= UP;
                elsif snake_dir = "10" then
                    if snake_head mod 10 = 0 then
                            snake_dead <= '1';
                    end if;
                    snake_head <= snake_head - 1;
                    for i in 0 to 98 loop
                        snake_dir_arr(i + 1) <= snake_dir_arr(i);
                    end loop;
                    snake_dir_arr(0) <= RIGHT;
                elsif snake_dir = "11" then
                    if snake_head mod 10 = 9 then
                        snake_dead <= '1';
                    end if;
                    snake_head <= snake_head + 1;
                    for i in 0 to 98 loop
                        snake_dir_arr(i + 1) <= snake_dir_arr(i);
                    end loop;
                    snake_dir_arr(0) <= LEFT;
                end if;
                
                /*
                case dir_signal is
                    when "00" => snake_arr <= (3 downto 0 => '1', others => '0');
                    when "01" => snake_arr <= (13 downto 10 => '1', others => '0');
                    when "10" => snake_arr <= (23 downto 20 => '1', others => '0');
                    when "11" => snake_arr <= (33 downto 30 => '1', others => '0');
                end case;
                */
            --else
                --snake_arr <= (73 downto 70 => '1', others => '0');
            end if;
        
        
            
        -- snake_tail <= snake_coord;
            -- snake_arr(to_integer(slow_test_counter)) <= '1';
            -- slow_test_counter <= slow_test_counter + 1;
        -- Check direction is valid
        --
        --     -- Convert to type

        --     -- Remove / update tail if we are not growing
        --     if grow_snake_in = '0' then
        --         arr_right <= arr_right - 1;
        --     end if;

            
            
        --     snake_dir_arr(to_integer(arr_left)) <= snake_dir;
        -- end if;

        -- snake_coord := snake_head;
        -- snake_arr(to_integer(snake_coord)) <= '1';

        -- for i in to_integer(arr_left) to to_integer(arr_right) loop
        --     case snake_dir_arr(i) is
        --         when UP => snake_coord := snake_coord - 10;
        --         when DOWN => snake_coord := snake_coord + 10;
        --         when LEFT => snake_coord := snake_coord - 1;
        --         when RIGHT => snake_coord := snake_coord + 1;
        --     end case;
        --     snake_arr(to_integer(snake_coord)) <= '1';
        -- end loop;
        -- snake_tail <= snake_coord;
        end if;
    end process;
    
    
    
    -- -- Draw the snake onto the 2d arra
    snake_dead_out <= snake_dead;

    snake_head_out <= snake_head;
    snake_arr_out <= snake_arr;
    snake_tail_out <= snake_tail;

end;
