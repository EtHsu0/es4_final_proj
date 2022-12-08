library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- use IEEE.std_logic_arith.all;

entity board is
    port (
        clk: in std_logic;
        digital_in: in unsigned(7 downto 0);
        -- 00 is RESET/BEGIN
        game_state_out: out unsigned(1 downto 0) := "00";
        snake_head_out: out unsigned(6 downto 0);
        apple_out: out unsigned(8 downto 0);
        -- Return whether snake is in each cell (0-99)
        snake_arr_out: out std_logic_vector(99 downto 0);
        scores_out: out unsigned(6 downto 0)
    );
end board;

architecture synth of board is
    component snakePos is
        port (
            clk: in std_logic;
            digital_in: in unsigned(7 downto 0);
            game_state_in: in unsigned(1 downto 0);
            snake_len_in: in unsigned(6 downto 0);

            --dir_in: in unsigned(1 downto 0); 
            snake_head_out: out unsigned(6 downto 0);
            snake_tail_out: out unsigned(6 downto 0);
            snake_arr_out: out std_logic_vector(99 downto 0) := 100b"0";
            
            snake_dead_out: out std_logic := '0'
        );
    end component;

    signal apple_id: unsigned (8 downto 0) := 9d"0";
    signal apple_coord: integer range 0 to 99:= 48;
    signal snake_head: unsigned (6 downto 0) := 7d"44";
    signal snake_tail: unsigned (6 downto 0) := 7d"0";
    signal snake_arr: std_logic_vector(99 downto 0) := 100d"0"; -- := (40 => '1', 41 => '1', 42 => '1'),(others => '0'); -- TODO: Fix Syntax Error!

    signal snake_len: unsigned(6 downto 0) := 7d"4";
    
    signal snake_dead: std_logic := '0';

    signal game_State : unsigned(1 downto 0) := "00";
    --signal game_state: unsigned(1 downto 0);
    signal apple_x: unsigned(3 downto 0);
    signal apple_y: unsigned(3 downto 0); 
begin
    process(clk) is
    begin
        if rising_edge(clk) then
            if game_state = "00" then
               -- apple_id <= 9b"1_0111_0100";
               apple_coord <= 48;
               snake_len <= 7d"4";
                if digital_in(4) = '0' then
                    game_state <= "01";
                end if;
            elsif game_state = "01" then
                if snake_head = to_unsigned(apple_coord, 7) then
                    snake_len <= snake_len + 1;
                    apple_coord <= to_integer(snake_tail);
                end if;
                --B
                if digital_in(6) = '0' then
                    apple_coord <= 66;
                end if;
                
                if digital_in(7) = '0' then
                    game_state <= "10";
                end if;
            elsif game_state <= "10" then
                apple_coord <= 99;
                if digital_in(5) = '0' then
                    game_state <= "00";
                end if;
            end if;
           apple_y <= (apple_coord mod 4d"10")
           apple_x <= (apple_coord / 4d"10")

            apple_id <= '1' & apple_x & apple_y;
        end if;
    end process;
    snakePos_inst: snakePos port map
        (
            clk => clk, 
            digital_in => digital_in,
            game_state_in => game_state, 
            snake_len_in => snake_len,
            snake_head_out => snake_head,
            snake_tail_out => snake_tail,
            snake_arr_out => snake_arr,
            snake_dead_out => snake_dead
		);
   

    game_state_out <= game_state;
    scores_out <= "0";
    snake_head_out <= snake_head;
    snake_arr_out <= snake_arr;
    apple_out <= apple_id;

end;
