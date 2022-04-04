LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------
ENTITY chronometer_tb IS
END ENTITY;
------------------------------------------------------------------
ARCHITECTURE rtl OF chronometer_tb IS
SIGNAL clk_tb				:	STD_LOGIC :='0';
SIGNAL rst_tb				:	STD_LOGIC :='0';	
SIGNAL go_tb				:	STD_LOGIC :='0';	
SIGNAL syn_clr_tb			:	STD_LOGIC :='0';
SIGNAL max_dig_tb			:	STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL max_chron_tb		:	STD_LOGIC_VECTOR(22 DOWNTO 0);
SIGNAL tenths_tb			:	STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL ones_tb				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL decimal_tb			: 	STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
	clk_tb	<=	NOT clk_tb AFTER 10ns;

	rst_tb	<=	'0' AFTER 150ns,
					'1' AFTER 250ns,
					'0' AFTER 280ns;
	
	go_tb	<=	'1' AFTER 500ns;
	

	
	CHRONOMETER_COUNTER_TB: ENTITY work.chronometer
		PORT MAP(clk			=> clk_tb,
					rst			=> rst_tb,
					go				=> go_tb,
					syn_clr		=> syn_clr_tb,
					tenths		=>tenths_tb,
					ones			=>ones_tb,
					decimal		=>decimal_tb);
END ARCHITECTURE;