clear all; clc; close all;
g=9.8; %acceleration due to gravity
mr=1e6; %mass of rocket
mf=1e6; %mass of feul to start
tb=200; %time of burn 
dt=.1; %time interval between calculations
ft = 35e6; %thrust force produced by the burning feul
C=20; %drag coefficent 
t_end = 600;%length of simulation
steps= t_end/dt; %to calculate number of iterations
v(1)=0;
t(1)=0;
h(1)=0;
mt(1)=mr+mf;
for i= 1:steps-1 
    if t(i)<=tb
        mt(i)=mr + mf - mf/tb*t(i); %calculates the mass of the rocket, accounting for the changing mass from feul burn off.
        ft = 35e6; 
    else 
        mt(i) = mr; % mass once feul is used up 
        ft=0; %thrust after feul is used up
    end
    if h(i)<20000
        p(i)=2e-9*h(i)^2-0.0001*h(i)+1.2514; % calulating air density which decreases at higher altitudes and becomes negligable at 20000m
    else
        p(i)=0;
    end
    t(i+1) = i*dt; %calculates the time 
    v(i+1) = dt*(-g-(C/(2*mt(i)))*p(i)*(v(i)^2)+ft/mt(i))+v(i); % velocity of the rocket 
    h(i+1) = v(i)*dt+h(i); % altitude of the rocket 
    Rocket_height=max(h)/1000; %finding max height
end
Rocket_height % export the rockets max height into the comand window
plot(t,v) %velocity vs time graph and labels
xlabel('time(s)')
ylabel('velocity (m/s)')
title('Velocity vs Time')
figure % makes both graphs stay out, and not have the first minimised by the second graph

plot(t,h) %plots altitude vs time and labels
xlabel('time(s)')
ylabel('Altitude(m)')
title('Altitude vs Time')