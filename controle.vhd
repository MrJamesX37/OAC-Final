--	Identificação: Eduardo Vaz Fagundes Rech - 18/0075161
--  Disciplina: CIC00999 - Organização e Arquitetura de Computadores - Turma C
--  Trabalho: Trabalho Final - Processador Multiciclo

library IEEE;
use IEEE.std_logic_1164.all;

entity control is
port(
	op: in std_logic_vector(6 downto 0);

	escreveReg: out std_logic;
	opALU: out std_logic_vector(1 downto 0);
	origAULA: out std_logic;
	origBULA: out std_logic_vector(1 downto 0);
	leMem: out std_logic;
	escreveMem: out std_logic;
	mem2Reg: out std_logic_vector(1 downto 0);
	IouD: out std_logic;
	escreveR: out std_logic;
	escrevePC: out std_logic;
	escrevePCCond: out std_logic;
	escrevePCB: out std_logic;
	origPC: out std_logic);
end control;

architecture arch of control is
begin
	process(op)
	begin
		case op is
			when "0110011" =>	--Tipo R
				escreveReg <= '1';
				opALU <= "10";
				origAULA <= '1';
				origBULA <= "00";
				leMem <= '1';
				escreveMem <= '0';
				mem2Reg <= "00"; 
				IouD <= '0';
				escreveR <= '1';
				escrevePC <= '1';
				escrevePCCond <= '0';
				escrevePCB <= '1';
				origPC <= '0';

			when "0010011" =>	--Tipo I
				escreveReg <= '0';
				opALU <= "00";
				origAULA <= '0';
				origBULA <= "11";
				leMem <= '1';
				escreveMem <= '0';
				mem2Reg <= "00";
				IouD <= '0';
				escreveR <= '1';
				escrevePC <= '1';
				escrevePCCond <= '0';
				escrevePCB <= '1';
				origPC <= '0';
				
			when "1100011" =>	--Branch
				escreveReg <= '0';
				opALU <= "01";
				origAULA <= '1';
				origBULA <= "00";
				leMem <= '1';
				escreveMem <= '0';
				mem2Reg <= "00";
				IouD <= '0';
				escreveR <= '1';
				escrevePC <= '1';
				escrevePCCond <= '1';
				escrevePCB <= '1';
				origPC <= '1';
				
			when "0000011" =>	--LW
				escreveReg <= '1';
				opALU <= "00";
				origAULA <= '1';
				origBULA <= "10";
				leMem <= '1';
				escreveMem <= '0';
				mem2Reg <= "10";
				IouD <= '1';
				escreveR <= '1';
				escrevePC <= '1';
				escrevePCCond <= '0';
				escrevePCB <= '1';
				origPC <= '0';

			when "0100011" =>	--SW
				escreveReg <= '0';
				opALU <= "00";
				origAULA <= '1';
				origBULA <= "10";
				leMem <= '1';
				escreveMem <= '1';
				mem2Reg <= "00";
				IouD <= '1';
				escreveR <= '1';
				escrevePC <= '1';
				escrevePCCond <= '0';
				escrevePCB <= '1';
				origPC <= '0';

			when "0110111" =>	--LUI
				-- ????
				escreveReg <= '0';
				opALU <= "00";
				origAULA <= '0';
				origBULA <= "00";
				leMem <= '0';
				escreveMem <= '0';
				mem2Reg <= "00";
				IouD <= '0';
				escreveR <= '0';
				escrevePC <= '0';
				escrevePCCond <= '0';
				escrevePCB <= '0';
				origPC <= '0';

			when "0010111" =>	--AUIPC
				-- ????
				escreveReg <= '0';
				opALU <= "00";
				origAULA <= '0';
				origBULA <= "00";
				leMem <= '0';
				escreveMem <= '0';
				mem2Reg <= "00";
				IouD <= '0';
				escreveR <= '0';
				escrevePC <= '0';
				escrevePCCond <= '0';
				escrevePCB <= '0';
				origPC <= '0';

			when "1101111" =>	--JAL
				escreveReg <= '1';
				opALU <= "00";
				origAULA <= '1';
				origBULA <= "01";
				leMem <= '1';
				escreveMem <= '0';
				mem2Reg <= "01";
				IouD <= '0';
				escreveR <= '1';
				escrevePC <= '1';
				escrevePCCond <= '0';
				escrevePCB <= '1';
				origPC <= '1';

			when "1100111" =>	--JALR
				escreveReg <= '0';
				opALU <= "00";
				origAULA <= '1';
				origBULA <= "01";
				leMem <= '1';
				escreveMem <= '0';
				mem2Reg <= "01";
				IouD <= '0';
				escreveR <= '1';
				escrevePC <= '1';
				escrevePCCond <= '0';
				escrevePCB <= '1';
				origPC <= '1';

			when others =>
				escreveReg <= '0';
				opALU <= "00";
				origAULA <= '0';
				origBULA <= "00";
				leMem <= '0';
				escreveMem <= '0';
				mem2Reg <= "00";
				IouD <= '0';
				escreveR <= '0';
				escrevePC <= '0';
				escrevePCCond <= '0';
				escrevePCB <= '0';
				origPC <= '0';

		end case;
	end process;
end arch;