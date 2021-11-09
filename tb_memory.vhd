library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is
end testbench;

architecture circuits of testbench is
    component mem_rv is
        port (
            clock: in std_logic;
            wren: in std_logic;
            address: in std_logic_vector;
            data_in: in std_logic_vector;
            data_out: out std_logic_vector);
    end component;

    signal clk : std_logic := '0';
    signal we  : std_logic := '0';
    signal adr : std_logic_vector(11 DOWNTO 0);
    signal data, dout : std_logic_vector(31 DOWNTO 0);

begin
    mem: mem_rv PORT MAP (clk, we, adr, data, dout);
    clk <= not(clk) after 5 ps;

    estimulo: PROCESS
    begin
        for i in 0 to 14 loop -- Mostrando a parte de texto da memoria incializada
            adr <= std_logic_vector(to_unsigned(i, 12));
            data <= std_logic_vector(to_unsigned(i, 30)) & "00";
            wait for 10 ps;
        end loop;

        for i in 0 to 19 loop -- Mostrando a parta de dados da memoria incializada
            adr <= std_logic_vector(to_unsigned(i + 2048, 12));
            data <= std_logic_vector(to_unsigned(i, 30)) & "00";
            wait for 10 ps;
        end loop;

        we <= '1';

        for i in 0 to 255 loop
            adr <= std_logic_vector(to_unsigned(i, 12));
            data <= std_logic_vector(to_unsigned(i, 30)) & "00";
            wait for 10 ps;
        end loop;

    end PROCESS estimulo;
end architecture circuits; -- of signal_trace