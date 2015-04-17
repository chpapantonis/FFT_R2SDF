library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity stage1 is
port 
	(
		clk,SYNC_IN		: in STD_LOGIC;
		inputX : in STD_LOGIC_VECTOR (31 downto 0);
		inputW : in STD_LOGIC_VECTOR (31 downto 0);
		output : out STD_LOGIC_VECTOR (31 downto 0);
	   SYNC_OUT: out STD_LOGIC;
	   rom_addr: out STD_LOGIC_VECTOR (7 downto 0)	
	);
end stage1;
	
	Architecture rtl of stage1 is
	
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
SIGNAL	f1_d: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL	f2_d: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL g1: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL g2: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL g1_d: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL g2_d: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL g1_dd: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL g2_dd: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL g1_ddd: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL g2_ddd: STD_LOGIC_VECTOR (15 downto 0);



SIGNAL	b1_d: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL b2_d: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL	b1_dd: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL b2_dd: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL	b1_ddd: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL b2_ddd: STD_LOGIC_VECTOR (15 downto 0);



SIGNAL output_temp: STD_LOGIC_VECTOR (31 downto 0);




SIGNAL Q: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL Q_d: STD_LOGIC_VECTOR (7 downto 0);
      SIGNAL temp_Sync_Out: STD_LOGIC;    
      SIGNAL MASK: STD_LOGIC:='0';

Begin
    
    counter_inst : counter port map (
                                       clk=>clk,
                                       SYNC_IN=> SYNC_IN,
                                       Q =>Q,
                                       reset=>'0' 
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
						          
    
   
   process(clk)
    begin
     if rising_edge(clk) then
     b1_d<=inputX(31 downto 16);
     b2_d<=inputX(15 downto 0);

     b1_dd<=b1_d;
     b2_dd<=b2_d;
     b1_ddd<=b1_dd;
     b2_ddd<=b2_dd;  
     

     
     f1_d<=f1;
     f2_d<=f2;
     g1_d<=g1;
     g2_d<=g2;
     g1_dd<=g1_d;
     g2_dd<=g2_d;
     g1_ddd<=g1_dd;
     g2_ddd<=g2_dd;
     Q_d<=Q;
     
        if sync_in='1' then
           MASK<='1';
        else if temp_Sync_Out='1' then
           MASK<='0';
        end if;
       end if;       
       
    
     end if;
   end process;
           
          
   a1<= b1_ddd;
   a2<= b2_ddd;
   b1<= b1_d;
   b2<= b2_d;
   w1<= inputW(31 downto 16);
   w2<= inputW(15 downto 0);                    
                
    

with Q_d(1) select
   output_temp <= f1_d&f2_d when '1',
                  g1_ddd&g2_ddd when others;   
             
        
 temp_Sync_Out<=(not((((Q(7))or(Q(6)))or((Q(5))or(Q(4))))or(((Q(3))or(Q(2)))or((not(Q(1)))or(not(Q(0)))))));



rom_addr<=Q;


SYNC_OUT<= (temp_Sync_Out)and(mask); 
       
output<=output_temp;      
           
end rtl;    
    
    
    