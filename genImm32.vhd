--	Identificação: Eduardo Vaz Fagundes Rech - 18/0075161
--  Disciplina: CIC00999 - Organização e Arquitetura de Computadores - Turma C
--  Trabalho: Trabalho Final - Processador Multiciclo

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity genImm32 is
	port(
		instr : in std_logic_vector(31 downto 0);
		imm32 : out std_logic_vector(31 downto 0));
end genImm32;

architecture arch of genImm32 is
	signal opcode : std_logic_vector(6 downto 0);
	signal aux : std_logic_vector(19 downto 0);
	signal aux_j : std_logic_vector(11 downto 0);

	signal R_Type : std_logic_vector(31 downto 0);
	signal I_Type : std_logic_vector(31 downto 0);
	signal S_Type : std_logic_vector(31 downto 0);
	signal SB_Type : std_logic_vector(31 downto 0);
	signal UJ_Type : std_logic_vector(31 downto 0);
	signal U_Type : std_logic_vector(31 downto 0);

begin

	opcode <= instr(6 downto 0);
	aux <= (others => instr(31));
	aux_j <= (others => instr(31));

	R_Type <= (others => '0');

	I_Type <= (aux & instr(31 downto 20));

	S_Type <= (aux & instr(31 downto 25) & instr(11 downto 7));

	SB_Type <= (aux & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0');

	UJ_Type <= (aux_j & instr(19 downto 12) & instr(20) & instr(30 downto 21) & '0');

	U_Type <= (instr(31 downto 12) & "000000000000");

	process(instr, opcode, R_Type, I_Type, S_Type, SB_Type, UJ_Type, U_Type)
	begin

		case opcode is
			when "0110011" => imm32 <= R_Type;
			when "0000011" => imm32 <= I_Type;
			when "0010011" => imm32 <= I_Type;
			when "1100111" => imm32 <= I_Type;
			when "0100011" => imm32 <= S_Type;
			when "1100011" => imm32 <= SB_Type;
			when "0110111" => imm32 <= U_Type;
			when "0010111" => imm32 <= U_Type;
			when "1101111" => imm32 <= UJ_Type;
			when others => imm32 <= R_Type;
		end case;
	end process;
end arch;