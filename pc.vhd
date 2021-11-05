--	Identificação: Eduardo Vaz Fagundes Rech - 18/0075161
--  Disciplina: CIC00999 - Organização e Arquitetura de Computadores - Turma C
--  Trabalho: Trabalho Final - Processador Multiciclo

library IEEE;
use IEEE.std_logic_1164.all;

entity pc is
port(
	addr_in: in std_logic_vector(31 downto 0);
	clk: in std_logic;
	addr_out: out std_logic_vector(31 downto 0);
);
end pc;

architecture arch of pc is
begin
	process(clk)
	begin
		if rising_edge(clk) then
			addr_out <= addr_in;
		end if;
	end process;
end arch;