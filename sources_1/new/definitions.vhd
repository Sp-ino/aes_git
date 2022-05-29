library IEEE;
use IEEE.std_logic_1164.all;

package definitions is
    constant n_bytes: integer := 16;
    constant byte_len: integer := 8;
    type aes_port is array (n_byte - 1 downto 0) of std_logic_vector (byte_len - 1 downto 0);
end definitions;