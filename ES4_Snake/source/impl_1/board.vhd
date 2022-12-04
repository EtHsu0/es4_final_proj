library IEEE;
use IEEE.math_real.uniform;
use IEEE.math_real.floor;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- use IEEE.std_logic_arith.all;

entity board is
        port (
            clk: in std_logic;
            digital: in std_logic_vector(7 downto 0);
            -- Return the cell ID (0-99)
            apple_id: out unsigned(7 downto 0);
            -- Return whether snake is in each cell (0-99)
            snake: out unsigned(99 downto 0)
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

    
    component snakePos is
        port (
            snakeCLK: in std_logic;
            reset: in std_logic;
            -- Direction should be (Up, Down, Left, Right)
            dir: in DirTYpe;
            snake_head_coord: out std_logic_vector(7 downto 0);
            snake_pos: out std_logic_vector(99 downto 0)
        );
    end component; 
    signal apple: unsigned (7 downto 0) := 8d"";
    signal snakePosition: unsigned(99 downto 0) := (40 => '1', 41 => '1', 42 => '1'),
                                                (others => '0);
    signal counter: unsigned (29 downto 0) := 30d"0";

    TYPE DirType is (UP, DOWN, LEFT, RIGHT);
    signal direction: DirType := RIGHT;
begin

    -- Update the snake head position, use that information to check collision with apple
        -- If collieded with apple, set a state and generate anoother apple.
    -- snakePos -> Get updated snake position based on the new head position
    -- Check collision with body / wall based on the new snake position
    
end;
