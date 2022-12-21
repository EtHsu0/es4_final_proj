library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity three_segments is
    port (
        row : in unsigned (9 downto 0);
        col : in unsigned (9 downto 0);
        clk : in std_logic;
        rgb : out unsigned(5 downto 0)
    );
end three_segments;

architecture synth of three_segments is
    signal addr : unsigned(9 downto 0);

    begin
        addr <= unsigned(row(4 downto 0)) & unsigned(col(4 downto 0));
        process(clk) is begin
            if rising_edge(clk) then
				if (row(9 downto 5) = "00000" and col(9 downto 5) = "00000") then			
                case addr is 
                          when "0000000000" => rgb <= "111111";
                          when "0000000001" => rgb <= "111111";
                          when "0000000010" => rgb <= "111111";
                          when "0000000011" => rgb <= "111111";
                          when "0000000100" => rgb <= "111111";
                          when "0000000101" => rgb <= "111111";
                          when "0000000110" => rgb <= "111111";
                          when "0000000111" => rgb <= "111111";
                          when "0000001000" => rgb <= "111111";
                          when "0000001001" => rgb <= "111111";
                          when "0000001010" => rgb <= "111111";
                          when "0000001011" => rgb <= "111111";
                          when "0000001100" => rgb <= "111111";
                          when "0000001101" => rgb <= "111111";
                          when "0000001110" => rgb <= "111111";
                          when "0000001111" => rgb <= "111111";
                          when "0000100000" => rgb <= "111111";
                          when "0000100001" => rgb <= "111111";
                          when "0000100010" => rgb <= "111111";
                          when "0000100011" => rgb <= "111111";
                          when "0000100100" => rgb <= "111111";
                          when "0000100101" => rgb <= "111111";
                          when "0000100110" => rgb <= "111111";
                          when "0000100111" => rgb <= "111111";
                          when "0000101000" => rgb <= "111111";
                          when "0000101001" => rgb <= "111111";
                          when "0000101010" => rgb <= "111111";
                          when "0000101011" => rgb <= "111111";
                          when "0000101100" => rgb <= "111111";
                          when "0000101101" => rgb <= "111111";
                          when "0000101110" => rgb <= "111111";
                          when "0000101111" => rgb <= "111111";
                          when "0001000000" => rgb <= "000000";
                          when "0001000001" => rgb <= "000000";
                          when "0001000010" => rgb <= "000000";
                          when "0001000011" => rgb <= "000000";
                          when "0001000100" => rgb <= "000000";
                          when "0001000101" => rgb <= "000000";
                          when "0001000110" => rgb <= "000000";
                          when "0001000111" => rgb <= "000000";
                          when "0001001000" => rgb <= "000000";
                          when "0001001001" => rgb <= "000000";
                          when "0001001010" => rgb <= "000000";
                          when "0001001011" => rgb <= "000000";
                          when "0001001100" => rgb <= "000000";
                          when "0001001101" => rgb <= "000000";
                          when "0001001110" => rgb <= "111111";
                          when "0001001111" => rgb <= "111111";
                          when "0001100000" => rgb <= "000000";
                          when "0001100001" => rgb <= "000000";
                          when "0001100010" => rgb <= "000000";
                          when "0001100011" => rgb <= "000000";
                          when "0001100100" => rgb <= "000000";
                          when "0001100101" => rgb <= "000000";
                          when "0001100110" => rgb <= "000000";
                          when "0001100111" => rgb <= "000000";
                          when "0001101000" => rgb <= "000000";
                          when "0001101001" => rgb <= "000000";
                          when "0001101010" => rgb <= "000000";
                          when "0001101011" => rgb <= "000000";
                          when "0001101100" => rgb <= "000000";
                          when "0001101101" => rgb <= "000000";
                          when "0001101110" => rgb <= "111111";
                          when "0001101111" => rgb <= "111111";
                          when "0010000000" => rgb <= "000000";
                          when "0010000001" => rgb <= "000000";
                          when "0010000010" => rgb <= "000000";
                          when "0010000011" => rgb <= "000000";
                          when "0010000100" => rgb <= "000000";
                          when "0010000101" => rgb <= "000000";
                          when "0010000110" => rgb <= "000000";
                          when "0010000111" => rgb <= "000000";
                          when "0010001000" => rgb <= "000000";
                          when "0010001001" => rgb <= "000000";
                          when "0010001010" => rgb <= "000000";
                          when "0010001011" => rgb <= "000000";
                          when "0010001100" => rgb <= "000000";
                          when "0010001101" => rgb <= "000000";
                          when "0010001110" => rgb <= "111111";
                          when "0010001111" => rgb <= "111111";
                          when "0010100000" => rgb <= "000000";
                          when "0010100001" => rgb <= "000000";
                          when "0010100010" => rgb <= "000000";
                          when "0010100011" => rgb <= "000000";
                          when "0010100100" => rgb <= "000000";
                          when "0010100101" => rgb <= "000000";
                          when "0010100110" => rgb <= "000000";
                          when "0010100111" => rgb <= "000000";
                          when "0010101000" => rgb <= "000000";
                          when "0010101001" => rgb <= "000000";
                          when "0010101010" => rgb <= "000000";
                          when "0010101011" => rgb <= "000000";
                          when "0010101100" => rgb <= "000000";
                          when "0010101101" => rgb <= "000000";
                          when "0010101110" => rgb <= "111111";
                          when "0010101111" => rgb <= "111111";
                          when "0011000000" => rgb <= "000000";
                          when "0011000001" => rgb <= "000000";
                          when "0011000010" => rgb <= "000000";
                          when "0011000011" => rgb <= "000000";
                          when "0011000100" => rgb <= "000000";
                          when "0011000101" => rgb <= "000000";
                          when "0011000110" => rgb <= "000000";
                          when "0011000111" => rgb <= "000000";
                          when "0011001000" => rgb <= "000000";
                          when "0011001001" => rgb <= "000000";
                          when "0011001010" => rgb <= "000000";
                          when "0011001011" => rgb <= "000000";
                          when "0011001100" => rgb <= "000000";
                          when "0011001101" => rgb <= "000000";
                          when "0011001110" => rgb <= "111111";
                          when "0011001111" => rgb <= "111111";
                          when "0011100000" => rgb <= "000000";
                          when "0011100001" => rgb <= "000000";
                          when "0011100010" => rgb <= "000000";
                          when "0011100011" => rgb <= "000000";
                          when "0011100100" => rgb <= "000000";
                          when "0011100101" => rgb <= "000000";
                          when "0011100110" => rgb <= "000000";
                          when "0011100111" => rgb <= "000000";
                          when "0011101000" => rgb <= "000000";
                          when "0011101001" => rgb <= "000000";
                          when "0011101010" => rgb <= "000000";
                          when "0011101011" => rgb <= "000000";
                          when "0011101100" => rgb <= "000000";
                          when "0011101101" => rgb <= "000000";
                          when "0011101110" => rgb <= "111111";
                          when "0011101111" => rgb <= "111111";
                          when "0100000000" => rgb <= "000000";
                          when "0100000001" => rgb <= "000000";
                          when "0100000010" => rgb <= "000000";
                          when "0100000011" => rgb <= "000000";
                          when "0100000100" => rgb <= "000000";
                          when "0100000101" => rgb <= "000000";
                          when "0100000110" => rgb <= "000000";
                          when "0100000111" => rgb <= "000000";
                          when "0100001000" => rgb <= "000000";
                          when "0100001001" => rgb <= "000000";
                          when "0100001010" => rgb <= "000000";
                          when "0100001011" => rgb <= "000000";
                          when "0100001100" => rgb <= "000000";
                          when "0100001101" => rgb <= "000000";
                          when "0100001110" => rgb <= "111111";
                          when "0100001111" => rgb <= "111111";
                          when "0100100000" => rgb <= "000000";
                          when "0100100001" => rgb <= "000000";
                          when "0100100010" => rgb <= "000000";
                          when "0100100011" => rgb <= "000000";
                          when "0100100100" => rgb <= "000000";
                          when "0100100101" => rgb <= "000000";
                          when "0100100110" => rgb <= "000000";
                          when "0100100111" => rgb <= "000000";
                          when "0100101000" => rgb <= "000000";
                          when "0100101001" => rgb <= "000000";
                          when "0100101010" => rgb <= "000000";
                          when "0100101011" => rgb <= "000000";
                          when "0100101100" => rgb <= "000000";
                          when "0100101101" => rgb <= "000000";
                          when "0100101110" => rgb <= "111111";
                          when "0100101111" => rgb <= "111111";
                          when "0101000000" => rgb <= "000000";
                          when "0101000001" => rgb <= "000000";
                          when "0101000010" => rgb <= "000000";
                          when "0101000011" => rgb <= "000000";
                          when "0101000100" => rgb <= "000000";
                          when "0101000101" => rgb <= "000000";
                          when "0101000110" => rgb <= "000000";
                          when "0101000111" => rgb <= "000000";
                          when "0101001000" => rgb <= "000000";
                          when "0101001001" => rgb <= "000000";
                          when "0101001010" => rgb <= "000000";
                          when "0101001011" => rgb <= "000000";
                          when "0101001100" => rgb <= "000000";
                          when "0101001101" => rgb <= "000000";
                          when "0101001110" => rgb <= "111111";
                          when "0101001111" => rgb <= "111111";
                          when "0101100000" => rgb <= "000000";
                          when "0101100001" => rgb <= "000000";
                          when "0101100010" => rgb <= "000000";
                          when "0101100011" => rgb <= "000000";
                          when "0101100100" => rgb <= "000000";
                          when "0101100101" => rgb <= "000000";
                          when "0101100110" => rgb <= "000000";
                          when "0101100111" => rgb <= "000000";
                          when "0101101000" => rgb <= "000000";
                          when "0101101001" => rgb <= "000000";
                          when "0101101010" => rgb <= "000000";
                          when "0101101011" => rgb <= "000000";
                          when "0101101100" => rgb <= "000000";
                          when "0101101101" => rgb <= "000000";
                          when "0101101110" => rgb <= "111111";
                          when "0101101111" => rgb <= "111111";
                          when "0110000000" => rgb <= "000000";
                          when "0110000001" => rgb <= "000000";
                          when "0110000010" => rgb <= "000000";
                          when "0110000011" => rgb <= "000000";
                          when "0110000100" => rgb <= "000000";
                          when "0110000101" => rgb <= "000000";
                          when "0110000110" => rgb <= "000000";
                          when "0110000111" => rgb <= "000000";
                          when "0110001000" => rgb <= "000000";
                          when "0110001001" => rgb <= "000000";
                          when "0110001010" => rgb <= "000000";
                          when "0110001011" => rgb <= "000000";
                          when "0110001100" => rgb <= "000000";
                          when "0110001101" => rgb <= "000000";
                          when "0110001110" => rgb <= "111111";
                          when "0110001111" => rgb <= "111111";
                          when "0110100000" => rgb <= "000000";
                          when "0110100001" => rgb <= "000000";
                          when "0110100010" => rgb <= "000000";
                          when "0110100011" => rgb <= "000000";
                          when "0110100100" => rgb <= "000000";
                          when "0110100101" => rgb <= "000000";
                          when "0110100110" => rgb <= "000000";
                          when "0110100111" => rgb <= "000000";
                          when "0110101000" => rgb <= "000000";
                          when "0110101001" => rgb <= "000000";
                          when "0110101010" => rgb <= "000000";
                          when "0110101011" => rgb <= "000000";
                          when "0110101100" => rgb <= "000000";
                          when "0110101101" => rgb <= "000000";
                          when "0110101110" => rgb <= "111111";
                          when "0110101111" => rgb <= "111111";
                          when "0111000000" => rgb <= "000000";
                          when "0111000001" => rgb <= "000000";
                          when "0111000010" => rgb <= "000000";
                          when "0111000011" => rgb <= "000000";
                          when "0111000100" => rgb <= "000000";
                          when "0111000101" => rgb <= "000000";
                          when "0111000110" => rgb <= "000000";
                          when "0111000111" => rgb <= "000000";
                          when "0111001000" => rgb <= "000000";
                          when "0111001001" => rgb <= "000000";
                          when "0111001010" => rgb <= "000000";
                          when "0111001011" => rgb <= "000000";
                          when "0111001100" => rgb <= "000000";
                          when "0111001101" => rgb <= "000000";
                          when "0111001110" => rgb <= "111111";
                          when "0111001111" => rgb <= "111111";
                          when "0111100000" => rgb <= "111111";
                          when "0111100001" => rgb <= "111111";
                          when "0111100010" => rgb <= "111111";
                          when "0111100011" => rgb <= "111111";
                          when "0111100100" => rgb <= "111111";
                          when "0111100101" => rgb <= "111111";
                          when "0111100110" => rgb <= "111111";
                          when "0111100111" => rgb <= "111111";
                          when "0111101000" => rgb <= "111111";
                          when "0111101001" => rgb <= "111111";
                          when "0111101010" => rgb <= "111111";
                          when "0111101011" => rgb <= "111111";
                          when "0111101100" => rgb <= "111111";
                          when "0111101101" => rgb <= "111111";
                          when "0111101110" => rgb <= "111111";
                          when "0111101111" => rgb <= "111111";
                          when "1000000000" => rgb <= "111111";
                          when "1000000001" => rgb <= "111111";
                          when "1000000010" => rgb <= "111111";
                          when "1000000011" => rgb <= "111111";
                          when "1000000100" => rgb <= "111111";
                          when "1000000101" => rgb <= "111111";
                          when "1000000110" => rgb <= "111111";
                          when "1000000111" => rgb <= "111111";
                          when "1000001000" => rgb <= "111111";
                          when "1000001001" => rgb <= "111111";
                          when "1000001010" => rgb <= "111111";
                          when "1000001011" => rgb <= "111111";
                          when "1000001100" => rgb <= "111111";
                          when "1000001101" => rgb <= "111111";
                          when "1000001110" => rgb <= "111111";
                          when "1000001111" => rgb <= "111111";
                          when "1000100000" => rgb <= "000000";
                          when "1000100001" => rgb <= "000000";
                          when "1000100010" => rgb <= "000000";
                          when "1000100011" => rgb <= "000000";
                          when "1000100100" => rgb <= "000000";
                          when "1000100101" => rgb <= "000000";
                          when "1000100110" => rgb <= "000000";
                          when "1000100111" => rgb <= "000000";
                          when "1000101000" => rgb <= "000000";
                          when "1000101001" => rgb <= "000000";
                          when "1000101010" => rgb <= "000000";
                          when "1000101011" => rgb <= "000000";
                          when "1000101100" => rgb <= "000000";
                          when "1000101101" => rgb <= "000000";
                          when "1000101110" => rgb <= "111111";
                          when "1000101111" => rgb <= "111111";
                          when "1001000000" => rgb <= "000000";
                          when "1001000001" => rgb <= "000000";
                          when "1001000010" => rgb <= "000000";
                          when "1001000011" => rgb <= "000000";
                          when "1001000100" => rgb <= "000000";
                          when "1001000101" => rgb <= "000000";
                          when "1001000110" => rgb <= "000000";
                          when "1001000111" => rgb <= "000000";
                          when "1001001000" => rgb <= "000000";
                          when "1001001001" => rgb <= "000000";
                          when "1001001010" => rgb <= "000000";
                          when "1001001011" => rgb <= "000000";
                          when "1001001100" => rgb <= "000000";
                          when "1001001101" => rgb <= "000000";
                          when "1001001110" => rgb <= "111111";
                          when "1001001111" => rgb <= "111111";
                          when "1001100000" => rgb <= "000000";
                          when "1001100001" => rgb <= "000000";
                          when "1001100010" => rgb <= "000000";
                          when "1001100011" => rgb <= "000000";
                          when "1001100100" => rgb <= "000000";
                          when "1001100101" => rgb <= "000000";
                          when "1001100110" => rgb <= "000000";
                          when "1001100111" => rgb <= "000000";
                          when "1001101000" => rgb <= "000000";
                          when "1001101001" => rgb <= "000000";
                          when "1001101010" => rgb <= "000000";
                          when "1001101011" => rgb <= "000000";
                          when "1001101100" => rgb <= "000000";
                          when "1001101101" => rgb <= "000000";
                          when "1001101110" => rgb <= "111111";
                          when "1001101111" => rgb <= "111111";
                          when "1010000000" => rgb <= "000000";
                          when "1010000001" => rgb <= "000000";
                          when "1010000010" => rgb <= "000000";
                          when "1010000011" => rgb <= "000000";
                          when "1010000100" => rgb <= "000000";
                          when "1010000101" => rgb <= "000000";
                          when "1010000110" => rgb <= "000000";
                          when "1010000111" => rgb <= "000000";
                          when "1010001000" => rgb <= "000000";
                          when "1010001001" => rgb <= "000000";
                          when "1010001010" => rgb <= "000000";
                          when "1010001011" => rgb <= "000000";
                          when "1010001100" => rgb <= "000000";
                          when "1010001101" => rgb <= "000000";
                          when "1010001110" => rgb <= "111111";
                          when "1010001111" => rgb <= "111111";
                          when "1010100000" => rgb <= "000000";
                          when "1010100001" => rgb <= "000000";
                          when "1010100010" => rgb <= "000000";
                          when "1010100011" => rgb <= "000000";
                          when "1010100100" => rgb <= "000000";
                          when "1010100101" => rgb <= "000000";
                          when "1010100110" => rgb <= "000000";
                          when "1010100111" => rgb <= "000000";
                          when "1010101000" => rgb <= "000000";
                          when "1010101001" => rgb <= "000000";
                          when "1010101010" => rgb <= "000000";
                          when "1010101011" => rgb <= "000000";
                          when "1010101100" => rgb <= "000000";
                          when "1010101101" => rgb <= "000000";
                          when "1010101110" => rgb <= "111111";
                          when "1010101111" => rgb <= "111111";
                          when "1011000000" => rgb <= "000000";
                          when "1011000001" => rgb <= "000000";
                          when "1011000010" => rgb <= "000000";
                          when "1011000011" => rgb <= "000000";
                          when "1011000100" => rgb <= "000000";
                          when "1011000101" => rgb <= "000000";
                          when "1011000110" => rgb <= "000000";
                          when "1011000111" => rgb <= "000000";
                          when "1011001000" => rgb <= "000000";
                          when "1011001001" => rgb <= "000000";
                          when "1011001010" => rgb <= "000000";
                          when "1011001011" => rgb <= "000000";
                          when "1011001100" => rgb <= "000000";
                          when "1011001101" => rgb <= "000000";
                          when "1011001110" => rgb <= "111111";
                          when "1011001111" => rgb <= "111111";
                          when "1011100000" => rgb <= "000000";
                          when "1011100001" => rgb <= "000000";
                          when "1011100010" => rgb <= "000000";
                          when "1011100011" => rgb <= "000000";
                          when "1011100100" => rgb <= "000000";
                          when "1011100101" => rgb <= "000000";
                          when "1011100110" => rgb <= "000000";
                          when "1011100111" => rgb <= "000000";
                          when "1011101000" => rgb <= "000000";
                          when "1011101001" => rgb <= "000000";
                          when "1011101010" => rgb <= "000000";
                          when "1011101011" => rgb <= "000000";
                          when "1011101100" => rgb <= "000000";
                          when "1011101101" => rgb <= "000000";
                          when "1011101110" => rgb <= "111111";
                          when "1011101111" => rgb <= "111111";
                          when "1100000000" => rgb <= "000000";
                          when "1100000001" => rgb <= "000000";
                          when "1100000010" => rgb <= "000000";
                          when "1100000011" => rgb <= "000000";
                          when "1100000100" => rgb <= "000000";
                          when "1100000101" => rgb <= "000000";
                          when "1100000110" => rgb <= "000000";
                          when "1100000111" => rgb <= "000000";
                          when "1100001000" => rgb <= "000000";
                          when "1100001001" => rgb <= "000000";
                          when "1100001010" => rgb <= "000000";
                          when "1100001011" => rgb <= "000000";
                          when "1100001100" => rgb <= "000000";
                          when "1100001101" => rgb <= "000000";
                          when "1100001110" => rgb <= "111111";
                          when "1100001111" => rgb <= "111111";
                          when "1100100000" => rgb <= "000000";
                          when "1100100001" => rgb <= "000000";
                          when "1100100010" => rgb <= "000000";
                          when "1100100011" => rgb <= "000000";
                          when "1100100100" => rgb <= "000000";
                          when "1100100101" => rgb <= "000000";
                          when "1100100110" => rgb <= "000000";
                          when "1100100111" => rgb <= "000000";
                          when "1100101000" => rgb <= "000000";
                          when "1100101001" => rgb <= "000000";
                          when "1100101010" => rgb <= "000000";
                          when "1100101011" => rgb <= "000000";
                          when "1100101100" => rgb <= "000000";
                          when "1100101101" => rgb <= "000000";
                          when "1100101110" => rgb <= "111111";
                          when "1100101111" => rgb <= "111111";
                          when "1101000000" => rgb <= "000000";
                          when "1101000001" => rgb <= "000000";
                          when "1101000010" => rgb <= "000000";
                          when "1101000011" => rgb <= "000000";
                          when "1101000100" => rgb <= "000000";
                          when "1101000101" => rgb <= "000000";
                          when "1101000110" => rgb <= "000000";
                          when "1101000111" => rgb <= "000000";
                          when "1101001000" => rgb <= "000000";
                          when "1101001001" => rgb <= "000000";
                          when "1101001010" => rgb <= "000000";
                          when "1101001011" => rgb <= "000000";
                          when "1101001100" => rgb <= "000000";
                          when "1101001101" => rgb <= "000000";
                          when "1101001110" => rgb <= "111111";
                          when "1101001111" => rgb <= "111111";
                          when "1101100000" => rgb <= "000000";
                          when "1101100001" => rgb <= "000000";
                          when "1101100010" => rgb <= "000000";
                          when "1101100011" => rgb <= "000000";
                          when "1101100100" => rgb <= "000000";
                          when "1101100101" => rgb <= "000000";
                          when "1101100110" => rgb <= "000000";
                          when "1101100111" => rgb <= "000000";
                          when "1101101000" => rgb <= "000000";
                          when "1101101001" => rgb <= "000000";
                          when "1101101010" => rgb <= "000000";
                          when "1101101011" => rgb <= "000000";
                          when "1101101100" => rgb <= "000000";
                          when "1101101101" => rgb <= "000000";
                          when "1101101110" => rgb <= "111111";
                          when "1101101111" => rgb <= "111111";
                          when "1110000000" => rgb <= "000000";
                          when "1110000001" => rgb <= "000000";
                          when "1110000010" => rgb <= "000000";
                          when "1110000011" => rgb <= "000000";
                          when "1110000100" => rgb <= "000000";
                          when "1110000101" => rgb <= "000000";
                          when "1110000110" => rgb <= "000000";
                          when "1110000111" => rgb <= "000000";
                          when "1110001000" => rgb <= "000000";
                          when "1110001001" => rgb <= "000000";
                          when "1110001010" => rgb <= "000000";
                          when "1110001011" => rgb <= "000000";
                          when "1110001100" => rgb <= "000000";
                          when "1110001101" => rgb <= "000000";
                          when "1110001110" => rgb <= "111111";
                          when "1110001111" => rgb <= "111111";
                          when "1110100000" => rgb <= "000000";
                          when "1110100001" => rgb <= "000000";
                          when "1110100010" => rgb <= "000000";
                          when "1110100011" => rgb <= "000000";
                          when "1110100100" => rgb <= "000000";
                          when "1110100101" => rgb <= "000000";
                          when "1110100110" => rgb <= "000000";
                          when "1110100111" => rgb <= "000000";
                          when "1110101000" => rgb <= "000000";
                          when "1110101001" => rgb <= "000000";
                          when "1110101010" => rgb <= "000000";
                          when "1110101011" => rgb <= "000000";
                          when "1110101100" => rgb <= "000000";
                          when "1110101101" => rgb <= "000000";
                          when "1110101110" => rgb <= "111111";
                          when "1110101111" => rgb <= "111111";
                          when "1111000000" => rgb <= "111111";
                          when "1111000001" => rgb <= "111111";
                          when "1111000010" => rgb <= "111111";
                          when "1111000011" => rgb <= "111111";
                          when "1111000100" => rgb <= "111111";
                          when "1111000101" => rgb <= "111111";
                          when "1111000110" => rgb <= "111111";
                          when "1111000111" => rgb <= "111111";
                          when "1111001000" => rgb <= "111111";
                          when "1111001001" => rgb <= "111111";
                          when "1111001010" => rgb <= "111111";
                          when "1111001011" => rgb <= "111111";
                          when "1111001100" => rgb <= "111111";
                          when "1111001101" => rgb <= "111111";
                          when "1111001110" => rgb <= "111111";
                          when "1111001111" => rgb <= "111111";
                          when "1111100000" => rgb <= "111111";
                          when "1111100001" => rgb <= "111111";
                          when "1111100010" => rgb <= "111111";
                          when "1111100011" => rgb <= "111111";
                          when "1111100100" => rgb <= "111111";
                          when "1111100101" => rgb <= "111111";
                          when "1111100110" => rgb <= "111111";
                          when "1111100111" => rgb <= "111111";
                          when "1111101000" => rgb <= "111111";
                          when "1111101001" => rgb <= "111111";
                          when "1111101010" => rgb <= "111111";
                          when "1111101011" => rgb <= "111111";
                          when "1111101100" => rgb <= "111111";
                          when "1111101101" => rgb <= "111111";
                          when "1111101110" => rgb <= "111111";
                          when "1111101111" => rgb <= "111111";
                              when others => rgb <= "111111";
                end case;
				else
					rgb <= "000000";
				end if;
            end if;
            end process;
        end;
                
