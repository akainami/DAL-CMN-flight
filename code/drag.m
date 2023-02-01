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
