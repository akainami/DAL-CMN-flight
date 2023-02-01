%{
MIT License

Copyright (c) 2022 akainami

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
%}

% Flight Mechanics Term Project, Atakan Öztürk & Hilal Cankurtaran,
% Aircraft Dynamic Model
clc;clear;close;tic;

%% Aircraft Definition
% Required parameters
m_initial=247.2*1000;    % 1,kg
S=427.8;                 % 2,m^2
c_d_0=0.016;             % 3,-
c_d_2=0.04287;           % 4,- 
T_sl=343e3*2;            % 5,N
c=0.6;                   % 6,N/h/N
E_m=19.09;               % 7,-
g=9.81;                  % m/s2
V_lof=86.42;             % m/s
headingInit=0;           % Assume heading angle of departing runway
pathInit=T_sl/m_initial/g-1/E_m;
total_dist=8253.15e3;    % total distance from DAL to FRA, m
x_des_nom=300e3;      % Nominal descending distance
x=[0 0 0 V_lof headingInit m_initial]; % State
u=[T_sl 0 pathInit]; % Control
aircraft=[m_initial;S;c_d_0;c_d_2;T_sl;c;E_m];  % Aircraft

%% Aircraft Motion
% Initialization and Preallocation for state-control parameters
stepsize=1;
x_log=NaN(1,6);
u_log=NaN(1,3);
iter_i=1;
t_0=0;

% Climb Phase
% Climb to h_2 from h_1
h_2=13e3;
bank=0;
while x(3) < h_2
    T=thrust(x,u,aircraft);
    path=gamma_cl(x,u,aircraft);
    u=[T bank path];
    [x,u]=aircraft_motion(x,u,aircraft,stepsize);
    x_log(iter_i,:)=x;
    u_log(iter_i,:)=u;
    iter_i=iter_i+1;
end
x_tab(1,:)=[x iter_i];
% Cruise
% For x_cr distance
%{
 %Graded Climb Cruise - Wrong approach
x_cl=sqrt(x(1)^2+x(2)^2);
x_cr=total_dist-x_cl-x_des_nom;
path=gamma_cr(x,u,aircraft); % Defining at the outside of the loop
bank=0;
while sqrt(x(1)^2+x(2)^2) < x_cr+x_cl
    T=thrust(x,u,aircraft);   
    u=[T bank path];
    [x,u]=aircraft_motion(x,u,aircraft,stepsize);
    x_log(iter_i,:)=x;
    u_log(iter_i,:)=u;
    iter_i=iter_i+1;
end
%}

 % Constant Height flight, variable T, V, cL
x_cl=sqrt(x(1)^2+x(2)^2);
x_cr=total_dist-x_cl-x_des_nom;
path=0; % Defining at the outside of the loop
bank=0;
while sqrt(x(1)^2+x(2)^2) < x_cr+x_cl
    T=drag(x,u,aircraft);   
    u=[T bank path];
    [x,u]=aircraft_motion(x,u,aircraft,stepsize);
    x_log(iter_i,:)=x;
    u_log(iter_i,:)=u;
    iter_i=iter_i+1;
end
x_tab(2,:)=[x iter_i];
% Descent
bank=0;
path=gamma_des(x,u,aircraft);
while x(3) > 0
    T=0;   % Gliding Flight
    u=[T bank path];
    [x,u]=aircraft_motion(x,u,aircraft,stepsize);
    x_log(iter_i,:)=x;
    u_log(iter_i,:)=u;
    iter_i=iter_i+1;
end
x_tab(3,:)=[x iter_i];
%% Plotting
figure; plot(sqrt((x_log(:,1).^2+x_log(:,2).^2)),x_log(:,3),'k'); 
title('Flight Path'); xlabel('Projected Distance [m]'); ylabel('Altitude [m]');

figure; plot(x_log(:,4),'k'); title('True Airspeed'); xlabel('Time [s]');
ylabel('V_{TAS} [m/s]');

figure; plot(x_log(:,4).*sin(u_log(:,3)),'k'); title('(R/C)'); xlabel('Time [s]');
ylabel('Rate Of Climb [m/s]');

figure; plot(x_log(:,6),'k'); title('Mass of the aircraft [kg]');
xlabel('Time [s]'); ylabel('m [kg]');

figure; plot(u_log(:,1),'k'); title('Throttle Map'); 
xlabel('Time [s]'); ylabel('T [N]');

figure; plot(u_log(:,3),'k'); title('Path Angle'); 
xlabel('Time [s]'); ylabel('\gamma [rad]');

fprintf('Total Fuel Consumption is %.2f [kg]\n\n', m_initial-x(6));
fprintf('Total Flight Duration is %.2f [h]\n\n', iter_i/3600);

toc
