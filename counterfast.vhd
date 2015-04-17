library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity counterfast is			port
         (
			clk, SYNC_IN,reset: in std_logic;
			Q : out std_logic_vector(7 downto 0)
			);
end counterfast;

architecture archi of counterfast is

signal tmp: std_logic_vector(7 downto 0);

begin

process (clk)
begin
    
if rising_edge(clk) then
	if (SYNC_IN='1') then
		tmp <= x"FF";
	else
	if (reset='1') then
		tmp<=x"F0";
	else	
		tmp <= tmp + 1;
	end if;
end if;end if;
end process;

Q <= tmp;

end archi;
