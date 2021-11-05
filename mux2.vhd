--	Identificação: Eduardo Vaz Fagundes Rech - 18/0075161
--  Disciplina: CIC00999 - Organização e Arquitetura de Computadores - Turma C
--  Trabalho: Trabalho Final - Processador Multiciclo

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2 is
	port (
		sel: in std_logic;
		A: in std_logic_vector(31 downto 0);
		B: in std_logic_vector(31 downto 0);
		S: out std_logic_vector(31 downto 0));
end mux2;

architecture arch of mux2 is
begin
	process(sel, A, B)
	begin
		if sel = '0' then
			S <= A;
		else
			S <= B;
		end if;
	end process;
end arch;