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
            grow_snake_in: in std_logic;
            snake_len_in: in unsigned(6 downto 0);

            --dir_in: in unsigned(1 downto 0); 
            snake_head_out: out unsigned(6 downto 0);
            snake_tail_out: out unsigned(6 downto 0);
            snake_arr_out: out std_logic_vector(99 downto 0) := 100b"0";
            
            snake_dead_out: out std_logic := '0'
        );
    end component;

    signal apple_id: unsigned (8 downto 0) := 9d"0";
    signal snake_head: unsigned (6 downto 0) := 7d"44";
    signal snake_tail: unsigned (6 downto 0) := 7d"0";
    signal snake_arr: std_logic_vector(99 downto 0) := 100d"0"; -- := (40 => '1', 41 => '1', 42 => '1'),(others => '0'); -- TODO: Fix Syntax Error!
    signal reset: std_logic := '1';
    signal grow_snake: std_logic := '0';

    signal snake_len: unsigned(6 downto 0) := 7d"2";

    TYPE buttons is (A, B, START, SEL, UP, DOWN, LEFT, RIGHT, NONE);
    signal button: buttons;

    signal dir: unsigned(1 to 0);
    
    signal dir_snake: unsigned(1 to 0);
    -- I need to convert button to dir;
    signal snake_dead: std_logic;

    signal game_State : unsigned(1 downto 0) := "00";
    --signal game_state: unsigned(1 downto 0);

    signal enable: std_logic := '0';
    
begin
    process(clk) is
    begin
        if rising_edge(clk) then
            if game_state = "00" then
               apple_id <= 9b"1_0111_0100";
                if digital_in(4) = '0' then
                    game_state <= "01";
                end if;
            elsif game_state = "01" then
                reset <= '0';
                -- RIGHT
                if digital_in(0) = '0' then
                    apple_id <= 9b"1_0100_0100";
                    --dir <= 2b"11";
                -- LEFT
                elsif digital_in(1) = '0' then
                    apple_id <= 9b"1_0101_0101";
                    --dir <= 2b"10";
                -- DOWN
                elsif digital_in(2) = '0' then
                    apple_id <= 9b"1_0101_0100";
                    --dir <= 2b"01";
                -- UP
                elsif digital_in(3) = '0' then
                    apple_id <= 9b"1_0100_0101";
                     -- dir <= 2b"00";
                -- SEL
                elsif digital_in(5) = '0' then
                    game_state <= "10";
                -- A
                elsif digital_in(7) = '0' then
                    snake_len <= snake_len + 1;
                    apple_id <= 9b"1_1001_0000";
                else
                    apple_id <= apple_id;
                    --dir <= dir;
                end if;
                -- if snake_dead <= '1' then
                --     game_state <= "10";
                -- end if;
            elsif game_state = "10" then
                apple_id <= 9b"1_1001_1001";
                if digital_in(6) = '0' then
                    game_state <= "00";
                end if;
            end if;
        end if;
    end process;
    -- dir_snake <= dir;
    --reset <= '1' when button = START else '0'

    snakePos_inst: snakePos port map
        (
            clk => clk, 
            digital_in => digital_in,
            game_state_in => game_state, 
            grow_snake_in => grow_snake,
            snake_len_in => snake_len,
            snake_head_out => snake_head,
            snake_tail_out => snake_tail,
            snake_arr_out => snake_arr,
            snake_dead_out => snake_dead
		);
    --process (snake_head) is begin
        -- If snake head is on apple's coordinate
        --if snake_head_out = apple_out then
            -- Create artifical rising edge for enable signal
            --enable <= '0';
            --wait for 5 ns;
            --enable <= '1';
            -- Create this signal until we generate a valid apple id (apple can not spawn on snake)
            --while (snake(apple_out) = '1' or apple_out = snake_head_out) loop
                --enable <= '0';
                --wait for 5 ns;
                --enable <= '1';
            --end loop;
        --end if;
   -- end process;
    game_state_out <= game_state;
    scores_out <= "0";
    snake_head_out <= snake_head;
    snake_arr_out <= snake_arr;
    apple_out <= apple_id;

end;
