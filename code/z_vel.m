function [OUT] = z_vel(x,u)
OUT=x(4)*sin(u(3));
end