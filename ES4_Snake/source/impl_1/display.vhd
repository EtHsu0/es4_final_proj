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
        apple: in unsigned(8 downto 0);
        snake_head: in unsigned(6 downto 0);
        snake: in std_logic_vector(99 downto 0)
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
		
		
		-- SPECIFIC SNAKE GAME VARIABLES
		-- INPUT PORTS

		-- rand_apple(8) = '1' if there is an apple, '0' if there is no apple
		-- rand_apple(7 downto 4) gives the column_num {col 0, 1, 2, ..., 8, 9} in binary
		-- rand_apple(3 downto 0) gives the row_num {row 0, 1, 2, ..., 8, 9} in binary
		rand_apple : in unsigned(6 downto 0);
		snake_location : in std_logic_vector(99 downto 0);
		
		-- To be implemented
		-- display score with rom, start/end game screen, snake head

		rgb : out unsigned(5 downto 0);

        snake_head: in unsigned(6 downto 0) := "0010000");
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


-- columns need to go up to 799 (visible area is 640)
signal column_cnt : unsigned(9 downto 0); 
signal valid : std_logic;

-- intermediate rgb for the actual grid
signal intermed_rgb : unsigned(5 downto 0);

begin
    pll_init: mypll port map(ref_clk_i => pll_in_clock, rst_n_i => '1', outcore_o => pll_outcore_o, outglobal_o => clk);
    -- vga_initial vga port map(clk <= clk);
    vga_init: vga port map(clk, valid, row_cnt, column_cnt, HSYNC, VSYNC);
    -- 9B"1_1000_0111" represents the random apple. "1" means that it exists, "1000" means that the column number is 8, "0111" means that the row number is 7
    --snake_loc <= ("0000000000000000001000000000100000000010111111111010000000000000000000000000000000000000000000000000"); 
    --pattern_gen_init: pattern_gen port map(valid, row_cnt, column_cnt, 9B"1_1000_0111", snake_loc, rgb);
    pattern_gen_initial: pattern_gen port map(
        valid => valid, 
        y_pos => row_cnt, 
        x_pos => column_cnt, 
        rand_apple => apple, 
        snake_location => snake, 
        rgb => intermed_rgb,
        snake_head => snake_head);
    rgb <= intermed_rgb when (column_cnt > 50 and valid = '1') else "000000";
    --score_rgb when (column_cnt < 50 and valid = '1') else 



end;
