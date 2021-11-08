--	Identificação: Eduardo Vaz Fagundes Rech - 18/0075161
--  Disciplina: CIC00999 - Organização e Arquitetura de Computadores - Turma C
--  Trabalho: Trabalho Final - Processador Multiciclo

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ulaRV is
	generic (WSIZE : natural := 32);
	port (
		opcode : in std_logic_vector(3 downto 0);
		A, B : in std_logic_vector(WSIZE-1 downto 0);
		Z : out std_logic_vector(WSIZE-1 downto 0);
		cond : out std_logic);
end ulaRV;

architecture arch of ulaRV is
constant TRUE: std_logic_vector(31 downto 0) := x"00000001";
constant FALSE: std_logic_vector(31 downto 0) := x"00000000";
begin
	process(A, B, opcode)
	begin
		case opcode is
			when "0000" =>
				Z <= std_logic_vector(signed(A) + signed(B));

			when "0001" =>
				Z <= std_logic_vector(signed(A) - signed(B));

			when "0010" =>
				Z <= A and B;

			when "0011" =>
				Z <= A or B;

			when "0100" =>
				Z <= A xor B;

			when "0101" =>
				Z <= std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B))));

			when "0110" =>
				Z <= std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B))));

			when "0111" =>
				Z <= std_logic_vector(shift_right(signed(A), to_integer(unsigned(B))));

			when "1000" =>
				if(signed(A) < signed(B)) then
					Z <= TRUE;
					cond <= '1';
				else
					Z <= FALSE;
					cond <= '0';
				end if;

			when "1001" =>
				if(unsigned(A) < unsigned(B)) then
					Z <= TRUE;
					cond <= '1';
				else
					Z <= FALSE;
					cond <= '0';
				end if;

			when "1010" =>
				if(signed(A) >= signed(B)) then
					Z <= TRUE;
					cond <= '1';
				else
					Z <= FALSE;
					cond <= '0';
				end if;

			when "1011" =>
				if(unsigned(A) >= unsigned(B)) then
					Z <= TRUE;
					cond <= '1';
				else
					Z <= FALSE;
					cond <= '0';
				end if;

			when "1100" =>
				if(signed(A) = signed(B)) then
					Z <= TRUE;
					cond <= '1';
				else
					Z <= FALSE;
					cond <= '0';
				end if;

			when "1101" =>
				if(signed(A) /= signed(B)) then
					Z <= TRUE;
					cond <= '1';
				else
					Z <= FALSE;
					cond <= '0';
				end if;
				
			when others =>
				Z <= (others => 'Z');
		end case;
	end process;
end arch;
