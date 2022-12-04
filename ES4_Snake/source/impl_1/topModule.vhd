library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is 
    port(
        -- NES controllers IO
        data: in std_logic;
        latch: out std_logic;
        continCLK: out std_logic;

        -- VGA display IO
        pll_in_clock : in std_logic; -- pin 20, shorted to the 12 MHz pin on the UPduino
        
        HSYNC : out std_logic; -- pin 23
        VSYNC : out std_logic; -- pin 25
        
        rgb : out unsigned(5 downto 0) -- pin 28, 38, 42, 36, 43, and 34

        pll_outcore_o : out std_logic; -- for testing purposes (pin 2)

    );
end top;

architecture synth of top is
    component HSOSC is
        generic (
            CLKHF_DIV : String := "0b00"); --divide clock by 2^N (0-3)
        port (
            CLKHFPU : in std_logic := 'X'; -- Set to 1 to power up
            CLKHFEN : in std_logic := 'X'; --Set to 1 to enable output
            CLKHF : out std_logic := 'X'); --Clock output
    end component;

    component NES is
        port (
            CLK: in std_logic; -- Added by Ethan to take clock input
            data : in std_logic;

            latch : out std_logic;
            continCLK : out std_logic;
            digital : out unsigned(7 downto 0)
        );
    end component;

-- Components for Snake
-- Components for menu selection?
-- Components for setting options
-- Components for random apples generation 
    -- (Maybe component will be called in another component)
    -- Return different combinations of settings.
    -- Bitpacking information into 
-- State we have? Initial state (Menu selection)
    -- One state for each menu options (Start, Settings, End)
    -- Other "sub" states for each options
    -- For example after start, we have ongoing, game over, etc.

    signal CLK: std_logic;
    
    signal digital: unsigned(7 downto 0);

begin
    HSOSC_instance : HSOSC port map
                            (CLKHFPU => '1', CLKHFEN => '1', CLKHF => CLK);
    
    NES_instance: NES port map (CLK, data, latch, continCLK, digital);
    
    -- display_instance: display port map ();
    
    
    

--     a <= '1';
end;



