library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
	port(
		pll_in_clock : in std_logic; -- pin 20, shorted to the 12 MHz pin on the UPduino
		pll_outcore_o : out std_logic; -- for testing purposes (pin 2)
		
		HSYNC : out std_logic; -- pin 23
		VSYNC : out std_logic; -- pin 25
		
		rgb : out unsigned(5 downto 0) -- pin 28, 38, 42, 36, 43, and 34
	);
end top;

architecture synth of top is
	component my_pll is
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
			x_pos : out unsigned(9 downto 0); --  current x position (column count) of pixel that the VGA is drawing
			HSYNC : out std_logic; -- hsync signal
			VSYNC : out std_logic -- vsync signal
		);
	end component;
	
	component pattern_gen is
		port(
			valid : in std_logic; -- when valid is '0', the VGA's RGB output must be all 0's
			y_pos : in unsigned(9 downto 0); -- the current y position (row count) of pixel that the VGA is drawing
			x_pos : in unsigned(9 downto 0); -- the current x position (column count) of pixel that the VGA is drawing
			
			rand_apple : in unsigned(8 downto 0);
			snake_location : in unsigned (99 downto 0);
			
			
			
			rgb : out unsigned(5 downto 0) -- color of the individual pixel that the VGA is drawing
		);
	end component;
	
	-- internal variables
	signal clk : std_logic; -- 25.1 MHz clock
	
	-- rows need to go up to 525 (visible area is 480)
	signal row_cnt : unsigned(9 downto 0);


	-- columns need to go up to 799 (visible area is 640)
	signal column_cnt : unsigned(9 downto 0); 
	
	signal valid : std_logic;
	
	
	-- snake testing
	signal snake_loc : unsigned(99 downto 0);
	
	
	
	begin
		pll_initial: my_pll port map(ref_clk_i => pll_in_clock, rst_n_i => '1', outcore_o => pll_outcore_o, outglobal_o => clk);
		-- vga_initial vga port map(clk <= clk);
		
		vga_intial: vga port map(clk, valid, row_cnt, column_cnt, HSYNC, VSYNC);
		
		-- 9B"1_1000_0111" represents the random apple. "1" means that it exists, "1000" means that the column number is 8, "0111" means that the row number is 7
		snake_loc <= ("0000000000000000001000000000100000000010111111111010000000000000000000000000000000000000000000000000"); 
		pattern_gen_initial: pattern_gen port map(valid, row_cnt, column_cnt, 9B"1_1000_0111", snake_loc, rgb);
		
end;
