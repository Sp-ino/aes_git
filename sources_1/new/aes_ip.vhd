----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.05.2022 22:08:37
-- Design Name: 
-- Module Name: aes_ip - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity aes_ip is
    Port ( textin : in STD_LOGIC_VECTOR (127 downto 0);
           rst : in STD_LOGIC;
           ck : in STD_LOGIC;
           textout : out STD_LOGIC_VECTOR (127 downto 0));
end aes_ip;

architecture Behavioral of aes_ip is

begin


end Behavioral;
