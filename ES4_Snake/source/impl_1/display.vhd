library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity display is
    port(
        pll_in_clock : in std_logic; -- pin 20, shorted to the 12 MHz pin on the UPduino
        pll_outcore_o : out std_logic; -- pin 21, for testing purposes

        HSYNC : out std_logic; -- pin 46
        VSYNC : out std_logic; -- pin 2
        
        rgb : out unsigned(5 downto 0); -- pins 47, 45, 48, 3, 4, 44

        -- Game logic
        apple: in unsigned(6 downto 0);
        snake_head: in unsigned(6 downto 0);
        snake: in std_logic_vector(99 downto 0);
        scores: in unsigned(6 downto 0);
        game_state: in unsigned(1 downto 0)
    ); 
end display;

architecture synth of display is
component mypll is
port(
    ref_clk_i: in std_logic; -- input clock, set to pin 20 that is shorted to the 12 MHz pin on the UPduino
    rst_n_i: in std_logic; -- reset (active low), set to '1' so does not reset
    outcore_o: out std_logic; -- output to pins: IMPORTANT 25.1 MHz is our clock
    outglobal_o: out std_logic -- output for clock network
);
end component;

component vga is 
port(
    clk : in std_logic; -- 25.1 MHz clock
    valid : out std_logic; -- valid is '0' when the VGA's RGB must be low for front/back porch and sync pulse
    y_pos : out unsigned(9 downto 0); -- current y position (row count) of pixel that the VGA is drawing
    x_pos : out unsigned(9 downto 0); -- current x position (column count) of pixel that the VGA is drawing
    HSYNC : out std_logic; -- hsync signal
    VSYNC : out std_logic -- vsync signal
);
end component;

component pattern_gen is
	port(
		valid : in std_logic; -- when valid is 0, all RGB output must be low
		y_pos : in unsigned(9 downto 0); -- current y position (row) of the pixel that the VGA is drawing
		x_pos : in unsigned(9 downto 0); -- current x position (column) of the pixel that the VGA is drawing
		apple : in unsigned(6 downto 0);
		snake_location : in std_logic_vector(99 downto 0);
        --score : in unsigned(5 downto 0);
		rgb : out unsigned(5 downto 0);
        snake_head: in unsigned(6 downto 0);
        pll_in_clock : in std_logic;
        game_state: in unsigned(1 downto 0)
	);
end component;

component nine_segments is
    port (
        row : in unsigned (9 downto 0);
        col : in unsigned (9 downto 0);
        clk : in std_logic;
        rgb : out unsigned(5 downto 0)
    );
end component;

component eight_segments is
    port (
        row : in unsigned (9 downto 0);
        col : in unsigned (9 downto 0);
        clk : in std_logic;
        rgb : out unsigned(5 downto 0)
    );
end component;
-- internal variables
signal clk : std_logic; -- 25.1 MHz clock
-- rows need to go up to 525 (visible area is 480)
signal row_cnt : unsigned(9 downto 0);

component seven_segments is
    port (
        row : in unsigned (9 downto 0);
        col : in unsigned (9 downto 0);
        clk : in std_logic;
        rgb : out unsigned(5 downto 0)
    );
end component;

component six_segments is
    port (
        row : in unsigned (9 downto 0);
        col : in unsigned (9 downto 0);
        clk : in std_logic;
        rgb : out unsigned(5 downto 0)
    );
end component;

component five_segments is
    port (
        row : in unsigned (9 downto 0);
        col : in unsigned (9 downto 0);
        clk : in std_logic;
        rgb : out unsigned(5 downto 0)
    );
end component;

component four_segments is
    port (
        row : in unsigned (9 downto 0);
        col : in unsigned (9 downto 0);
        clk : in std_logic;
        rgb : out unsigned(5 downto 0)
    );
end component;

component three_segments is
    port (
        row : in unsigned (9 downto 0);
        col : in unsigned (9 downto 0);
        clk : in std_logic;
        rgb : out unsigned(5 downto 0)
    );
end component;

component two_segments is
    port (
        row : in unsigned (9 downto 0);
        col : in unsigned (9 downto 0);
        clk : in std_logic;
        rgb : out unsigned(5 downto 0)
    );
end component;

component one_segments is
    port (
        row : in unsigned (9 downto 0);
        col : in unsigned (9 downto 0);
        clk : in std_logic;
        rgb : out unsigned(5 downto 0)
    );
end component;

component zero_segments is
    port (
        row : in unsigned (9 downto 0);
        col : in unsigned (9 downto 0);
        clk : in std_logic;
        rgb : out unsigned(5 downto 0)
    );
end component;

component gapple is
    port (
        row : in unsigned (9 downto 0);
        col : in unsigned (9 downto 0);
        clk : in std_logic;
        rgb : out unsigned(5 downto 0)
    );
end component;


-- columns need to go up to 799 (visible area is 640)
signal column_cnt : unsigned(9 downto 0); 
signal valid : std_logic;

-- intermediate rgb for the actual grid
signal intermed_rgb : unsigned(5 downto 0);

signal rgb_nine_tenth : unsigned(5 downto 0);
signal rgb_nine_ones : unsigned(5 downto 0);

signal rgb_eight_tenth : unsigned(5 downto 0);
signal rgb_eight_ones : unsigned(5 downto 0);

signal rgb_seven_tenth : unsigned(5 downto 0);
signal rgb_seven_ones : unsigned(5 downto 0);

signal rgb_six_tenth : unsigned(5 downto 0);
signal rgb_six_ones : unsigned(5 downto 0);

signal rgb_five_tenth : unsigned(5 downto 0);
signal rgb_five_ones : unsigned(5 downto 0);

signal rgb_four_tenth : unsigned(5 downto 0);
signal rgb_four_ones : unsigned(5 downto 0);

signal rgb_three_tenth : unsigned(5 downto 0);
signal rgb_three_ones : unsigned(5 downto 0);

signal rgb_two_tenth : unsigned(5 downto 0);
signal rgb_two_ones : unsigned(5 downto 0);

signal rgb_one_tenth : unsigned(5 downto 0);
signal rgb_one_ones : unsigned(5 downto 0);

signal rgb_zero_tenth : unsigned(5 downto 0);
signal rgb_zero_ones : unsigned(5 downto 0);

signal score_tensplace : unsigned(13 downto 0);
signal score_highBCD : unsigned(4 downto 0);

signal rgb_gapple: unsigned(5 downto 0);
signal apple_row_translate: unsigned(16 downto 0);
signal apple_col_translate: unsigned(9 downto 0);


begin
    pll_init: mypll port map(ref_clk_i => pll_in_clock, rst_n_i => '1', outcore_o => pll_outcore_o, outglobal_o => clk);
    -- vga_initial vga port map(clk <= clk);
    vga_init: vga port map(clk, valid, row_cnt, column_cnt, HSYNC, VSYNC);
	
	nine_tenth_init: nine_segments port map(row => (row_cnt - 64), col => (column_cnt - 30), clk => clk, rgb => rgb_nine_tenth);
	nine_ones_init: nine_segments port map(row => (row_cnt - 64), col => (column_cnt - 54), clk => clk, rgb => rgb_nine_ones);
	
	eight_tenth_init: eight_segments port map(row => (row_cnt - 64), col => (column_cnt - 30), clk => clk, rgb => rgb_eight_tenth);
	eight_ones_init: eight_segments port map(row => (row_cnt - 64), col => (column_cnt - 54), clk => clk, rgb => rgb_eight_ones);
	
	seven_tenth_init: seven_segments port map(row => (row_cnt - 64), col => (column_cnt - 30), clk => clk, rgb => rgb_seven_tenth);
	seven_ones_init: seven_segments port map(row => (row_cnt - 64), col => (column_cnt - 54), clk => clk, rgb => rgb_seven_ones);
	
	six_tenth_init: six_segments port map(row => (row_cnt - 64), col => (column_cnt - 30), clk => clk, rgb => rgb_six_tenth);
	six_ones_init: six_segments port map(row => (row_cnt - 64), col => (column_cnt - 54), clk => clk, rgb => rgb_six_ones);
	
	five_tenth_init: five_segments port map(row => (row_cnt - 64), col => (column_cnt - 30), clk => clk, rgb => rgb_five_tenth);
	five_ones_init: five_segments port map(row => (row_cnt - 64), col => (column_cnt - 54), clk => clk, rgb => rgb_five_ones);
	
	four_tenth_init: four_segments port map(row => (row_cnt - 64), col => (column_cnt - 30), clk => clk, rgb => rgb_four_tenth);
	four_ones_init: four_segments port map(row => (row_cnt - 64), col => (column_cnt - 54), clk => clk, rgb => rgb_four_ones);
	
	three_tenth_init: three_segments port map(row => (row_cnt - 64), col => (column_cnt - 30), clk => clk, rgb => rgb_three_tenth);
	three_ones_init: three_segments port map(row => (row_cnt - 64), col => (column_cnt - 54), clk => clk, rgb => rgb_three_ones);
	
	two_tenth_init: two_segments port map(row => (row_cnt - 64), col => (column_cnt - 30), clk => clk, rgb => rgb_two_tenth);
	two_ones_init: two_segments port map(row => (row_cnt - 64), col => (column_cnt - 54), clk => clk, rgb => rgb_two_ones);
	
	one_tenth_init: one_segments port map(row => (row_cnt - 64), col => (column_cnt - 30), clk => clk, rgb => rgb_one_tenth);
	one_ones_init: one_segments port map(row => (row_cnt - 64), col => (column_cnt - 54), clk => clk, rgb => rgb_one_ones);
	
	zero_tenth_init: zero_segments port map(row => (row_cnt - 64), col => (column_cnt - 30), clk => clk, rgb => rgb_zero_tenth);
	zero_ones_init: zero_segments port map(row => (row_cnt - 64), col => (column_cnt - 54), clk => clk, rgb => rgb_zero_ones);
	
	gapple_init: gapple port map(row => (row_cnt - apple_row_translate(9 downto 0)), col => (column_cnt - apple_col_translate), clk => clk, rgb => rgb_gapple);

	
    pattern_gen_initial: pattern_gen port map(
        valid => valid, 
        y_pos => row_cnt, 
        x_pos => column_cnt, 
        apple => apple, 
        snake_location => snake, 
        --score => scores, 
        rgb => intermed_rgb,
        snake_head => snake_head,
        pll_in_clock => pll_in_clock,
        game_state => game_state);
    
		apple_col_translate <= 10d"102" + 44 * (to_integer(apple) mod 10);
		apple_row_translate <=  10d"21" + 10d"44" * (apple / 10d"10");
		
		
	process(clk) begin
	if rising_edge(clk) then
		if (column_cnt > 95 and valid = '1') then
		-- display gapple
			if (column_cnt > 10d"102" + 10d"44" * (apple mod 10d"10")) and (column_cnt < 10d"99" + 10d"44" + 10d"44" * (apple mod 10d"10")) and (row_cnt > 10d"21" + 10d"44" * (apple / 10d"10")) and (row_cnt < 10d"19" + 10d"44" + 10d"44" * (apple / 10d"10")) then
				rgb <= rgb_gapple;
			else
				rgb <= intermed_rgb;
			end if;
		else
			rgb <= "000000";
			
			-- display scores
			score_tensplace <= scores * 7d"52";
			score_highBCD <= score_tensplace(13 downto 9);
			-- tens digit
			if (column_cnt < 47 and column_cnt > 30 and row_cnt > 63 and row_cnt < 96 and valid = '1') then
				if score_highBCD = 7d"9" then
					rgb <= rgb_nine_tenth;
				elsif score_highBCD = 7d"8" then 
					rgb <= rgb_eight_tenth;	
				elsif score_highBCD = 7d"7" then 
					rgb <= rgb_seven_tenth;	
				elsif score_highBCD = 7d"6" then 
					rgb <= rgb_six_tenth;
				elsif score_highBCD = 7d"5" then 
					rgb <= rgb_five_tenth;	
				elsif score_highBCD = 7d"4" then 
					rgb <= rgb_four_tenth;
					
				elsif score_highBCD = 7d"3" then 
					rgb <= rgb_three_tenth;
				elsif score_highBCD = 7d"2" then
					rgb <= rgb_two_tenth;
				elsif score_highBCD = 7d"1" then
					rgb <= rgb_one_tenth;
				else
					rgb <= "000000";
				end if;
			end if;
			
			-- ones digit
			if (column_cnt < 71 and column_cnt > 54 and row_cnt > 63 and row_cnt < 96 and valid = '1') then
				if scores mod 7d"10" = 7d"9" then
					rgb <= rgb_nine_ones;
				elsif scores mod 7d"10" = 7d"8" then
					rgb <= rgb_eight_ones;
				elsif scores mod 7d"10" = 7d"7" then
					rgb <= rgb_seven_ones;
				elsif scores mod 7d"10" = 7d"6" then
					rgb <= rgb_six_ones;
				elsif scores mod 7d"10" = 7d"5" then
					rgb <= rgb_five_ones;
				elsif scores mod 7d"10" = 7d"4" then
					rgb <= rgb_four_ones;
				elsif (scores) mod 7d"10" = 7d"3" then
					rgb <= rgb_three_ones;
				elsif scores mod 7d"10" = 7d"2" then
					rgb <= rgb_two_ones;
				elsif scores mod 7d"10" = 7d"1" then
					rgb <= rgb_one_ones;
				else
					rgb <= rgb_zero_ones;
				
				end if;
			end if;
		
		end if;
	
	end if;
	end process; 




end;
