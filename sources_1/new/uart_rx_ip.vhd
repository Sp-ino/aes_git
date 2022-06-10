library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.aes_pkg.all;



entity uart_rxs_ip is
    port(
        i_ck: in std_logic;
        i_rst: in std_logic;
        o_data_ready: out std_logic;
        o_data: out std_logic_vector (byte_len - 1 downto 0);
    );
end uart_rxs_ip;


architecture behavioral of uart_rxs_ip is


begin

    

end behavioral;