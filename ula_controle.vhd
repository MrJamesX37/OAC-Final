--	Identificação: Eduardo Vaz Fagundes Rech - 18/0075161
--  Disciplina: CIC00999 - Organização e Arquitetura de Computadores - Turma C
--  Trabalho: Trabalho Final - Processador Multiciclo

library IEEE;
use IEEE.std_logic_1164.all;

entity ula_controle is
port(
	clock: in std_logic;
	ulaOP: in std_logic_vector(1 downto 0);
	funct3: in std_logic_vector(2 downto 0);
	funct7: in std_logic;
	auipc: in std_logic;
	funct_enable: in std_logic;
	opOut: out std_logic_vector(3 downto 0));
end ula_controle;

architecture arch of ula_controle is
begin
	process(clock, ulaOP, funct3, funct7, auipc)
	begin
		if rising_edge(clock) then
			if funct_enable = '1' then
				case ulaOP is
					when "00" =>
						case funct3 is
							when "000" =>
								if funct7 = '0' then
									opOut <= "0000"; -- ADD
								else
									opOut <= "0001"; -- SUB
								end if;
							when "010" =>
								opOut <= "1000"; -- SLT
							when "011" =>
								opOut <= "1001"; -- SLTU
							when "100" =>
								opOut <= "0100"; -- XOR
							when "110" =>
								opOut <= "0011"; -- OR
							when "111" =>
								opOut <= "0010"; -- AND
							when others =>
								opOut <= "0000";
						end case;
					when "01" =>
						case funct3 is
							when "000" =>
								opOut <= "0000"; -- ADDi
							when "010" =>
								opOut <= "1000"; -- SLTI
							when "011" =>
								opOut <= "1001"; -- SLTUI
							when others =>
								opOut <= "0000";
						end case;
					when "10" =>
						case funct3 is
							when "000" =>
								opOut <= "1100"; -- BEQ
							when "001" =>
								opOut <= "1101"; -- BNE
							when others =>
								opOut <= "0000";
						end case;
					when "11" =>
						if auipc = '0' then
							opOut <= "1110"; -- LUI
						else
							opOut <= "1111"; -- AUIPC
						end if;
					when others =>
						opOut <= "0000";
				end case;
			else
				opOut <= "0000";
			end if;
		end if;
	end process;
end arch;