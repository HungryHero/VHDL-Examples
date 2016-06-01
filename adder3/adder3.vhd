----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2016 04:05:58 PM
-- Design Name: 
-- Module Name: adder3 - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder3 is
port(a,b : in std_logic_vector(2 downto 0);
    C : out std_logic_vector(2 downto 0);
    C_out : out std_logic;
    Go, reset, ck, b1, b2 : in std_logic);
end adder3;

architecture Behavioral of adder3 is
signal ck_step : std_logic;
component adder
generic (k: natural);
port (a,b : in std_logic_vector(k-1 downto 0);
        C : out std_logic_vector(k-1 downto 0);
        C_out : out std_logic;
        Go, reset, ck : in std_logic);
end component;
type db_state is (not_rdy, rdy, pulse);
signal db_ns: db_state;
signal en: std_logic;
begin

U2: adder generic map(3) port map (a => a,b => b,C => C,C_out => C_out,Go => Go,reset => reset, ck => ck_step);
process(ck,b1,b2)
begin
if ck='1' and ck'event then
case db_ns is
when not_rdy =>
if b2 = '1' then db_ns <= rdy; end if;
ck_step <= '0';
when rdy => ck_step <= '0';
if b1 = '1' then db_ns <= pulse; end if;
when pulse => ck_step <= '1';
db_ns <= not_rdy;
when others => null;
end case;
end if;
end process;



end Behavioral;
