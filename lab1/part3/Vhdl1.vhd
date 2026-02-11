library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity alu is 
	port(a,b: in unsigned(3 downto 0);
	sel:in unsigned(3 downto 0);
	cf,nf,zf: out std_logic;
	y: out unsigned(3 downto 0));
end entity;

architecture arch of alu is 
signal r : unsigned (4 downto 0);
begin
	r <='0' & (a and b) when sel="0000"else
	'0' & (a or b) when sel="0001"else
	'0' & (not a) when sel="0010"else
	'0' & (not b) when sel="0011"else
	'0' & (a xor b) when sel="0100"else
	'0' & (a xnor b) when sel="0101"else
	
	('0' & a)+b when sel="1000"else
	('0' & a)-b when sel="1001"else
	('0' & a)+1 when sel="1010"else
	('0' & a)-1 when sel="1011"else
	('0' & b)+1 when sel="1100"else
	('0' & b)-1 when sel="1101"else
	('0' &(not a))+1 when sel="1110"else
	('0' &(not b))+1 when sel="1111";
y<=r(3 downto 0);
cf<= R(4);
nf<=R(3);
zf<=not (r(3) or r(2) or r(1) or r(0));
end architecture;