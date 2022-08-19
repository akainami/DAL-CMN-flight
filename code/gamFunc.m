function [OUT]=gamFunc(x,u,aircraft)
E_m=aircraft(7);
W=9.81*x(6);
T=u(1);
OUT=1+sqrt(1+3/(E_m*T/W)^2);
end