library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is 
  port(
    a, b : in  unsigned(3 downto 0);
    sel  : in  unsigned(3 downto 0);
    cf, nf, zf : out std_logic;
    y    : out unsigned(3 downto 0)
  );
end entity;

architecture arch of alu is 
  signal r : unsigned(4 downto 0);
begin

  with sel select
    r <= ('0' & (a and b)) when "0000",
         ('0' & (a or  b)) when "0001",
         ('0' & (not a))   when "0010",
         ('0' & (not b))   when "0011",
         ('0' & (a xor b)) when "0100",
         ('0' & (a xnor b))when "0101",
         ('0' & (a(0) & a(3 downto 1))) when "0110", 
         ('0' & (a(2 downto 0) & a(3)))  when "0111", 
         (('0' & a) + ('0' & b))  when "1000",
         (('0' & a) - ('0' & b))when "1001",
         (('0' & a) + 1) when "1010",
         (('0' & a) - 1)when "1011",
         (('0' & b) + 1) when "1100",
         (('0' & b) - 1) when "1101",
         (('0' & (not a)) + 1)when "1110",
         (('0' & (not b)) + 1) when "1111",
         (others => '0') when others;

  y  <= r(3 downto 0);
  cf <= r(4);
  nf <= r(3);
  zf <= not (r(3) or r(2) or r(1) or r(0));

end architecture;
