function [OUT] = accel(x,u,aircraft)
[D,~]=drag(x,u,aircraft);             % -
g=9.81;                               % m/s^2
S=aircraft(2);                        % m^2
OUT=-g*sin(u(3))-D/x(6)+u(1)/x(6);
end