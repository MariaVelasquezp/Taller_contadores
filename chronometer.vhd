LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------
ENTITY chronometer IS
	PORT		(	clk				:	IN		STD_LOGIC;
					rst				:	IN		STD_LOGIC;
					go					:	IN		STD_LOGIC;
					syn_clr			:	IN		STD_LOGIC;
					tenths			:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
					ones				:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
					decimal			:	OUT 	STD_LOGIC_VECTOR(3 DOWNTO 0));
END ENTITY;
------------------------------------------------------------------
ARCHITECTURE rtl OF chronometer IS
SIGNAL ena_tenths		:	STD_LOGIC;
SIGNAL ena_ones		:	STD_LOGIC;
SIGNAL ena_decimal	:	STD_LOGIC;
BEGIN
	CHRONOMETER_COUNTER: ENTITY work.counter_23_bits
		PORT MAP( clk 			=>	clk,
					 rst 			=> rst,
					 syn_clr		=> syn_clr,
					 ena        => go,
					 load			=> '0',
					 up 			=> '1',
					 max			=>"10011000100101101000000",
					 max_tick   => ena_decimal);

	DECIMAL_COUNTER: ENTITY work.counter_4_bits
		PORT MAP( clk 			=>	clk,
					 rst 			=> rst,
					 syn_clr		=> syn_clr,
					 ena        => ena_decimal,
					 load			=> '0',
					 up 			=> '1',
					 d				=>	"0000",
					 max			=> "1001",
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
				max		=> "1001",
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
				max		=> "1001",
				counter	=>	decimal);
END ARCHITECTURE;