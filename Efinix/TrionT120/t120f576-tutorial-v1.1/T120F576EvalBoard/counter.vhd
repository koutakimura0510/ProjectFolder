-- smal example design for T120F576 Efinix Eval Board
-- By Harald Werner
-- 06.10.2020
-- 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter is
port (  clk 		: in std_logic;						-- clock input. external 30MHz clock use GPIOL_19
		 setn 		: in std_logic;						--  Set signal, low active; set all outputs to '1' (LED are low active, means all LEDs msut be OFF) GPIOB_RXP08
		 stopn 		: in std_logic;						-- Stop signal, low active Stop counting GPIOB_RXN08
	     Dataout 	: out std_logic_vector(3 downto 0)); -- Output data connected to the LEDs (high active); GPIOB_RXP04, GPIOB_RXN04, GPIOB_RXP05, GPIOB_RXN05 
end counter;
architecture vers1 of counter is
    signal cnt: std_logic_vector ( 29 downto 0) := (others => '0');
Begin
cnt_proc : process(clk, setn)
			Begin
				if setn = '0' then
					cnt 	<= (others => '1');
					dataout <= (others => '1');
				elsif clk'event and clk = '1' then
					if stopn = '0' then
						cnt <= cnt;
					else 
						cnt <= cnt +1;
					end if;
					Dataout <= cnt(27 downto 24);  		--For the 40MHz external clock use 27 downto 24
				end if;
			end process;
end vers1;
					