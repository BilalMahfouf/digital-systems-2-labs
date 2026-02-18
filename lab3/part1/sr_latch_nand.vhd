library ieee;
use ieee.std_logic_1164.all;

entity sr_latch_nand is
    port (
        s       : in  std_logic;
        r       : in  std_logic;
        en      : in  std_logic;
        clear   : in  std_logic;  -- active high
        preset  : in  std_logic;  -- active high
        q       : out std_logic;
        q_n     : out std_logic
    );
end entity;

architecture rtl of sr_latch_nand is
    signal s_g      : std_logic;
    signal r_g      : std_logic;
    signal clear_n  : std_logic;
    signal preset_n : std_logic;
    signal q_int    : std_logic;
    signal qn_int   : std_logic;
begin

    -- invert async controls (nand latch uses active-low override)
    clear_n  <= not clear;
    preset_n <= not preset;

    -- enable gating (nand style)
    s_g <= not (s and en);
    r_g <= not (r and en);

    -- cross-coupled nand with async override
    q_int  <= not (s_g and qn_int and clear_n) or preset;
    qn_int <= not (r_g and q_int and preset_n) or clear;

    q   <= q_int;
    q_n <= qn_int;

end architecture;
