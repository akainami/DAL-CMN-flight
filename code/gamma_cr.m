function [OUT] = gamma_cr(x,u,aircraft)
% Best range path angle for graded cruise
OUT=8.38*aircraft(6)/v_cr(x,u,aircraft)/aircraft(7);
end