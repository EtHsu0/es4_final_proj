
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity template_segments is
    port (
        row : in unsigned (9 downto 0);
        col : in unsigned (9 downto 0);
        clk : in std_logic;
        rgb : out std_logic_vector(5 downto 0)
    );
end template_segments;

architecture synth of template_segments is
    signal addr : std_logic_vector(13 downto 0);

    begin
        addr <= std_logic_vector(row(7 downto 0)) & std_logic_vector(col(7 downto 0));
        process(clk) is begin
            if rising_edge(clk) then 
                case addr is 
                    
                end case;
            end if;
            end process;
        end;
                
