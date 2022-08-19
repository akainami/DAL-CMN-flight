function [OUT] = masschange(x,u,aircraft)
C=fuelcons_jet(x,u,aircraft);      % Fuel consumption constant
T=u(1);                            % Momentarily Weight
OUT=-T*C/9.81;                     % Fuel Consumption
end

