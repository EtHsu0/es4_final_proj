library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.textio.all;


entity NES is
port(
		
        latch : out std_logic;
        passedCLK : out std_logic;
        output : out unsigned(7 downto 0);
        data : in std_logic;
		CLK : in std_logic
		
);
end NES;


architecture synth of NES is

signal count : unsigned(23 downto 0);
signal NESclk : std_logic;
signal NEScount : unsigned(11 downto 0);
signal NESoutput : unsigned(7 downto 0);

begin

	process (CLK) begin
			if rising_edge (CLK) then
					count <= count + 1;
			end if;
	end process;


	process (NESCLK) begin
			if rising_edge (NESclk) and (NEScount < "000010000") then
					NESOutput <= NESOutput(6 downto 0) & data;
			end if;

	end process;

	NESclk <= count(7);

	NEScount <= count(19 downto 8);

	latch <= '1' when NEScount = "11111111" else '0';

	passedCLK <= NESCLK when NEScount < "00001000" else '0';

	output <= NESOutput when NEScount = "00000111" else output;

end;