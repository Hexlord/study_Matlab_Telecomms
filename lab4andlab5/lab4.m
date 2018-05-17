close all;
clear all;

figure_properties = {'units', 'centimeters', 'position', [12, 10, 30, 10], ...
    'DefaultAxesPosition', [0.08, 0.17, 0.88, 0.8]};

N = 512;
Fs = 512;
Fc = 64;
F0 = 5;
M = 0.2;

t = (1:N)/Fs;
f = (-N/2:N/2-1) .* (Fs/N);

x = M*cos(2 * pi * F0 * t);

y_amod = ammod(x, Fc, Fs, 0, 1);

y_ademod = amdemod(y_amod, Fc, Fs, 0, 1);

s = fftshift(fft(x));
s_amod = fftshift(fft(y_amod));

s_ademod = fftshift(fft(y_ademod));

figure(figure_properties{:})
hold on
plot(t, y_amod, 'r')
plot(t, x, 'b')


figure(figure_properties{:})
hold on
plot(f, abs(s), 'b')
plot(f, abs(s_amod), 'r')
%xlim([-Fs/2, Fs/2]);
xlim([-Fc*2, Fc*2]);

figure(figure_properties{:})
hold on
plot(t, y_ademod, 'b')
% plot(t, x, 'b')


figure(figure_properties{:})
hold on
plot(f, abs(s_ademod), 'b')
xlim([-Fs/2, Fs/2]);


