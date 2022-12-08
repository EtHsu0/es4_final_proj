library IEEE;
use IEEE.math_real.uniform;
use IEEE.math_real.floor;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- use IEEE.std_logic_arith.all;

entity randomPos is
        port (
                enable: in std_logic;
                clk: in std_logic;
                out_coord: out unsigned(7 downto 0)
        );
end randomPos;

architecture synth of randomPos is
signal coord: unsigned(7 downto 0);

begin
    process(CLK) is
		variable seed1: positive;
		variable seed2: positive;
		variable gen: real;
	begin
		if rising_edge(clk) then
			if rising_edge(enable) then -- NEEDWORKS: Ethan: I want a logic where we only generate one apple whenever we have a new enable signal.
			    uniform(seed1, seed2, gen);
				coord <= to_unsigned(integer(floor(gen * 99.0)));
			end if;
		end if;
	end process;
	out_coord <= coord;
end;
