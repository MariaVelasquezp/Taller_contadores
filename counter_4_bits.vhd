LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------
ENTITY counter_4_bits IS
	PORT		(	clk		:	IN		STD_LOGIC;
					rst		:	IN		STD_LOGIC;
					ena		:	IN		STD_LOGIC;
					max		:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
					syn_clr	:	IN		STD_LOGIC;
					load		:	IN		STD_LOGIC;
					up			:	IN		STD_LOGIC;
					d			:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
					max_tick :	OUT	STD_LOGIC;
					counter	: 	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0));
END ENTITY;
------------------------------------------------------------------
ARCHITECTURE rtl OF counter_4_bits IS
SIGNAL reset		: STD_LOGIC;
SIGNAL counter_s	: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL max_s		: STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
	CONTADOR: ENTITY work.univ_bin_counter
	PORT MAP( clk			=> clk,
				 rst			=> rst OR reset,
				 ena			=>	ena,	
				 syn_clr		=>	syn_clr,
				 load			=> load,
				 up			=> up,
				 d 			=> d,
				 counter		=>	counter_s);
				 
	max_s		<=	STD_LOGIC_VECTOR (UNSIGNED (max)+1);
	counter	<= counter_s;
	max_tick <= reset;
	
	PROCESS (counter_s,reset,max_s)
	BEGIN
		IF(counter_s = (max_s)) THEN
			reset <= '1';
			ELSE reset <= '0';
		END IF;
	END PROCESS;
END ARCHITECTURE;