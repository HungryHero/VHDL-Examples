----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2016 04:05:16 PM
-- Design Name: 
-- Module Name: PE - Behavioral
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
entity PE is
port (x_in, y_in, ps_in, c_in : in std_logic;
        x_out, y_out, ps_out, c_out: out std_logic);
end PE;

architecture concurrent of PE is
signal temp: std_logic;
begin
temp <= x_in and y_in;
x_out <= x_in; y_out <= y_in;
c_out <= (ps_in and temp) or (temp and c_in) or (c_in and ps_in);
ps_out <= ps_in xor temp xor c_in;
end concurrent;