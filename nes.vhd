library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.textio.all;


entity NES is
port(
        latch : out std_logic;
        continCLK : out std_logic;
        digital : out unsigned(7 downto 0);
		 test: out std_logic;
        data : in std_logic
);
end NES;


architecture synth of NES is


signal CLK : std_logic;
signal count : unsigned(23 downto 0);
signal NESclk : std_logic;
signal NEScount : unsigned(11 downto 0);
signal output : unsigned(7 downto 0);


component HSOSC is
    generic (
        CLKHF_DIV : String := "0b00"); --divide clock by 2^N (0-3)
    port (
        CLKHFPU : in std_logic := 'X'; -- Set to 1 to power up
        CLKHFEN : in std_logic := 'X'; --Set to 1 to enable output
        CLKHF : out std_logic := 'X'); --Clock output
end component;

begin


	HSOSC_instance : HSOSC port map('1', '1', CLK);


	process (CLK) begin
			if rising_edge (CLK) then
					count <= count + '1';
			end if;
	end process;


	process (NESCLK) begin
			if rising_edge (NESclk) and (NEScount < "000010000") then
					output <= output(6 downto 0) & data;
			end if;
			
	end process;


	NESclk <= count(7);

	NEScount <= count(19 downto 8);

	latch <= '1' when NEScount = "11111111" else '0';

	continCLK <= NESCLK when NEScount < "00001000" else '0';

	digital <= output when NEScount = "00000111";
	
	


end;
