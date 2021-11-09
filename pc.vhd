--	Identificação: Eduardo Vaz Fagundes Rech - 18/0075161
--  Disciplina: CIC00999 - Organização e Arquitetura de Computadores - Turma C
--  Trabalho: Trabalho Final - Processador Multiciclo

library IEEE;
use IEEE.std_logic_1164.all;

entity pc is
port(
	addr_in: in std_logic_vector(31 downto 0);
	wren: in std_logic;
	clk: in std_logic;
	addr_out: out std_logic_vector(31 downto 0)
);
end pc;

architecture arch of pc is
	signal current_state :std_logic_vector(31 downto 0) := (others => '0');
begin
	process(clk)
	begin
		if rising_edge(clk) and wren = '1' then
			addr_out <= addr_in;
			current_state <= addr_in;
		else
			addr_out <= current_state;
		end if;
	end process;
end arch;