library IEEE;
use IEEE.math_real.uniform;
use IEEE.math_real.floor;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- use IEEE.std_logic_arith.all;

entity board is
        port (
			clk: in std_logic;
			data: in std_logic_vector(7 downto 0);
        );
end board;

architecture synth of board is
component randomPos is
	port (
		enable: in std_logic;
		clk: in std_logic;
		coord: in unsigned(7 downto 0);
		bound: in unsigned(10 downto 0);
		out_coord: out unsigned(7 downto 0)
	);
end component;

begin
	-- Update the snake head position, use that information to check collision with apple
		-- If collieded with apple, set a state and generate anoother apple.
	-- snakePos -> Get updated snake position based on the new head position
	-- Check collision with body / wall based on the new snake position
	
end;
