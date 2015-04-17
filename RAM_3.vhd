library ieee;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity rams_03 is

port (clk : in std_logic;
      we : in std_logic;
      en : in std_logic;
      addr : in std_logic_vector(2 downto 0);
      di : in std_logic_vector(31 downto 0);
      do : out std_logic_vector(31 downto 0)
      );
end rams_03;

architecture syn of rams_03 is
type ram_type is array (6 downto 0) of std_logic_vector (31 downto
0);
signal RAM: ram_type;


begin
process (clk)
begin
if  rising_edge(clk) then
   if en = '1' then
      if we = '1' then
         RAM(conv_integer(addr)) <= di;
      end if;
    
    do <= RAM(conv_integer(addr)) ;
   end if;
  end if;
end process;

end syn;