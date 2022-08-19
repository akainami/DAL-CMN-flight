function [OUT] = gamma_cl(x,u,aircraft)
Gamma=gamFunc(x,u,aircraft);
T=u(1);
W=x(6)*9.81;
E_m=aircraft(7);
OUT=asin((T/W*(1-Gamma/6)-3/(2*Gamma*E_m^2*T/W)));
end