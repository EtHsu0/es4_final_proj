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
                coord: in unsigned(7 downto 0);
                bound: in unsigned(10 downto 0);
                out_coord: out unsigned(7 downto 0)
        );
end randomPos;

architecture synth of randomPos is
signal seed1: positive := 1;
signal seed2: positive := 2;
signal gen: real;
signal int: unsigned(7 downto 0);
begin
    process is begin
        uniform(seed1, seed2, gen);
        int := unsigned(floor(gen * bound));

        end process;
end;
