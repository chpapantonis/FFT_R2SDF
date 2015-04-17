library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;


entity top_module is
port 
	(
		clk,SYNC_IN		: in STD_LOGIC;
		inputX : in STD_LOGIC_VECTOR (31 downto 0);
		output : out STD_LOGIC_VECTOR (31 downto 0);
	   SYNC_OUT: out STD_LOGIC
	   	
	);
end top_module;

		
Architecture rtl of top_module is		
		
component stage0 is
port 
   (
	    clk,SYNC_IN		: in STD_LOGIC;
	    inputX : in STD_LOGIC_VECTOR (31 downto 0);
	    inputW : in STD_LOGIC_VECTOR (31 downto 0);
	    output : out STD_LOGIC_VECTOR (31 downto 0);
       SYNC_OUT: out STD_LOGIC
   	    
    );   
end component;

component stage1 is
port 
   (
	    clk,SYNC_IN		: in STD_LOGIC;
	    inputX : in STD_LOGIC_VECTOR (31 downto 0);
	    inputW : in STD_LOGIC_VECTOR (31 downto 0);
	    output : out STD_LOGIC_VECTOR (31 downto 0);
       SYNC_OUT: out STD_LOGIC;
   	   rom_addr: out STD_LOGIC_VECTOR (7 downto 0)	
    );   
end component;

component st1_twid_rom is	
port (
addr: IN std_logic_VECTOR(0 downto 0);
clk: IN std_logic;
dout: OUT std_logic_VECTOR(31 downto 0));
end component;


component stage2 is
port 
   (
	    clk,SYNC_IN		: in STD_LOGIC;
	    inputX : in STD_LOGIC_VECTOR (31 downto 0);
	    inputW : in STD_LOGIC_VECTOR (31 downto 0);
	    output : out STD_LOGIC_VECTOR (31 downto 0);
       SYNC_OUT: out STD_LOGIC;
       rom_addr: out STD_LOGIC_VECTOR (7 downto 0)
   	    
    );   
end component;

component st2_twid_rom is	


port (
addr: IN std_logic_VECTOR(1 downto 0);
clk: IN std_logic;
dout: OUT std_logic_VECTOR(31 downto 0));
end component;





component stage3 is
port 
   (
	    clk,SYNC_IN		: in STD_LOGIC;
	    inputX : in STD_LOGIC_VECTOR (31 downto 0);
	    inputW : in STD_LOGIC_VECTOR (31 downto 0);
	    output : out STD_LOGIC_VECTOR (31 downto 0);
       SYNC_OUT: out STD_LOGIC;
       rom_addr: out STD_LOGIC_VECTOR (7 downto 0)
   	    
    );   
end component;

component st3_twid_rom is	


port (
addr: IN std_logic_VECTOR(2 downto 0);
clk: IN std_logic;
dout: OUT std_logic_VECTOR(31 downto 0));
end component;


component stage4 is
port 
   (
	    clk,SYNC_IN		: in STD_LOGIC;
	    inputX : in STD_LOGIC_VECTOR (31 downto 0);
	    inputW : in STD_LOGIC_VECTOR (31 downto 0);
	    output : out STD_LOGIC_VECTOR (31 downto 0);
       SYNC_OUT: out STD_LOGIC;
       rom_addr: out STD_LOGIC_VECTOR (7 downto 0)
    );   
end component;

component st4_twid_rom is	


port (
addr: IN std_logic_VECTOR(3 downto 0);
clk: IN std_logic;
dout: OUT std_logic_VECTOR(31 downto 0));
end component;




component stage5 is
port 
   (
	    clk,SYNC_IN		: in STD_LOGIC;
	    inputX : in STD_LOGIC_VECTOR (31 downto 0);
	    inputW : in STD_LOGIC_VECTOR (31 downto 0);
	    output : out STD_LOGIC_VECTOR (31 downto 0);
       SYNC_OUT: out STD_LOGIC;
       rom_addr: out STD_LOGIC_VECTOR (7 downto 0)
    );   
end component;


component st5_twid_rom is	
port (
addr: IN std_logic_VECTOR(4 downto 0);
clk: IN std_logic;
dout: OUT std_logic_VECTOR(31 downto 0));
end component;




component stage6 is
port 
   (
	    clk,SYNC_IN		: in STD_LOGIC;
	    inputX : in STD_LOGIC_VECTOR (31 downto 0);
	    inputW : in STD_LOGIC_VECTOR (31 downto 0);
	    output : out STD_LOGIC_VECTOR (31 downto 0);
       SYNC_OUT: out STD_LOGIC;
       rom_addr: out STD_LOGIC_VECTOR (7 downto 0)
    );   
end component;

component st6_twid_rom is	
port (
addr: IN std_logic_VECTOR(5 downto 0);
clk: IN std_logic;
dout: OUT std_logic_VECTOR(31 downto 0));
end component;


component stage7 is
port 
   (
	    clk,SYNC_IN		: in STD_LOGIC;
	    inputX : in STD_LOGIC_VECTOR (31 downto 0);
	    inputW : in STD_LOGIC_VECTOR (31 downto 0);
	    output : out STD_LOGIC_VECTOR (31 downto 0);
       SYNC_OUT: out STD_LOGIC;
       rom_addr: out STD_LOGIC_VECTOR (7 downto 0)
    );   
end component;

component st7_twid_rom is	
port (
addr: IN std_logic_VECTOR(6 downto 0);
clk: IN std_logic;
dout: OUT std_logic_VECTOR(31 downto 0));
end component;




SIGNAL output0: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL output1: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL output2: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL output3: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL output4: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL output5: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL output6: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL output7: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL output0_d: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL output1_d: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL output2_d: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL output3_d: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL output4_d: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL output5_d: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL output6_d: STD_LOGIC_VECTOR (31 downto 0);


SIGNAL dout1: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL dout2: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL dout3: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL dout4: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL dout5: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL dout6: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL dout7: STD_LOGIC_VECTOR (31 downto 0);

SIGNAL addr1: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL addr2: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL addr3: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL addr4: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL addr5: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL addr6: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL addr7: STD_LOGIC_VECTOR (7 downto 0);

SIGNAL SYNC_OUT0: STD_LOGIC;
SIGNAL SYNC_OUT1: STD_LOGIC;
SIGNAL SYNC_OUT2: STD_LOGIC;
SIGNAL SYNC_OUT3: STD_LOGIC;
SIGNAL SYNC_OUT4: STD_LOGIC;
SIGNAL SYNC_OUT5: STD_LOGIC;
SIGNAL SYNC_OUT6: STD_LOGIC;
SIGNAL SYNC_OUT7: STD_LOGIC;
SIGNAL SYNC_OUT0_d: STD_LOGIC;
SIGNAL SYNC_OUT1_d: STD_LOGIC;
SIGNAL SYNC_OUT2_d: STD_LOGIC;
SIGNAL SYNC_OUT3_d: STD_LOGIC;
SIGNAL SYNC_OUT4_d: STD_LOGIC;
SIGNAL SYNC_OUT5_d: STD_LOGIC;
SIGNAL SYNC_OUT6_d: STD_LOGIC;



Begin

pipeline_process: process (clk)
begin
  if rising_edge(clk) then
  SYNC_OUT0_d<=SYNC_OUT0;
  output0_d<=output0;
  SYNC_OUT1_d<=SYNC_OUT1;
  output1_d<=output1;
  SYNC_OUT2_d<=SYNC_OUT2;
  output2_d<=output2;
  SYNC_OUT3_d<=SYNC_OUT3;
  output3_d<=output3;
  SYNC_OUT4_d<=SYNC_OUT4;
  output4_d<=output4;
  SYNC_OUT5_d<=SYNC_OUT5;
  output5_d<=output5;
  SYNC_OUT6_d<=SYNC_OUT6;
  output6_d<=output6; 
  SYNC_OUT<=SYNC_OUT7;
  output<=output7;
end if;
end process;

stage0_inst : stage0 port map (
                           		   
                                    clk=>	clk,
                                    SYNC_OUT=>SYNC_OUT0,
                                    SYNC_IN =>SYNC_IN,
                                    inputX=>inputX,
                                    inputW=>x"7FFF0000",
                                    output=>output0                                
                                );
    
stage1_inst : stage1 port map (
                           		   
                                    clk=>	clk,
                                    SYNC_OUT=>SYNC_OUT1,
                                    SYNC_IN =>SYNC_OUT0_d,
                                    inputX=>output0_d,
                                    inputW=>dout1,
                                    output=>output1,
                                    rom_addr=>addr1
                               );
rom1_inst : st1_twid_rom port map (

                                    addr=>addr1(0 downto 0),
                                    clk =>clk,
                                    dout=>dout1                                
                                    );                              

stage2_inst : stage2 port map (
                               		   
                                        clk=>	clk,
                                        SYNC_OUT=>SYNC_OUT2,
                                        SYNC_IN =>SYNC_OUT1_d,
                                        inputX=>output1_d,
                                        inputW=>dout2,
                                        output=>output2,
                                        rom_addr=>addr2  
                                );
                                
                                
rom2_inst : st2_twid_rom port map (
 
                                addr=>addr2(1 downto 0),
                                clk =>clk,
                                dout=>dout2                                
                                );
                                
                                
                                
                                
                                
stage3_inst : stage3 port map (
                               		   
                                        clk=>	clk,
                                        SYNC_OUT=>SYNC_OUT3,
                                        SYNC_IN =>SYNC_OUT2_d,
                                        inputX=>output2_d,
                                        inputW=>dout3,
                                        rom_addr=>addr3,
                                        output=>output3
                                );
                                
rom3_inst : st3_twid_rom port map (
 
                                addr=>addr3(2 downto 0),
                                clk =>clk,
                                dout=>dout3                                
                                );  
                                                              
                                
stage4_inst : stage4 port map (
                               		   
                                        clk=>	clk,
                                        SYNC_OUT=>SYNC_OUT4,
                                        SYNC_IN =>SYNC_OUT3_d,
                                        inputX=>output3_d,
                                        inputW=>dout4,
                                        rom_addr=>addr4,
                                        output=>output4
                                );
                                
                                
rom4_inst : st4_twid_rom port map (
 
                                addr=>addr4(3 downto 0),
                                clk =>clk,
                                dout=>dout4                                
                                );
                                
                                                                
stage5_inst : stage5 port map (
                               		   
                                        clk=>	clk,
                                        SYNC_OUT=>SYNC_OUT5,
                                        SYNC_IN =>SYNC_OUT4_d,
                                        inputX=>output4_d,
                                        inputW=>dout5,
                                        rom_addr=>addr5,
                                        output=>output5
                                );
                                
                                
rom5_inst : st5_twid_rom port map (
 
                                addr=>addr5(4 downto 0),
                                clk =>clk,
                                dout=>dout5                                
                                );
                                
                                                                
stage6_inst : stage6 port map (
                               		   
                                        clk=>	clk,
                                        SYNC_OUT=>SYNC_OUT6,
                                        SYNC_IN =>SYNC_OUT5_d,
                                        inputX=>output5_d,
                                        inputW=>dout6,
                                        rom_addr=>addr6,
                                        output=>output6
                                );
                                
rom6_inst : st6_twid_rom port map (
 
                                addr=>addr6(5 downto 0),
                                clk =>clk,
                                dout=>dout6                                
                                );                            
                                                               
                                
stage7_inst : stage7 port map (
                               		   
                                        clk=>	clk,
                                        SYNC_OUT=>SYNC_OUT7,
                                        SYNC_IN =>SYNC_OUT6_d,
                                        inputX=>output6_d,
                                        inputW=>dout7,
                                        rom_addr=>addr7,
                                        output=>output7
                                );
                                
rom7_inst : st7_twid_rom port map (
 
                                addr=>addr7(6 downto 0),
                                clk =>clk,
                                dout=>dout7                                
                                );                            
                                                            
                                
                                
       
End rtl;                         
                                
                                
                                