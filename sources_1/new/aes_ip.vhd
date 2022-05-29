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
use IEEE.std_logic_1164.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity aes_ip is
    Port ( textin : in std_logic_vector (127 downto 0);
           rst : in std_logic;
           ck : in std_logic;
           textout : out std_logic_vector (127 downto 0));
end aes_ip;

architecture behavioral of aes_ip is

    constant n_bytes: integer := 16;
    constant byte_len: integer := 8;
    type aes_port is array (n_byte - 1 downto 0) of std_logic_vector (byte_len - 1 downto 0);

begin


end behavioral;
