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
    port (
        textin : in std_logic_vector (127 downto 0);
        rst : in std_logic;
        ck : in std_logic;
        textout : out std_logic_vector (127 downto 0)
    );
end aes_ip;


architecture behavioral of aes_ip is

    constant n_bytes: integer := 16;
    constant n_rows: integer := 4;
    constant n_cols: integer := 4;
    constant byte_len: integer := 8;
    type aes_rows is array (n_cols - 1 downto 0) of std_logic_vector (byte_len - 1 downto 0);
    type aes_matrix is array (n_rows - 1 downto 0) of aes_rows;

    constant key: aes_matrix := (others => (others => (others => '11010101')));
    signal in_bytes: aes_matrix;
    signal interm_bytes: aes_matrix;
    signal out_bytes: aes_matrix;

begin

    input_conversion: process (textin)
    begin
        for idx_r in n_rows - 1 downto 0
        loop
            for idx_c in n_cols - 1 downto 0
            loop
                in_bytes(idx_r)(idx_c) <= textin(byte_len*(idx_c + idx_r * n_cols + 1) - 1 downto byte_len*(idx_c + idx_r * n_cols));
            end loop;
        end loop;
    end process input_conversion;


    add_round_key: process (ck, rst)
    begin
        if rst = '1' then
            interm_bytes <= (others => (others => (others => '0')));
        elsif rising_edge(ck) then
            for idx_r in n_rows - 1 downto 0
            loop
                for idx_c in n_cols - 1 downto 0
                loop
                    interm_bytes(idx_r)(idx_c) <= in_bytes(idx_r)(idx_c) xor key(idx_r)(idx_c);
                end loop;
            end loop;
        end if;  
    end process add_round_key;


    other_ops: process (ck, rst)
    begin
        if rst = '1' then
            out_bytes <= (others => (others => (others => '0')));
        elsif rising_edge(ck) then
            out_bytes <= interm_bytes; 
        end if;
    end process;


    output_conversion: process (out_bytes)
    begin
        for idx_r in n_rows - 1 downto 0
        loop
            for idx_c in n_cols - 1 downto 0
            loop
                textout(byte_len*(idx_c + idx_r * n_cols + 1) - 1 downto byte_len*(idx_c + idx_r * n_cols)) <= in_bytes(idx_r)(idx_c) ;
            end loop;
        end loop;
    end process output_conversion;

end behavioral;
