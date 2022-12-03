library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga is
	port(
		clk : in std_logic; -- 25.1 MHz clock
		
		valid : out std_logic; -- 0 for front/back porch and sync pulse
		
		y_pos : out unsigned(9 downto 0) := 10d"0"; -- y position (row_cnt) of the current pixel that the VGA is drawing
		x_pos : out unsigned(9 downto 0) := 10d"0"; -- x position (column_cnt) of the current pixel that the VGA is drawing
		
		HSYNC : out std_logic;
		VSYNC : out std_logic
	);
end vga;

architecture synth of vga is
begin
	process(clk) begin
				if rising_edge(clk) then
					-- columns go from 0 to 799 in decimal. When 799 is reached column_cnt resets to 0 and row_cnt increments by 1
					if (x_pos = 10d"799") then
						x_pos <= 10d"0";
						if (y_pos = 10d"524") then
							y_pos <= 10d"0";
						else 
							y_pos <= y_pos + 10d"1";
						end if;
					else 
						x_pos <= x_pos+10d"1";
					end if;
				HSYNC <= '1' when (x_pos <= 10d"655" or x_pos > 10d"751") else '0';
				
				VSYNC <= '1' when (y_pos <= 10d"489" or y_pos > 10d"524") else '0';
				
				valid <= '0' when (x_pos > 10d"641" or y_pos > 10d"481") else '1';
				end if;
				
	end process;
	
end;





