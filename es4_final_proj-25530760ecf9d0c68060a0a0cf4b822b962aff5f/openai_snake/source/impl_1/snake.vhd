-- VHDL code for a snake game

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity snake is
port(
    clk: in std_logic;
    reset: in std_logic;
    input: in std_logic_vector(3 downto 0);
    x_coord: out integer range 0 to 15;
    y_coord: out integer range 0 to 15;
    segment: out std_logic_vector(1 downto 0)
);
end snake;

architecture RTL of snake is
type state_type is (start, move_up, move_down, move_left, move_right);
signal state, next_state: state_type;
signal x_pos, y_pos: integer range 0 to 15;

begin

    process(clk, reset)
    begin
    if reset = '1' then
    state <= start;
    elsif rising_edge(clk) then
    state <= next_state;
    end if;
    end process;

    process(state, x_pos, y_pos, input)
    begin
    case state is
    when start =>
    x_pos <= 7;
    y_pos <= 7;
    next_state <= move_right;

    --Copy code
    when move_up =>
        if y_pos > 0 then
        y_pos <= y_pos - 1;
        end if;
        next_state <= move_up;

    when move_down =>
        if y_pos < 15 then
        y_pos <= y_pos + 1;
        end if;
        next_state <= move_down;

    when move_left =>
        if x_pos > 0 then
        x_pos <= x_pos - 1;
        end if;
        next_state <= move_left;

    when move_right =>
        if x_pos < 15 then
        x_pos <= x_pos + 1;
        end if;
        next_state <= move_right;

    end case;

    case input is
    when "0000" =>
        next_state <= move_up;
    when "0001" =>
        next_state <= move_down;
    when "0010" =>
        next_state <= move_left;
    when "0011" =>
        next_state <= move_right;
    end case;
    end process;

    x_coord <= x_pos;
    y_coord <= y_pos;
    segment <= "00";

end RTL;




