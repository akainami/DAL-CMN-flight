function [OUT] = thrust(x,~,aircraft)
% Assume in stratosphere
[~,~,rho_sl,~]=non_ISA(0,0);
[~,~,rho,~]=non_ISA(0,x(3));
T_max=aircraft(5)*rho/rho_sl;
% Thrust at altitude
OUT=T_max;
end

