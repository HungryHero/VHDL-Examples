----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2016 03:58:21 PM
-- Design Name: 
-- Module Name: serial_adder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


LIBRARY ieee;
USE ieee.std_logic_1164.All;
entity serial_adder is
generic (N : natural);
port (
	signal a,b,clk,en : in std_logic;
	signal s : out std_logic_vector(N-1 downto 0);
	signal cout, done : out std_logic);
end serial_adder;

architecture beh of serial_adder is
signal state, carry, sum : std_logic;
signal temp : std_logic_vector(N-1 downto 0);
begin

trans_and_count : process(clk, en)
variable counter : integer := 0;
begin
if (en = '0') then -- reset
	state <= '0';
	counter := 0;
	temp <= (others => '0');
	done <= '0';
	elsif clk = '1' and clk'event then
		if (counter < N) then -- move to next bit
			done <= '0';
			state <= carry;
			counter := counter + 1;
			temp(N-1) <= sum;
			for i in N-2 downto 0 loop
				temp(i) <= temp(i+1);
			end loop;
		else                -- the addition is done
			done <= '1';
		end if;
	
end if;
end process trans_and_count;


cout <= state; -- wire state (storage for carry synch with ck) to port cout

output : process(a,b,state)
begin
	sum <= a xor b xor state;
	carry <= (a and b) or (a and state) or (b and state);
end process output;

s <= temp; --wire to output

end beh;
