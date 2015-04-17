library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity st2_twid_rom is	
generic(
	depth: integer:=4;
	twdlwidth: integer:=16;
	addr_width: integer:=2
	);

port (
	addr: IN std_logic_VECTOR(addr_width-1 downto 0);
	clk: IN std_logic;
	dout: OUT std_logic_VECTOR(2*twdlwidth-1 downto 0));
end st2_twid_rom;

architecture Behavioral of st2_twid_rom is
type rom_type is array ( 0 to depth-1) of std_logic_vector (31 downto 0);


constant ROM : rom_type :=(
x"5a82a57f",x"00008001",x"a57fa57f",x"7fff0000");
begin

  process (clk)
    begin
      if rising_edge(clk) then
             dout <= ROM(conv_integer(addr))(2*twdlwidth-1 downto 0);  
      end if;
  end process;

end Behavioral;

