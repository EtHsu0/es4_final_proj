library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity pattern_gen is
	port(
		valid : in std_logic; -- when valid is 0, all RGB output must be low
		
		y_pos : in unsigned(9 downto 0); -- current y position (row) of the pixel that the VGA is drawing
		x_pos : in unsigned(9 downto 0); -- current x position (column) of the pixel that the VGA is drawing
		
		
		-- SPECIFIC SNAKE GAME VARIABLES
		-- INPUT PORTS

		-- rand_apple(8) = '1' if there is an apple, '0' if there is no apple
		-- rand_apple(7 downto 4) gives the column_num {col 0, 1, 2, ..., 8, 9} in binary
		-- rand_apple(3 downto 0) gives the row_num {row 0, 1, 2, ..., 8, 9} in binary
		--rand_apple : in unsigned(8 downto 0);
		
		apple : in unsigned(6 downto 0);
		snake_location : in std_logic_vector(99 downto 0);
		
		
        -- Score 
        --score : in unsigned(5 downto 0);		
		

		rgb : out unsigned(5 downto 0);

        snake_head: in unsigned(6 downto 0);

		pll_in_clock : in std_logic;
        game_state: in unsigned(1 downto 0)
		

	);
end pattern_gen;

architecture synth of pattern_gen is

signal intermed_rgb : unsigned(5 downto 0);

begin
	process(valid) begin
		if valid = '1' then
			-- Snake grid 
			-- each cell is 44 pixels by 44 pixels
			-- it goes from (x_pos, y_pos) of (100 px, 20 px) to (540 px, 460 px)
			if ((((x_pos - 10d"100" )mod 10d"44" = 10d"0") or ((y_pos - 10d"20" )mod 10d"44" = 10d"0")) and x_pos > 10d"99" and x_pos < 10d"541" and y_pos > 10d"19" and y_pos < 10d"461") or ((x_pos = 10d"98" or x_pos = 10d"99" or x_pos = 10d"541" or x_pos = 10d"542") and (y_pos > 10d"19" and y_pos <10d"461")) or ((y_pos = 10d"18" or y_pos = 10d"19" or y_pos = 10d"461" or y_pos = 10d"462") and (x_pos > 10d"99" and x_pos <10d"541")) then
				rgb <= "001100"; -- grass green grids
			else
				rgb <= 6d"0";
			end if; 

			
			-- Fill in snake cells
			for i in 0 to 99 loop
				-- iteration through the 100 bits of snake location
				if snake_location(i) = '1' then
					if (x_pos > 10d"99" + 10d"44" * (i mod 10d"10")) and (x_pos < 10d"101" + 10d"44" + 10d"44" * (i mod 10d"10")) and (y_pos > 10d"19" + 10d"44" * (i / 10d"10")) and (y_pos < 10d"21" + 10d"44" + 10d"44" * (i / 10d"10")) then
						rgb <= "100011"; -- purple snake
					end if;
				end if;
			end loop;

            if (x_pos > 10d"99" + 10d"44" * (snake_head mod 10d"10")) and (x_pos < 10d"101" + 10d"44" + 10d"44" * (snake_head mod 10d"10")) and (y_pos > 10d"19" + 10d"44" * (snake_head / 10d"10")) and (y_pos < 10d"21" + 10d"44" + 10d"44" * (snake_head / 10d"10")) then
                rgb <= "110011"; -- snake head
            end if;
			
			
			-- generate apple
			/*if (x_pos > 10d"102" + 10d"44" * (apple mod 10d"10")) and (x_pos < 10d"99" + 10d"44" + 10d"44" * (apple mod 10d"10")) and (y_pos > 10d"21" + 10d"44" * (apple / 10d"10")) and (y_pos < 10d"19" + 10d"44" + 10d"44" * (apple / 10d"10")) then
					if(x_pos > 10d"115" + 10d"44" *(apple mod 10d"10")) and (x_pos < 10d"130" + 10d"44" * (apple mod 10d"10")) and (y_pos > 10d"21" + 10d"44" * (apple / 10d"10")) and (y_pos < 10d"30" + 10d"44" * (apple / 10d"10")) then
						rgb <= "001100"; -- Green leaf
					else
						rgb <= "110000"; -- red apple
					end if;
				end if;*/
		
		else -- if valid is 0, then set rgb to low
			rgb <= 6d"0";
		end if;
	
	end process;

end;
