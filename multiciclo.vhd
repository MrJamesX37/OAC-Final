library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
------------------------------------------------------
entity RVMulticiclo is
    port(clock :in std_logic);
end RVMulticiclo;
------------------------------------------------------

architecture multiciclo of RVMulticiclo is

    component pc is
        port(
            addr_in: in std_logic_vector(31 downto 0);
            clk: in std_logic;
            addr_out: out std_logic_vector(31 downto 0)
        );
    end component;

    component mux2 is 
        port (
            sel: in std_logic;
            A: in std_logic_vector(31 downto 0);
            B: in std_logic_vector(31 downto 0);
            S: out std_logic_vector(31 downto 0));
    end component;

    component mux4 is
        port (
            sel: in std_logic_vector(1 downto 0);
            A: in std_logic_vector(31 downto 0);
            B: in std_logic_vector(31 downto 0);
            C: in std_logic_vector(31 downto 0);
            D: in std_logic_vector(31 downto 0);
            S: out std_logic_vector(31 downto 0));
    end component;

    component mem_rv is 
        port(
            clock: in std_logic;
            wren: in std_logic;
            address: in std_logic_vector(11 downto 0);
            data_in: in std_logic_vector(31 downto 0);
            data_out: out std_logic_vector(31 downto 0));
    end component;

    component XREGS is
        generic (WSIZE : natural := 32);
        port (
            clk, wren, rst : in std_logic;
            rs1, rs2, rd : in std_logic_vector(4 downto 0);
            data : in std_logic_vector(WSIZE-1 downto 0);
            ro1, ro2 : out std_logic_vector(WSIZE-1 downto 0));
    end component;

    component genImm32 is
        port(
            instr : in std_logic_vector(31 downto 0);
            imm32 : out std_logic_vector(31 downto 0));
    end component;
    
    component ulaRV is
        generic (WSIZE : natural := 32);
        port (
            opcode : in std_logic_vector(3 downto 0);
            A, B : in std_logic_vector(WSIZE-1 downto 0);
            Z : out std_logic_vector(WSIZE-1 downto 0);
            cond : out std_logic);
    end component;

    component control is
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
    end component;

    component ula_controle is
        port(
            clock: in std_logic;
            ulaOP: in std_logic_vector(1 downto 0);
            funct3: in std_logic_vector(2 downto 0);
            funct7: in std_logic;
            auipc: in std_logic;
            opOut: out std_logic_vector(3 downto 0));
    end component;
    
    -- Controle
    -- signal op       :std_logic_vector(6 downto 0);
    signal opALU    :std_logic_vector(1 downto 0);
    signal origBULA :std_logic_vector(1 downto 0);
    signal mem2Reg  :std_logic_vector(1 downto 0);
    signal escreveReg, escreveMem, leMem :std_logic;
    signal origAULA, IouD, escreveR  :std_logic;
    signal escrevePC, escrevePCCond  :std_logic;
    signal escrevePCB, origPC, auipc :std_logic;

    -- PC
    signal addr_in, addr_out :std_logic_vector(31 downto 0);

    -- MUX 1
    signal saidaULA, address :std_logic_vector(31 downto 0);

    -- Memoria
    signal data_in, data_out :std_logic_vector(31 downto 0);

    -- Registradores de instrucao e de dados
    signal IR, DR :std_logic_vector(31 downto 0);

    begin
        ctrl: control PORT MAP(
            clock, IR(6 downto 0), escreveREG, opALU,
            origAULA, origBULA, leMem, escreveMem,
            mem2Reg, IouD, escreveR, escrevePC,
            escrevePCCond, escrevePCB, origPC, auipc
        );
        pc_rv: pc PORT MAP (addr_in, clock, addr_out);
        mux01: mux2 PORT MAP(IouD, addr_out, saidaULA, address);
        mem: mem_rv PORT MAP(clock, escreveMem, address, data_in, data_out);

        -- Escrita nos registradore de instrucao e de dados
        process
        begin
            DR <= data_out;
            if EscreveR = '1' then IR <= data_out;
            end if;
        end process;



end multiciclo; 
