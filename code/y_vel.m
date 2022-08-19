function [OUT] = y_vel(x,u)
OUT=x(4)*sin(x(5))*cos(u(3));
end