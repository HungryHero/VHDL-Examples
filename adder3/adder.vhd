Library ieee;
Use ieee.std_logic_1164.all, work.p1_pack.all;
Entity adder is
Generic (k: natural);
-- k will be mapped onto the components used 
Port ( a, b : in std_logic_vector(k-1 downto 0);
 C : out std_logic_vector(k-1 downto 0);
 C_out : out std_logic;
Go,reset,ck : in std_logic);
End adder;
Architecture struc of adder is
-- Component declaration
-- copy-paste of entity declaration
-- declare the serial_adder
component serial_adder
generic(N : natural);
port (a,b,clk,en : IN std_logic;
 s : OUT std_logic_vector(N-1 DOWNTO 0);
 cout, done : OUT std_logic );
end component;

component sh_reg
generic (n : natural);
port(x : in std_logic_vector(n-1 downto 0);
z : out std_logic;
Sel : in sh_reg_sel;
Ck : in std_logic);
end component;

component control
Port (go, ck, reset, done : in std_logic;
 sel : out sh_reg_sel;
 En : out std_logic);
end component;
-- declare other components here namely
-- shift register, controller
-- internal signals (wires)
signal sel : sh_reg_sel;
signal a_bit,b_bit,done,en : std_logic;
begin
-- instantiate serial adder
s_adder: serial_adder generic map(k)
port map(a => a_bit, b => b_bit,clk => ck,en => en,s => C, cout => C_out,done => done);
-- instantiate shift-register A
reg_A: sh_reg generic map(k) port map(x => a,z => a_bit,Sel => sel,Ck => ck);
reg_B: sh_reg generic map(k) port map(x => b,z => b_bit,Sel => sel,Ck => ck);
controller: control port map (go => Go, ck => ck,reset => reset, done => done,sel => sel, En => en);
-- Instantiate other components, they are
-- shift register B and controller here
end struc;