library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity stage2 is
port 
	(
		clk,SYNC_IN		: in STD_LOGIC;
		inputX : in STD_LOGIC_VECTOR (31 downto 0);
		inputW : in STD_LOGIC_VECTOR (31 downto 0);
		output : out STD_LOGIC_VECTOR (31 downto 0);
	   SYNC_OUT: out STD_LOGIC;
      rom_addr : out STD_LOGIC_VECTOR (7 downto 0)
	   	
	);
end stage2;
	
	Architecture rtl of stage2 is
	
	component butterfly is
	port 
		(
			a1		: in STD_LOGIC_VECTOR (15 downto 0);
			a2		: in STD_LOGIC_VECTOR (15 downto 0);
			b1		: in STD_LOGIC_VECTOR (15 downto 0);
			b2		: in STD_LOGIC_VECTOR (15 downto 0);
			w1		: in STD_LOGIC_VECTOR (15 downto 0);
			w2		: in STD_LOGIC_VECTOR (15 downto 0);
			f1		: out STD_LOGIC_VECTOR (15 downto 0);
			f2		: out STD_LOGIC_VECTOR (15 downto 0);
			g1		: out STD_LOGIC_VECTOR (15 downto 0);
			g2		: out STD_LOGIC_VECTOR (15 downto 0);
			clk		: in STD_LOGIC;
			SYNC_IN   :  in STD_LOGIC
		);
	
	end component;
	
	
	
	component rams_02 is
	port (clk : in std_logic;
	      we : in std_logic;
	      en : in std_logic;
	      addr: in std_logic_vector(1 downto 0);
	      di : in std_logic_vector(31 downto 0);
	      do : out std_logic_vector(31 downto 0)
	      );
	end component;
	
	
      
      component counter is
      port 
           (
            clk, SYNC_IN,reset : in std_logic;
            Q : out std_logic_vector(7 downto 0)
           );
      end component;

	
SIGNAL	a1:  STD_LOGIC_VECTOR (15 downto 0);
SIGNAL	a2:  STD_LOGIC_VECTOR (15 downto 0);
SIGNAL	b1:  STD_LOGIC_VECTOR (15 downto 0);
SIGNAL	b2:  STD_LOGIC_VECTOR (15 downto 0);
SIGNAL w1:  STD_LOGIC_VECTOR (15 downto 0);
SIGNAL w2:  STD_LOGIC_VECTOR (15 downto 0);

SIGNAL f1: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL	f2: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL g1: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL g2: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL g1_d: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL g2_d: STD_LOGIC_VECTOR (15 downto 0);

SIGNAL	f1_d: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL	f2_d: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL	f1_dd: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL	f2_dd: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL	f1_ddd: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL	f2_ddd: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL	b1_d: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL b2_d: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL	b1_dd: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL b2_dd: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL	b1_ddd: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL b2_ddd: STD_LOGIC_VECTOR (15 downto 0);


SIGNAL do: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL di: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL output_temp: STD_LOGIC_VECTOR (31 downto 0);

SIGNAL addr: STD_LOGIC_VECTOR (1 downto 0);
SIGNAL Q: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL Q_d: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL Q_dd: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL Q_ddd: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL Q2: STD_LOGIC_VECTOR (7 downto 0);


SIGNAL temp_Output1: STD_LOGIC_VECTOR (31 downto 0);

SIGNAL temp_Sync_Out: STD_LOGIC;
SIGNAL reset: STD_LOGIC;
SIGNAL MASK: STD_LOGIC:='0';

Begin
    
    counter_inst : counter port map (
                                           clk=>clk,
                                           SYNC_IN=> SYNC_IN,
                                           Q =>Q,
                                           reset=>'0' 
                                         );
    counter2_inst : counter port map (
                                          clk=>clk,
                                          SYNC_IN=> SYNC_IN,
                                          Q =>Q2,
                                          reset=>reset 
                                        );
                              
    
    butter_inst : butterfly port map (
                               		       a1=>a1,
                               		       a2=>a2,
                                        b1=>b1,
                                        b2=>b2,
                                        w1=>w1,
                                        w2=>w2,
                                        f1=>f1,
                                        f2=>f2,
                                        g1=>g1,
                                        g2=>g2,
                                        clk=>	clk,
                                        SYNC_IN =>SYNC_IN
								    );
								    
    ram_inst  : rams_02 port map (
                                clk=>clk,
                           	    en=>'1',
                           	    we=>'1',
                           	    addr=>addr,
                           	    di=>di,
                           	    do=>do
                      
                           	    );
      
   
   process(clk)
    begin
	  if rising_edge(clk) then
	  b1_d<=inputX(31 downto 16);
     b2_d<=inputX(15 downto 0);

  
   
   
     f1_d<=f1;
     f1_dd<=f1_d;
     f1_ddd<=f1_dd;
     f2_d<=f2;
     f2_dd<=f2_d;
     f2_ddd<=f2_dd;
     Q_d<=Q;
     Q_dd<=Q_d;
     Q_ddd<=Q_dd;
     
     if sync_in='1' then
         MASK<='1';
      else if temp_Sync_Out='1' then
         MASK<='0';
      end if;
    
   
     end if;
 end if;
 
   end process;
   
   
   addr<=Q2(1 downto 0);
   
   a1<= do(31 downto 16);
   a2<= do(15 downto 0);
   b1<= b1_d;
   b2<= b2_d;
   w1<= inputW(31 downto 16);
   w2<= inputW(15 downto 0);      
         
with Q(2) select
     di <= b1_d&b2_d when '0',
           g1&g2 when others;
              
    

with Q(2) select
   output_temp <= f1&f2 when '1',
                  do when others;   
             
    
   

-- (Q=x"04") then

      

  temp_Sync_Out<=(not((((Q(7))or(Q(6)))or((Q(5))or(Q(4))))or(((Q(3))or(not(Q(2))))or((Q(1))or(Q(0))))));
  reset<=(not((((Q2(7))or(Q2(6)))or((Q2(5))or(Q2(4))))or(((Q2(3))or(Q2(2)))or((not(Q2(1)))or(Q2(0))))));          

--(Q2=x"02") then


 SYNC_OUT<= (temp_Sync_Out)and(mask);  
 
rom_addr<=Q;    
output<=output_temp;      
           
end rtl;    
    
    
    