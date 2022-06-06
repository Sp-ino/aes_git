library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



package definitions is

    constant n_bytes: integer := 16;
    constant n_rows: integer := 4;
    constant n_cols: integer := 4;
    constant byte_len: integer := 8;
    constant msg_len: integer := 128;

    type aes_rows is array (n_cols - 1 downto 0) of std_logic_vector (byte_len - 1 downto 0);
    type aes_matrix is array (n_rows - 1 downto 0) of aes_rows;

    function in_conversion(tin: std_logic_vector (msg_len - 1 downto 0)) return aes_matrix;    
    function out_conversion(out_bytes: aes_matrix) return std_logic_vector;
    function rotl(byte: std_logic_vector (byte_len - 1 downto 0); amount: integer) return std_logic_vector;
    function rotr(byte: std_logic_vector (byte_len - 1 downto 0); amount: integer) return std_logic_vector;

end definitions;


package body definitions is

    function in_conversion(tin: std_logic_vector (msg_len - 1 downto 0)) return aes_matrix is
    -- Converts a std_logic_vector of length 128 to a 4-by-4 matrix of 8-bit std_logic_vector
        variable in_bytes: aes_matrix;

    begin

        for idx_r in n_rows - 1 downto 0 loop
            for idx_c in n_cols - 1 downto 0 loop
                in_bytes(idx_r)(idx_c) := tin(byte_len*(idx_c + idx_r * n_cols + 1) - 1 downto byte_len*(idx_c + idx_r * n_cols));
            end loop;
        end loop;
        return in_bytes;

    end in_conversion;


    function out_conversion(out_bytes: aes_matrix) return std_logic_vector is
    -- Converts a 4-by-4 matrix of 8-bit std_logic_vector to a std_logic_vector of length 128
        variable tout: std_logic_vector (msg_len - 1 downto 0);

    begin

        for idx_r in n_rows - 1 downto 0 loop
            for idx_c in n_cols - 1 downto 0 loop
                tout(byte_len*(idx_c + idx_r * n_cols + 1) - 1 downto byte_len*(idx_c + idx_r * n_cols)) := out_bytes(idx_r)(idx_c);
            end loop;
        end loop;
        return tout;

    end out_conversion;


    function rotl(byte: std_logic_vector (byte_len - 1 downto 0); amount: integer) return std_logic_vector is
    -- Performs an unsigned left rotation on an 8-bit std_logic_vector
        variable rotated: std_logic_vector (byte_len - 1 downto 0);

    begin

        -- Is there a (synthesizable) way to check that byte_len - amount does not become < 0 ? Is it recommended/advisable to check it?
        rotated := byte;
        for idx in amount - 1 downto 0 loop
            rotated(0) := rotated(7);
            rotated(1) := rotated(0);
            rotated(2) := rotated(1);
            rotated(3) := rotated(2);
            rotated(4) := rotated(3);
            rotated(5) := rotated(4);
            rotated(6) := rotated(5);
            rotated(7) := rotated(6);
        end loop;
        return rotated;

    end rotl;


    function rotr(byte: std_logic_vector (byte_len - 1 downto 0); amount: integer) return std_logic_vector is
    -- Performs an unsigned right rotation on an 8-bit std_logic_vector
        variable rotated: std_logic_vector (byte_len - 1 downto 0);

    begin

        -- Is there a (synthesizable) way to check that byte_len - amount does not become < 0 ? Is it recommended/advisable to check it?
        -- rotated := std_logic_vector(shif_right(unsigned(byte), amount)) xor std_logic_vector(shif_right(unsigned(byte), byte_len - amount));
        rotated := byte;
        for idx in amount - 1 downto 0 loop
            rotated(7) := rotated(0);
            rotated(0) := rotated(1);
            rotated(1) := rotated(2);
            rotated(2) := rotated(3);
            rotated(3) := rotated(4);
            rotated(4) := rotated(5);
            rotated(5) := rotated(6);
            rotated(6) := rotated(7);
        end loop;
        return rotated;

    end rotr;

end definitions;