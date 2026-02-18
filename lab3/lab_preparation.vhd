-- part 1 
library ieee;
use ieee.std_logic_1164.all;

entity part1 is 
  port (s,r,clear,preset,en : in std_logic;
       q,q_n : out std_logic);
end entity;

architecture arch of part1 is
signal s_n,r_n,Q,Q_n,clear_n,preset_n : std_logic;
begin

s_n <= s nand en;
r_n <= r nand en;
clear_n <= not clear;
preset_n <= not preset;

 -- here we undefined behavior if both clear and preset are 0 q and q_n is both 1 
Q <= ((s_n nand Q_n) and clear) or  preset_n;
Q_n <= ((r_n nand Q) and preset) or clear_n ;

q <= Q;
q_n <= Q_n;

end architecture;



-- part 2 :
  -- D latch
library ieee;
use ieee.std_logic_1164.all;

entity d_latch is 
  port (d,clear,preset,en:in std_logic;
       q,q_n: out std_logic);
end entity;


architecture arch of d_latch is
signal s_n,r_n,Q,Q_n,clear_n,preset_n : std_logic;
begin

s_n <= d nand en;
r_n <= not(not d and en);
clear_n <= not clear;
preset_n <= not preset;

 -- here we undefined behavior if both clear and preset are 0 q and q_n is both 1 
Q <= ((s_n nand Q_n) and clear) or  preset_n;
Q_n <= ((r_n nand Q) and preset) or clear_n ;

q <= Q;
q_n <= Q_n;
end architecture;

-- master slave d latch
library ieee;
use ieee.std_logic_1164.all;

entity master_slave_d_latch is 
  port(d,cp,clear,preset:in std_logic;
      q,q_n: out std_logic);
end entity;

architecture arch of master_slave_d_latch is 
  signal q1,q1_n,cp_n : std_logic;
  component d_latch 
  port (d,clear,preset,en:in std_logic;
       q,q_n: out std_logic);
  end component;

begin
  cp_n <= not cp;
  inst1: d_latch port map (d,clear,preset,cp,q1,q1_n);
  inst2: d_latch port map (q1,clear,preset,cp_n,q,q_n);

end architecture;


-- part 3 

library ieee;
use ieee.std_logic_1164.all;

entity part3 is
    port (
        d     : in  std_logic;
        clk   : in  std_logic;
        q_a   : out std_logic;
        q_b   : out std_logic;
        q_c   : out std_logic
    );
end entity;

architecture behavioral of part3 is
    signal q_a_int : std_logic := '0';
    signal q_b_int : std_logic := '0';
    signal q_c_int : std_logic := '0';
begin

   process(d, clk)
    begin
        if clk = '1' then
            q_a_int <= d;
        end if;
    end process;

   process(clk)
    begin
        if clk'event and clk = '1' then
            q_b_int <= d;
        end if;
    end process;

   process(clk)
    begin
        if clk'event and clk = '0' then
            q_c_int <= d;
        end if;
    end process;

    q_a <= q_a_int;
    q_b <= q_b_int;
    q_c <= q_c_int;

end architecture;


-- part 4 
library ieee;
use ieee.std_logic_1164.all;

entity jk_ff is 
  port (j,k,clear,preset,ck : in std_logic;
       q,q_n: out std_logic);
end entity ;

architecture arch of jk_ff is 

begin

  library ieee;
use ieee.std_logic_1164.all;

entity jk_ff is
    port (
        j         : in  std_logic;
        k         : in  std_logic;
        clk       : in  std_logic;
        preset_n  : in  std_logic;
        clear_n   : in  std_logic;
        q         : out std_logic;
        q_n       : out std_logic
    );
end entity;

architecture behavioral of jk_ff is
    signal q_int : std_logic;
    signal jk : std_logic_vector(1 downto 0);
begin

    process(clk, preset_n, clear_n)
    begin

        if clear_n = '0' then
            q_int <= '0';

        elsif preset_n = '0' then
            q_int <= '1';

        elsif clk'event and clk = '0' then
            case jk is

                when "00" => 
                    q_int <= q_int;

                when "01" => 
                    q_int <= '0';

                when "10" => 
                    q_int <= '1';

                when "11" => 
                    q_int <= not q_int;

                when others =>
                    null;
            end case;

        end if;
    end process;

    q   <= q_int;
    q_n <= not q_int;

end architecture;





