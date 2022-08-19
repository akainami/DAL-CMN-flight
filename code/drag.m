function [D,cD] = drag(x,~,aircraft)
% D=1/2*ro*v^2*s*cd
% V is true airspeed
% dT is temperature difference from isa
% H is altitude
dT=0;
g=9.81;
cD_0=aircraft(3);
cD_2=aircraft(4);
[~,~,rho,~]=non_ISA(dT,x(3));

S=aircraft(2);                        % m^2
c_L=x(6)*g/(1/2*rho*x(4)^2*S);          % -

cD=cD_2*c_L^2+cD_0;
D=1/2*rho*x(4)^2*cD*S;
end