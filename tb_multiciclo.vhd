library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
--------------------------------------------------------

entity testbench_multiciclo IS END;

architecture tb_multiciclo of testbench_multiciclo is
    component RVMulticiclo is
        port(clock :in std_logic);
    end component;
--------------------------------------------------------
    signal clk : std_logic := '0';

    Begin

    rv: RVMulticiclo PORT MAP (clk);

    clk <= not clk after 5 ns;
end tb_multiciclo;