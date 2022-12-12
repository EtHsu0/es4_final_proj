library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- use IEEE.std_logic_arith.all;



entity snakepos is
    port (
        clk: in std_logic;
        
        digital_in: in unsigned(7 downto 0);
        
        game_state_in: in unsigned(1 downto 0);

        snake_len_in: in unsigned(6 downto 0) := 7d"1";

        snake_head_out: out unsigned(6 downto 0);
        snake_tail_out: out unsigned(6 downto 0);
        snake_arr_out: out std_logic_vector(99 downto 0) := 100b"0";
        
        snake_dead_out: out std_logic := '0'
    );
end snakepos;

architecture synth of snakepos is

signal snake_head: unsigned(6 downto 0) := 7d"44";
signal snake_tail: unsigned(6 downto 0) := 7d"43";

TYPE DirType is (UP, DOWN, LEFT, RIGHT, NONE);
TYPE DirArray is ARRAY (0 to 99) of DirType;

signal prev_dir: unsigned(1 downto 0) := "11";
signal snake_dir: unsigned(1 downto 0);

-- From left to right, direction from head to tails
signal snake_dir_arr: DirArray := (99 downto 1 => NONE, 0 downto 0 => LEFT); -- Errors! Fix Type Declarations
signal snake_arr: std_logic_vector(99 downto 0) := 100d"0";

signal snake_dead: std_logic := '0';
-- signal snake_coord: unsigned(7 downto 0);
signal counter: unsigned(29 downto 0) := 30d"0";
signal snakeCLK: std_logic;

signal reset: std_logic := '0';
signal dir_signal: unsigned(1 downto 0);
begin
    --arr_length <= snake_arr_len;
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
            --snake_arr(to_integer(snake_coord)) <= '1';

            for i in 0 to 20 loop
            --   exit when i = to_integer(snake_len_in);
                case snake_dir_arr(i) is
                    when UP => snake_coord := snake_coord - 10;
                    when DOWN => snake_coord := snake_coord + 10;
                    when LEFT => snake_coord := snake_coord - 1;
                    when RIGHT => snake_coord := snake_coord + 1;
                    when NONE => snake_coord := snake_coord;
                end case;
                snake_arr(to_integer(snake_coord)) <= '1';
            end loop;
            snake_tail <= snake_coord;
            if prev_dir(1) /= dir_signal(1) then
                snake_dir <= dir_signal;
            end if;
        end if;
    end process;
    snakeCLK <= counter(22);

    process(snakeCLK) is
    begin
        if rising_edge(snakeCLK) then
            if game_state_in = "00" or game_state_in = "10" or reset = '1' then
                snake_dead <= '0';
                snake_head <= 7d"44";
                snake_dir_arr <=  (99 downto 1 => NONE, 0 downto 0 => LEFT);
                reset <= '0';
                prev_dir <= "11";
            elsif game_state_in = "01" then
                prev_dir <= snake_dir;

                -- Update snake head coordinate
                if snake_dir = "00" then
                    if snake_head < 10 then
                        snake_dead <= '1';
                        reset <= '1';
                    end if;
                    snake_head <= snake_head - 10;
                    for i in 0 to 6 loop
                        snake_dir_arr(i + 1) <= snake_dir_arr(i);
                    end loop;
                    snake_dir_arr(0) <= DOWN;
                elsif snake_dir = "01" then
                    if snake_head > 89 then
                        snake_dead <= '1';
                        reset <= '1';
                    end if;
                    snake_head <= snake_head + 10;
                    for i in 0 to 6 loop
                        snake_dir_arr(i + 1) <= snake_dir_arr(i);
                    end loop;
                    snake_dir_arr(0) <= UP;
                elsif snake_dir = "10" then
                    if snake_head mod 10 = 0 then
                        snake_dead <= '1';
                        reset <= '1';
                    end if;
                    snake_head <= snake_head - 1;
                    for i in 0 to 6 loop
                        snake_dir_arr(i + 1) <= snake_dir_arr(i);
                    end loop;
                    snake_dir_arr(0) <= RIGHT;
                elsif snake_dir = "11" then
                    if snake_head mod 10 = 9 then
                        snake_dead <= '1';
                        reset <= '1';
                    end if;
                    snake_head <= snake_head + 1;
                    for i in 0 to 6 loop
                        snake_dir_arr(i + 1) <= snake_dir_arr(i);
                    end loop;
                    snake_dir_arr(0) <= LEFT;
                end if;
                snake_dir_arr(to_integer(snake_len_in)) <= NONE;
                if snake_arr(to_integer(snake_head)) = '1' then
                    snake_dead <= '1';
                    reset <= '1';
                end if;
            end if;
        end if;
    end process;
    
    
    
    snake_dead_out <= snake_dead;

    snake_head_out <= snake_head;
    snake_arr_out <= snake_arr;
    snake_tail_out <= snake_tail;

end;
