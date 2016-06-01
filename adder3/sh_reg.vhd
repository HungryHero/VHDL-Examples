Library ieee;
Use ieee.std_logic_1164.all, work.p1_pack.all;
Entity sh_reg is
Generic (n : natural);
-- generic parameter default to 4
Port (x : in std_logic_vector(n-1 downto 0);
z : out std_logic;
Sel : in sh_reg_sel;
Ck : in std_logic);
End sh_reg;

Architecture behav of sh_reg is
Signal temp : std_logic_vector(n-1 downto 0);
-- temp holds the content of the register
Begin -- architecture body
-- process runs when clock signal changes
Process(ck)
begin
If ck = '1' and ck'event then
-- This is the rising edge of the clock
case sel is
 when no_op => null;
 when load => temp <= x;
 when shift =>
 for i in n-2 downto 0 loop
 temp(i) <= temp (i+1);
 end loop;
end case;
end if;
end process; 
z <= temp(0);
-- concurrent statement
-- wiring internal signal to output
end behav;