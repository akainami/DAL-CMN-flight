function [x,u] = aircraft_motion(x,u,aircraft,stepsize)
% Euler Implementation on aircraft dynamic equations
x(1)=x(1)+x_vel(x,u)*stepsize;
x(2)=x(2)+y_vel(x,u)*stepsize;
x(3)=x(3)+z_vel(x,u)*stepsize;
x(4)=x(4)+accel(x,u,aircraft)*stepsize;
x(5)=x(5)+turnrate(x,u,aircraft)*stepsize;
x(6)=x(6)+masschange(x,u,aircraft)*stepsize;
end