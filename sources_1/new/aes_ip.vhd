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
        i_textin : in std_logic_vector (127 downto 0);
        i_rst : in std_logic;
        i_ck : in std_logic;
        o_textout : out std_logic_vector (127 downto 0)
    );
end aes_ip;


architecture behavioral of aes_ip is

    constant n_bytes: integer := 16;
    constant n_rows: integer := 4;
    constant n_cols: integer := 4;
    constant byte_len: integer := 8;
    type aes_rows is array (n_cols - 1 downto 0) of std_logic_vector (byte_len - 1 downto 0);
    type aes_matrix is array (n_rows - 1 downto 0) of aes_rows;

    constant key: aes_matrix := (others => (others => (others => '1')));--'11010101'));
    signal w_in_bytes: aes_matrix;
    signal r_interm_bytes: aes_matrix;
    signal r_out_bytes: aes_matrix;

begin

    input_conversion: process (i_textin)
    begin
        for idx_r in n_rows - 1 downto 0 loop
            for idx_c in n_cols - 1 downto 0 loop
                w_in_bytes(idx_r)(idx_c) <= i_textin(byte_len*(idx_c + idx_r * n_cols + 1) - 1 downto byte_len*(idx_c + idx_r * n_cols));
            end loop;
        end loop;
    end process input_conversion;


    add_round_key: process (i_ck, i_rst)
    begin
        if i_rst = '1' then
            r_interm_bytes <= (others => (others => (others => '0')));
        elsif rising_edge(i_ck) then
            for idx_r in n_rows - 1 downto 0 loop
                for idx_c in n_cols - 1 downto 0 loop
                    r_interm_bytes(idx_r)(idx_c) <= w_in_bytes(idx_r)(idx_c) xor key(idx_r)(idx_c);
                end loop;
            end loop;
        end if;  
    end process add_round_key;


    other_ops: process (i_ck, i_rst)
    begin
        if i_rst = '1' then
            r_out_bytes <= (others => (others => (others => '0')));
        elsif rising_edge(i_ck) then
            r_out_bytes <= r_interm_bytes; 
        end if;
    end process;


    output_conversion: process (r_out_bytes)
    begin
        for idx_r in n_rows - 1 downto 0 loop
            for idx_c in n_cols - 1 downto 0 loop
                o_textout(byte_len*(idx_c + idx_r * n_cols + 1) - 1 downto byte_len*(idx_c + idx_r * n_cols)) <= r_out_bytes(idx_r)(idx_c) ;
            end loop;
        end loop;
    end process output_conversion;

end behavioral;
