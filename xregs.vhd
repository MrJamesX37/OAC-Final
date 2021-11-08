--	Identificação: Eduardo Vaz Fagundes Rech - 18/0075161
--  Disciplina: CIC00999 - Organização e Arquitetura de Computadores - Turma C
--  Trabalho: Trabalho Final - Processador Multiciclo

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity XREGS is
	generic (WSIZE : natural := 32);
	port (
		clk, wren, rst : in std_logic;
		rs1, rs2, rd : in std_logic_vector(4 downto 0);
		data : in std_logic_vector(WSIZE-1 downto 0);
		ro1, ro2 : out std_logic_vector(WSIZE-1 downto 0));
end XREGS;

architecture arch of XREGS is
	type mem_type is array(0 to WSIZE-1) of std_logic_vector(WSIZE-1 downto 0);

	signal addr1 : integer := 0;
	signal addr2 : integer := 0;
	signal wAddr : integer := 0;
	signal breg : mem_type := (others => (others => '0'));

	begin
		addr1 <= to_integer(unsigned(rs1));
		addr2 <= to_integer(unsigned(rs2));
		wAddr <= to_integer(unsigned(rd));

		ro1 <= breg(addr1);
		ro2 <= breg(addr2);

		process(clk, wren, rst, rd, wAddr)
		begin
			if rst = '1' then
				breg <= (others => (others => '0'));
			elsif rising_edge(clk) and (wren = '1') and (wAddr /= 0) then
				breg(wAddr) <= data;
			end if;
		end process; 
end arch;