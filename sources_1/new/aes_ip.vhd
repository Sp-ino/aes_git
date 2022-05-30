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
    type aes_bytes is array (n_byte - 1 downto 0) of std_logic_vector (byte_len - 1 downto 0);

    constant key: aes_bytes := (others => (others => '1'));
    signal in_bytes: aes_bytes;
    signal interm_bytes: aes_bytes;
    signal out_bytes: aes_bytes;

begin

    input_conversion: process (textin)
    begin
        for idx in n_bytes - 1 downto 0
        loop
            in_bytes(idx) <= textin(byte_len*idx - 1 downto byte_len*(idx - 1));
        end loop;
    end process input_conversion;


    add_round_key: process (ck, rst)
    begin
        if rst = '1' then
            interm_bytes <= (others => (others => '0'));
        elsif rising_edge(ck) then
            for idx in n_bytes - 1 downto 0
            loop
                interm_bytes(idx) <= in_bytes(idx) xor key(idx);
            end loop;
        end if;  
    end process add_round_key;


    other_ops: process (ck, rst)
    begin
        if rst = '1' then
            out_bytes <= (others => (others => '0'));
        elsif rising_edge(ck) then
            out_bytes <= interm_bytes; 
        end if;
    end process;


    output_conversion: process (out_bytes)
    begin
        for idx in n_bytes - 1 downto 0
        loop
            textout(byte_len*idx - 1 downto byte_len*(idx - 1)) <= out_bytes(idx);
        end loop;
    end process output_conversion;

end behavioral;
