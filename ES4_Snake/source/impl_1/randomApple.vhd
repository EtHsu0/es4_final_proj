library IEEE;
use IEEE.math_real.uniform;
use IEEE.math_real.floor;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_arith.all;

entity randomApple is
        port (
                enable: in std_logic;
                clk: in std_logic;
                x_coord: out std_logic_vector;
                y_coord: out std_logic_vector;
        );
end randomApple;

architecture synth of top is
signal seed1: positive := 1;
signal seed2: positive := 2;
signal x_gen: real;
signal y_gen: real;

begin
        process is begin
                uniform(seed1, seed2, x_gen);
                uniform(seed1, seed2, y_gen);
                
        end process;
end;
