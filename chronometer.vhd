LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------
ENTITY chronometer IS
	PORT		(	clk			:	IN		STD_LOGIC;
					rst			:	IN		STD_LOGIC;
					go				:	IN		STD_LOGIC;
					syn_clr		:	IN		STD_LOGIC;
					max_dig 		:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
					max_chron 	:	IN		STD_LOGIC_VECTOR(22 DOWNTO 0));
END ENTITY;
------------------------------------------------------------------
ARCHITECTURE rtl OF chronometer IS
SIGNAL ena_tenths		:	STD_LOGIC;
SIGNAL ena_ones		:	STD_LOGIC;
SIGNAL ena_decimal	:	STD_LOGIC;
SIGNAL tenths			:	STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL ones				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL decimal			:	STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
	CHRONOMETER_COUNTER: ENTITY work.counter_23_bits
		PORT MAP( clk 			=>	clk,
					 rst 			=> rst,
					 syn_clr		=> syn_clr,
					 ena        => go,
					 load			=> '0',
					 up 			=> '1',
					 max			=> max_chron,
					 max_tick   => ena_decimal);

	DECIMAL_COUNTER: ENTITY work.counter_4_bits
		PORT MAP( clk 			=>	clk,
					 rst 			=> rst,
					 syn_clr		=> syn_clr,
					 ena        => ena_decimal,
					 load			=> '0',
					 up 			=> '1',
					 d				=>	"0000",
					 max			=> max_dig,
					 max_tick   => ena_ones,
					 counter		=>	tenths);
					 
	ONES_COUNTER: ENTITY work.counter_4_bits
	PORT MAP(clk		=>	clk,
				rst		=>	rst,
				syn_clr	=> syn_clr,
				ena      => ena_ones,
				load		=> '0',
				up 		=> '1',
			   d			=>	"0000",
				max		=> max_dig,
				max_tick => ena_tenths,
				counter	=>	ones);
				
	TENTHS_COUNTER: ENTITY work.counter_4_bits
	PORT MAP(clk		=>	clk,
				rst		=>	rst,
				syn_clr	=> syn_clr,
				ena      => ena_tenths,
				load		=> '0',
				up 		=> '1',
			   d			=>	"0000",
				max		=> max_dig,
				counter	=>	tenths);
END ARCHITECTURE;