--	Identificação: Eduardo Vaz Fagundes Rech - 18/0075161
--  Disciplina: CIC00999 - Organização e Arquitetura de Computadores - Turma C
--  Trabalho: Trabalho Final - Processador Multiciclo

library IEEE;
use IEEE.std_logic_1164.all;

entity mux4 is
	port (
		sel: in std_logic_vector(1 downto 0);
		A: in std_logic_vector(31 downto 0);
		B: in std_logic_vector(31 downto 0);
		C: in std_logic_vector(31 downto 0);
		D: in std_logic_vector(31 downto 0);
		S: out std_logic_vector(31 downto 0));
end mux4;

architecture arch of mux4 is
begin
	process(sel, A, B, C, D)
	begin
		case sel is
			when "00" =>
				S <= A;
			when "01" =>
				S <= B;
			when "10" =>
				S <= C;
			when "11" =>
				S <= D;
			when others =>
				S <= x"00000000";
		end case;
	end process;
end arch;