function [T,P,ro,a] = non_ISA(dT,h)
%% Parameter Definitions
T_0=288.15; % [K] Sea level standard atmospheric temperature
P_0=101325; % [Pa] Sea level standard atmospheric pressure
ro_0=1.225; % [kg/m3] Sea level standard atmospheric density
a0_0=340.294; % [m/s] Sea level speed of sound

kappa=1.4; % [] Adiabatic index of air
R=287.05287; % [m2/(Ks2)] Real gas constant of air
g_0=9.80665; % [m/s2] Gravitational acceleartion

grad=-0.0065; % [K/m] Temperature gradient below tropopause
h_tp=11000; % [m] Tropopause altitude

%% Temperature
if h < h_tp
    T=T_0+dT+grad*h;
else % Else cond. for temperature above troposphere
    T=T_0+dT+grad*h_tp;
end

%% Pressure
if h <= h_tp
    P=P_0*((T-dT)/T_0)^(-g_0/(grad*R)); % Below Troposphere
else
    P_trop=P_0*((T-dT)/T_0)^(-g_0/(grad*R));
    P=P_trop*exp((h_tp-h)*(g_0/(R*(T-dT)))); % Above Troposhpere
end

%% Density  
ro=P/R/T; % From perfect gas law

%% Speed of sound
a=sqrt(kappa*R*T); % From the definition

end

