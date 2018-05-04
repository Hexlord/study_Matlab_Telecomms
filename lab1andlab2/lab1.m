close all
clear all
clc

N = 256;
frange = 100;
step = 1/frange;
F0 = 5;
T0 = 1/F0;
halfcount=(N-1)/2;
t = -step*halfcount:step:step*halfcount;

signal_type = 2;

switch signal_type
    case 0
        x = sin(2*pi*F0*t) + 0.25*cos(2*pi*(F0/8)*t);
    case 1
        x = square(2*pi*F0*t, 25);
    case 2
        x = square(2*pi*F0*t, 75);
end

s = fft(x, N);
s = fftshift(s);
f = (frange/N)*(-halfcount:halfcount); 

figure
hold on
plot(t, x)
xlim([min(t), max(t)])
ylim([-1.25, 1.25])
xlabel('t')
ylabel('x(t)')

figure
plot(f, abs(s))
ylim([0, max(abs(s)) * 1.25])
ylabel('|\Phi(f)|')
xlabel('f')

