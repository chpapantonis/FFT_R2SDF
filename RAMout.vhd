library ieee;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity ram32 is

port (clk : in std_logic;
      clkfast : in std_logic;
      we : in std_logic;
      en : in std_logic;
      addr_di : in std_logic_vector(4 downto 0);
      addr_do : in std_logic_vector(4 downto 0);
      di : in std_logic_vector(31 downto 0);
      do : out std_logic_vector(31 downto 0)
      );
end ram32;

architecture syn of ram32 is
type ram_type is array (31 downto 0) of std_logic_vector (31 downto
0);
signal RAM: ram_type;


begin
process (clk)
begin
if  rising_edge(clk) then
   if en = '1' then
      if we = '1' then
         RAM(conv_integer(addr_di)) <= di;
      end if;
  end if;
  end if;
end process;


process (clkfast)
begin
if  rising_edge(clkfast) then
    do <= RAM(conv_integer(addr_do)) ;
end if;
end process;

end syn;
