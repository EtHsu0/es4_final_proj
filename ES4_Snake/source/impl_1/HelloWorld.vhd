library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity HELLOWORLD is 
  port(
    a: out std_logic
  );
end HELLOWORLD;

architecture synth of HELLOWORLD is
begin
    a <= '1';
end;



