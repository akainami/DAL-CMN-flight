function [OUT] = x_vel(x,u)
OUT=x(4)*cos(x(5))*cos(u(3));
end