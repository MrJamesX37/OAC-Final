--	Identificação: Eduardo Vaz Fagundes Rech - 18/0075161
--  Disciplina: CIC00999 - Organização e Arquitetura de Computadores - Turma C
--  Trabalho: Trabalho Final - Processador Multiciclo

library IEEE;
use IEEE.std_logic_1164.all;

entity control is
port(
	clock: in std_logic;
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
	origPC: out std_logic;
	auipc: out std_logic);
end control;

architecture arch of control is
type STATE_TYPE is (Fetch, Decode, Jump, IType, IWrite, RType, RWrite, Branch, LS, SW, LW, MWrite, LUI, AUI);
signal state: STATE_TYPE := Fetch;
begin
	FSM: process(clock, op)
	begin
		if rising_edge(clock) then
			case state is
				when Fetch =>
					state <= Decode;
				when Decode =>
					case op is
						when "0110011" =>
							state <= RType;
						
						when "0010011" =>
							state <= IType;

						when "1100011" =>
							state <= Branch;

						when "1101111" =>
							state <= Jump;

						when "1100111" =>
							state <= Jump;

						when "0000011" =>
							state <= LS;
						when "0100011" =>
							state <= LS;

						when "0110111" =>
							state <= LUI;

						when "0010111" =>
							state <= AUI;

						when others =>
							state <= Fetch;
					end case;
				when Jump =>
					state <= Fetch;
				when IType =>
					state <= IWrite;
				when IWrite =>
					state <= Fetch;
				when RType =>
					state <= RWrite;
				when RWrite =>
					state <= Fetch;
				when Branch =>
					state <= Fetch;
				when LS =>
					case op is
						when "0000011" =>
							state <= LW;
						when "0100011" =>
							state <= SW;
						when others =>
							state <= Fetch;
					end case;
				when SW =>
					state <= Fetch;
				when LW =>
					state <= MWrite;
				when MWrite =>
					state <= Fetch;
				when LUI =>
					state <= RWrite;
				when AUI =>
					state <= RWrite;
				when others => 
					state <= Fetch;
			end case;
		end if;
	end process FSM;

	process(state)
	begin
		case state is
			when Fetch =>	
				escreveReg <= '0';
				opALU <= "00";
				origAULA <= '0';
				origBULA <= "01";
				leMem <= '1';
				escreveMem <= '0';
				mem2Reg <= "00"; 
				IouD <= '0'; 
				escreveR <= '1';
				escrevePC <= '1';
				escrevePCCond <= '0';
				escrevePCB <= '1';
				origPC <= '0';
				auipc <= '0';

			when Decode =>
				escreveReg <= '0';
				opALU <= "00";
				origAULA <= '0';
				origBULA <= "11";
				leMem <= '0';
				escreveMem <= '0';
				mem2Reg <= "00";
				IouD <= '0';
				escreveR <= '0';
				escrevePC <= '0';
				escrevePCCond <= '0';
				escrevePCB <= '0';
				origPC <= '0';
				auipc <= '0';

			when Jump =>
				escreveReg <= '1';
				opALU <= "00";
				origAULA <= '0';
				origBULA <= "00";
				leMem <= '0';
				escreveMem <= '0';
				mem2Reg <= "01";
				IouD <= '0';
				escreveR <= '0';
				escrevePC <= '1';
				escrevePCCond <= '0';
				escrevePCB <= '0';
				origPC <= '1';
				auipc <= '0';
				
			when IType =>
				escreveReg <= '0';
				opALU <= "00";
				origAULA <= '1';
				origBULA <= "10";
				leMem <= '0';
				escreveMem <= '0';
				mem2Reg <= "00";
				IouD <= '0';
				escreveR <= '0';
				escrevePC <= '0';
				escrevePCCond <= '0';
				escrevePCB <= '0';
				origPC <= '0';
				auipc <= '0';

			when IWrite =>
				escreveReg <= '1';
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
				auipc <= '0';

			when RType =>
				escreveReg <= '0';
				opALU <= "10";
				origAULA <= '1';
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
				auipc <= '0';

			when RWrite =>
				escreveReg <= '1';
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
				auipc <= '0';

			when Branch =>
				escreveReg <= '0';
				opALU <= "01";
				origAULA <= '1';
				origBULA <= "00";
				leMem <= '0';
				escreveMem <= '0';
				mem2Reg <= "00";
				IouD <= '0';
				escreveR <= '0';
				escrevePC <= '0';
				escrevePCCond <= '1';
				escrevePCB <= '0';
				origPC <= '1';
				auipc <= '0';

			when LS =>
				escreveReg <= '0';
				opALU <= "00";
				origAULA <= '1';
				origBULA <= "10";
				leMem <= '0';
				escreveMem <= '0';
				mem2Reg <= "00";
				IouD <= '0';
				escreveR <= '0';
				escrevePC <= '0';
				escrevePCCond <= '0';
				escrevePCB <= '0';
				origPC <= '0';
				auipc <= '0';

			when SW =>
				escreveReg <= '0';
				opALU <= "00";
				origAULA <= '0';
				origBULA <= "00";
				leMem <= '0';
				escreveMem <= '1';
				mem2Reg <= "00";
				IouD <= '1';
				escreveR <= '0';
				escrevePC <= '0';
				escrevePCCond <= '0';
				escrevePCB <= '0';
				origPC <= '0';
				auipc <= '0';

			when LW =>
				escreveReg <= '0';
				opALU <= "00";
				origAULA <= '0';
				origBULA <= "00";
				leMem <= '1';
				escreveMem <= '0';
				mem2Reg <= "00";
				IouD <= '1';
				escreveR <= '0';
				escrevePC <= '0';
				escrevePCCond <= '0';
				escrevePCB <= '0';
				origPC <= '0';
				auipc <= '0';
			
			when MWrite =>
				escreveReg <= '1';
				opALU <= "00";
				origAULA <= '0';
				origBULA <= "00";
				leMem <= '0';
				escreveMem <= '0';
				mem2Reg <= "10";
				IouD <= '0';
				escreveR <= '0';
				escrevePC <= '0';
				escrevePCCond <= '0';
				escrevePCB <= '0';
				origPC <= '0';
				auipc <= '0';
			
			when LUI =>
				escreveReg <= '1';
				opALU <= "11";
				origAULA <= '1';
				origBULA <= "10";
				leMem <= '0';
				escreveMem <= '0';
				mem2Reg <= "00";
				IouD <= '0';
				escreveR <= '0';
				escrevePC <= '0';
				escrevePCCond <= '0';
				escrevePCB <= '0';
				origPC <= '0';
				auipc <= '0';

			when AUI =>
				escreveReg <= '0';
				opALU <= "11";
				origAULA <= '1';
				origBULA <= "10";
				leMem <= '0';
				escreveMem <= '0';
				mem2Reg <= "00";
				IouD <= '0';
				escreveR <= '0';
				escrevePC <= '1';
				escrevePCCond <= '0';
				escrevePCB <= '0';
				origPC <= '1';
				auipc <= '1';

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
				auipc <= '0';
		end case;
	end process;
end arch;