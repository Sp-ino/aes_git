library IEEE;
use IEEE.std_logic_1164.all;



package utils is

    constant vector_len: integer := 8;

    function rotl(vector: std_logic_vector (vector_len - 1 downto 0); amount: integer) return std_logic_vector;
    function rotr(vector: std_logic_vector (vector_len - 1 downto 0); amount: integer) return std_logic_vector;

end utils;


package body utils is

    function rotl(vector: std_logic_vector (vector_len - 1 downto 0); amount: integer) return std_logic_vector is
    -- Performs an unsigned left rotation on an 8-bit std_logic_vector
        variable rotated: std_logic_vector (vector_len - 1 downto 0);
        variable temp: std_logic;

    begin

        -- Is there a (synthesizable) way to check that vector_len - amount does not become < 0 ? Is it recommended/advisable to check it?
        rotated := vector;
        for idx in amount - 1 downto 0 loop
            temp := rotated(0);
            rotated(0) := rotated(vector_len - 1);
            for scan_vec in vector_len - 1 downto 2 loop
                rotated(scan_vec) := rotated(scan_vec - 1);
            -- rotated(7) := rotated(6);
            -- rotated(6) := rotated(5);
            -- rotated(5) := rotated(4);
            -- rotated(4) := rotated(3);
            -- rotated(3) := rotated(2);
            -- rotated(2) := rotated(1);
            end loop;
            rotated(1) := temp;
        end loop;
        return rotated;

    end rotl;


    function rotr(vector: std_logic_vector (vector_len - 1 downto 0); amount: integer) return std_logic_vector is
    -- Performs an unsigned right rotation on an 8-bit std_logic_vector
        variable rotated: std_logic_vector (vector_len - 1 downto 0);
        variable temp: std_logic;

    begin

        -- Is there a (synthesizable) way to check that vector_len - amount does not become < 0 ? Is it recommended/advisable to check it?
        -- rotated := std_logic_vector(shif_right(unsigned(vector), amount)) xor std_logic_vector(shif_right(unsigned(vector), vector_len - amount));
        rotated := vector;
        for idx in amount - 1 downto 0 loop
            temp := rotated(vector_len - 1);
            rotated(vector_len - 1) := rotated(0);
            for scan_vec in 1 downto vector_len - 2 loop
                rotated(scan_vec + 1) := rotated(scan_vec);
            -- rotated(0) := rotated(1);
            -- rotated(1) := rotated(2);
            -- rotated(2) := rotated(3);
            -- rotated(3) := rotated(4);
            -- rotated(4) := rotated(5);
            -- rotated(5) := rotated(6);
            end loop;
            rotated(vector_len - 2) := temp;
        end loop;
        return rotated;

    end rotr;    

end utils;