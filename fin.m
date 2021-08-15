%%%%%%%%%%%% p  1      %%%%%%%%%%%%%%%%%%% 
clc
clear 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%------------------parameters
l = 5; % (m)
NX = input('NX = number of points = ? ');
h = 15;
k = 180;
tinf = 25; %Infinite temperature
r = 0.01;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dx = l/(NX-1);
t0(1:NX) = 0;
x(1) = 0;
for i = 1:NX
    t(i) = 0;
    x(i+1) = x(i)+dx;
end
c1 = 2*h*dx/(k*r);
for j = 1:10000
    for i = 2:NX-2
        a(i+1,i) = -1;
    end
    for i = 3:NX-1
        a(i-1,i) = -1;
    end
    for i = 2:NX-1
        a(i,i) = 2+c1*dx^2;
    end
    c(2) = c1*tinf*dx^2+t(1);
    c(NX-1) = c1*tinf*dx^2+t(NX);
    for i = 3:NX-2
        c(i) = c1*tinf*dx^2;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % --------- tomas algoritm
    for i = 3:NX-1
        a(i,i) = a(i,i)-(a(i-1,i)/a(i-1,i-1))*a(i,i-1);
        c(i) = c(i)-(a(i-1,i)/a(i-1,i-1))*c(i-1);
    end
    t(NX-1) = c(NX-1)/a(NX-1,NX-1);
    for i = NX-2:-1:2
        t(i) = ((c(i)-(a(i+1,i)*t(i+1)))/a(i,i));
    end
    t(1) = 200.;
    t(NX) = t(NX-1);
    error = 0;
    for i = 1:NX
        error = error+abs(t(i)-t0(i));
    end
    if(error<0.000001)
        break
    end
    t0 = t;
end
plot(x(1:NX),t(1:NX),'-*'),xlabel('x'),ylabel('temperature'),

