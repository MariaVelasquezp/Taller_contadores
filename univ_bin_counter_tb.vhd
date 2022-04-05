-----------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
-----------------------------------------------------
ENTITY univ_bin_counter_tb IS	
			GENERIC	(	N			:	INTEGER := 4);
END ENTITY univ_bin_counter_tb;
--------------------------------------------------------
ARCHITECTURE testbench OF univ_bin_counter_tb IS

	SIGNAL clk_tb			:	STD_LOGIC := '0';
	SIGNAL rst_tb			:	STD_LOGIC;
	SIGNAL ena_tb			:	STD_LOGIC := '1';
	SIGNAL syn_clr_tb		:	STD_LOGIC := '0';
	SIGNAL load_tb			:	STD_LOGIC := '0';
	SIGNAL up_tb			:	STD_LOGIC := '0';
	SIGNAL d_tb				:	STD_LOGIC_VECTOR(N-1 DOWNTO 0):="1010";
	SIGNAL max_tick_tb	:	STD_LOGIC;
	SIGNAL min_tick_tb	:	STD_LOGIC;
	SIGNAL counter_tb		: 	STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	
BEGIN

	clk_tb	<=	NOT clk_tb AFTER 10ns;
	
	rst_tb	<=	'1' AFTER 0ns,
					'0' AFTER 1ns;		
	
	counter: ENTITY WORK.univ_bin_counter
	GENERIC	MAP (	N	=>  N)
	PORT MAP(	clk	    =>	clk_tb,
					rst		 =>	rst_tb,
					ena		 =>	ena_tb,
					syn_clr	 =>	syn_clr_tb,
					load		 =>	load_tb,
					up			 =>	up_tb,
					d			 =>	d_tb,
					max_tick  =>	max_tick_tb,
					min_tick  =>	min_tick_tb,
					counter   =>	counter_tb);
		
END ARCHITECTURE testbench;