LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

entity top is 
    port(
        -- NES controllers IO
        data: in std_logic;
        latch: out std_logic;
        continCLK: out std_logic;

        -- VGA display IO
        pll_in_clock : in std_logic; -- pin 20, shorted to the 12 MHz pin on the UPduino
        pll_outcore_o : out std_logic; -- pin 21, for testing purposes

        HSYNC : out std_logic; -- pin 46
        VSYNC : out std_logic; -- pin 2
        
		delete_me: out unsigned(2 downto 0);
        rgb : out unsigned(5 downto 0) -- pins 47, 45, 48, 3, 4, 44

        --pll_outcore_o : out std_logic -- for testing purposes (pin 2)
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

    component display is
        port(
            pll_in_clock : in std_logic; -- pin 20, shorted to the 12 MHz pin on the UPduino
            pll_outcore_o : out std_logic; -- pin 21, for testing purposes
    
            HSYNC : out std_logic; -- pin 46
            VSYNC : out std_logic; -- pin 2
            
            rgb : out unsigned(5 downto 0); -- pins 47, 45, 48, 3, 4, 44
    
            -- Game logic
            apple: in unsigned(8 downto 0);
            snake_head: in unsigned(6 downto 0);
            snake: in std_logic_vector(99 downto 0);
            scores: in unsigned(6 downto 0);
            game_state: in unsigned(1 downto 0)
        );
    end component;

    component board is
        port (
            clk: in std_logic;
            game_state: out unsigned(1 downto 0);
            digital: in unsigned(7 downto 0);

            snake_head: out unsigned(6 downto 0);
            -- Return the cell ID (0-99)
            apple_id: out unsigned(8 downto 0);
            -- Return whether snake is in each cell (0-99)
            snake: out std_logic_vector(99 downto 0);

            scores: out unsigned(6 downto 0)
            );
    end component;

    signal CLK: std_logic;
    
    signal digital: unsigned(7 downto 0);

    signal gameState: unsigned(1 downto 0) := "00";

    signal snake_head: unsigned(6 downto 0);
    signal apple_id: unsigned(6 downto 0);
    signal apple: unsigned(8 downto 0);
    signal snake: std_logic_vector(99 downto 0);
    signal scores: unsigned(6 downto 0) := 7d"0";
begin
    HSOSC_inst : HSOSC port map
                            (CLKHFPU => '1', CLKHFEN => '1', CLKHF => CLK);
    
    NES_inst: NES port map (CLK, data, latch, continCLK, digital);
    
    board_inst: board port map (clk, gameState, digital, snake_head, apple, snake, scores);

    -- apple <= 9b"1_0011_0011";

    display_inst: display port map (pll_in_clock, pll_outcore_o, HSYNC, VSYNC, rgb, apple, snake_head, snake, scores, gameState);

	delete_me <= digital(2 downto 0);
end;



