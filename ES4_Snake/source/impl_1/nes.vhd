library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity NES is
    port(
        CLK: in std_logic; -- Added by Ethan to take clock input
        data : in std_logic;

        latch: out std_logic;
        continCLK : out std_logic;
        digital : out unsigned(7 downto 0) -- Gabriel Q: Output preference? How would you like the output encoded?
        --  test: out std_logic;
    );
end NES;


architecture synth of NES is




-- signal CLK : std_logic;
signal count : unsigned(23 downto 0);
signal NESclk : std_logic;
signal NEScount : unsigned(11 downto 0);
signal output : unsigned(7 downto 0);

begin
    process (CLK) begin
        if rising_edge (CLK) then
            count <= count + 1;
        end if;
    end process;

    process (NESCLK) begin
        if rising_edge (NESclk) and (NEScount < "000010000") then
                output <= output(6 downto 0) & data; -- Ethan Q: How are you comparing 7 bits with 1 bit? This is a shift register
        end if;
    end process;

    NESclk <= count(7);

    NEScount <= count(19 downto 8);

    latch <= '1' when NEScount = "11111111" else '0';

    continCLK <= NESCLK when NEScount < "00001000" else '0';

    digital <= output when NEScount = "00000111"; -- Ethan: Else? what would the digital value be when NEScount != 7? 
	--Only update digital when NEScount = 7, could add a else digital if you want

end;
