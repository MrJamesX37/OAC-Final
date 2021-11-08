--	Identificação: Eduardo Vaz Fagundes Rech - 18/0075161
--  Disciplina: CIC00999 - Organização e Arquitetura de Computadores - Turma C
--  Trabalho: Trabalho Final - Processador Multiciclo

library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity mem_rv is
	port(
		clock: in std_logic;
		wren: in std_logic;
		address: in std_logic_vector;
		data_in: in std_logic_vector;
		data_out: out std_logic_vector);
end mem_rv;

architecture arch of mem_rv is

type mem_type is array (0 to (2**address'length)-1) of std_logic_vector(data_in'range);

signal address_index: integer := 0;

impure function init_mem return mem_type is
	file data_file: text open read_mode is "data_hex.txt";
	file text_file: text open read_mode is "text_hex.txt";
	variable text_line: line;
	variable mem_content: mem_type;
	variable i: natural := 0;

	begin
		i := 16#0000#/4;
		while not endfile(text_file) loop
			readline(text_file, text_line);
			hread(text_line, mem_content(i));
			i := i + 1;
		end loop;

		i := 16#2000#/4;
		while not endfile(data_file) loop
			readline(data_file, text_line);
			hread(text_line, mem_content(i));
			i := i + 1;
		end loop;
		return mem_content;
end function;

signal mem_data: mem_type := init_mem;
signal read_address: std_logic_vector(address'range);
begin
	data_out <= mem_data(to_integer(unsigned(read_address)));
		
	Write: process(clock)
	begin
		if rising_edge(clock) then
			if wren = '1' then
				mem_data(to_integer(unsigned(address))) <= data_in;
			end if;
			read_address <= address;
		end if;
	end process;
end arch;
