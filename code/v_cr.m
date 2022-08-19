function [OUT] = v_cr(x,~,aircraft)
g=9.81;
[~,~,rho,~]=non_ISA(0,x(3));
% Best range velocity for graded cruise
OUT=((2*x(6)*g/aircraft(2))/(rho))^.5*(3*aircraft(4)/aircraft(3))^.25;
end