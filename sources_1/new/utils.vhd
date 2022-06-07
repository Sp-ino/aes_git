library IEEE;
use IEEE.std_logic_1164.all;



package utils is

    function rotl(byte: std_logic_vector (byte_len - 1 downto 0); amount: integer) return std_logic_vector;
    function rotr(byte: std_logic_vector (byte_len - 1 downto 0); amount: integer) return std_logic_vector;

end utils;


package body utils is

    function rotl(byte: std_logic_vector (byte_len - 1 downto 0); amount: integer) return std_logic_vector is
    -- Performs an unsigned left rotation on an 8-bit std_logic_vector
        variable rotated: std_logic_vector (byte_len - 1 downto 0);
        variable temp: std_logic;

    begin

        -- Is there a (synthesizable) way to check that byte_len - amount does not become < 0 ? Is it recommended/advisable to check it?
        rotated := byte;
        for idx in amount - 1 downto 0 loop
            temp := rotated(0);
            rotated(0) := rotated(7);
            rotated(7) := rotated(6);
            rotated(6) := rotated(5);
            rotated(5) := rotated(4);
            rotated(4) := rotated(3);
            rotated(3) := rotated(2);
            rotated(2) := rotated(1);
            rotated(1) := temp;
        end loop;
        return rotated;

    end rotl;


    function rotr(byte: std_logic_vector (byte_len - 1 downto 0); amount: integer) return std_logic_vector is
    -- Performs an unsigned right rotation on an 8-bit std_logic_vector
        variable rotated: std_logic_vector (byte_len - 1 downto 0);
        variable temp: std_logic;

    begin

        -- Is there a (synthesizable) way to check that byte_len - amount does not become < 0 ? Is it recommended/advisable to check it?
        -- rotated := std_logic_vector(shif_right(unsigned(byte), amount)) xor std_logic_vector(shif_right(unsigned(byte), byte_len - amount));
        rotated := byte;
        for idx in amount - 1 downto 0 loop
            temp := rotated(7);
            rotated(7) := rotated(0);
            rotated(0) := rotated(1);
            rotated(1) := rotated(2);
            rotated(2) := rotated(3);
            rotated(3) := rotated(4);
            rotated(4) := rotated(5);
            rotated(5) := rotated(6);
            rotated(6) := temp;
        end loop;
        return rotated;

    end rotr;    

end utils;