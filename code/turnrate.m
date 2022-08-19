function [OUT] = turnrate(x,u,aircraft)
S=aircraft(2);                % m^2

[~,~,rho,~]=non_ISA(0,x(3));          % kg/m^3
c_L=x(6)/(1/2*rho*x(4)^2*S);          % -

OUT=-c_L*S*rho*x(4)/2/x(6)*sin(u(2));
end