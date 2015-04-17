library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity butterfly is
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
		SYNC_IN		: in STD_LOGIC;
		SYNC_OUT	: out STD_LOGIC				
	);

end butterfly;

architecture rtl of butterfly is
	SIGNAL bw1_32,bw2_32,b1xw1_32,b2xw1_32,b1xw2_32,b2xw2_32 : STD_LOGIC_VECTOR (31 DOWNTO 0);

  
   
	SIGNAL bw1,bw2,b1xw1,b2xw1,b1xw2,b2xw2: STD_LOGIC_VECTOR (15 DOWNTO 0);

	
begin

	
	    b1xw1_32 <= b1*w1;
	    b2xw2_32 <= b2*w2;
	    b1xw2_32 <= b1*w2;
	    b2xw1_32 <= b2*w1;
	      
	    b1xw1 <= b1xw1_32(31 downto 16);
	    b2xw1 <= b2xw1_32(31 downto 16);
	      
	    b1xw2 <= b1xw2_32(31 downto 16);
	    b2xw2 <= b2xw2_32(31 downto 16);
	         
            
	    bw1 <=   b1xw1 - b2xw2;
	    bw2 <=   b1xw2 + b2xw1;
             
	      
      	f1 <= a1(15)&a1(15 downto 1) + bw1;
       f2 <= a2(15)&a2(15 downto 1) + bw2;
         
       g1 <= a1(15)&a1(15 downto 1) - bw1;
       g2 <= a2(15)&a2(15 downto 1) - bw2;
         
       

	   
	   
	   SYNC_OUT<=SYNC_IN;

	
end rtl;
