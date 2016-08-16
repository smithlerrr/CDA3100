------------------------------------------------------------------
-- author: Drew Smith
-- class: CDA 3100
-- id: dbs13
------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity or_gate is
port(
  a: in std_logic;
  b: in std_logic;
  q: out std_logic;
  x: out std_logic;
  y: out std_logic);
end or_gate;

architecture rtl of or_gate is
begin
    q <= a or b;
    x <= a XOR b;
    y <= a AND b;
end rtl;

