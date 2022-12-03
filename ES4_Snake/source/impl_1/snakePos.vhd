library IEEE;
use IEEE.math_real.uniform;
use IEEE.math_real.floor;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- use IEEE.std_logic_arith.all;

entity snakePos is
        port (
			clk: in std_logic;
			data: in std_logic_vector(7 downto 0);
        );
end board;

architecture synth of snakePos is
begin
	-- Update the snake head position, use that information to check collision with apple
		-- If collieded with apple, set a state and generate anoother apple.
	-- snakePos -> Get updated snake position based on the new head position
	-- Check collision with body / wall based on the new snake position
	
end;
