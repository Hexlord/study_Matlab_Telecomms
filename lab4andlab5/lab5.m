close all;
clear all;

figure_properties = {'units', 'centimeters', 'position', [12, 10, 30, 10], ...
    'DefaultAxesPosition', [0.08, 0.17, 0.88, 0.8]};

N = 512;
Fs = 512;
Fc = 32;
F0 = 5;
FREQDEV = 8;
DEVIATION = 1/2;

t = (1:N)/Fs;
f = (-N/2:N/2-1) .* (Fs/N);

x = cos(2 * pi * F0 * t);

y_pmod = pmmod(x, Fc, Fs, pi * DEVIATION);
y_fmod = fmmod(x, Fc, Fs, FREQDEV);

y_pdemod = pmdemod(y_pmod, Fc, Fs, DEVIATION);
y_fdemod = pmdemod(y_fmod, Fc, Fs, FREQDEV);


s = fftshift(fft(x));
s_pmod = fftshift(fft(y_pmod));
s_fmod = fftshift(fft(y_fmod));

s_pdemod = fftshift(fft(y_pdemod));
s_fdemod = fftshift(fft(y_fdemod));

figure(figure_properties{:})
hold on
plot(t, y_pmod, 'r')
plot(t, x, 'b')

figure(figure_properties{:})
hold on
plot(f, abs(s_pmod), 'r')
xlim([-Fs/2, Fs/2]);

figure(figure_properties{:})
hold on
plot(t, y_fmod, 'r')
plot(t, x, 'b')

figure(figure_properties{:})
hold on
plot(f, abs(s_fmod), 'r')
xlim([-Fs/2, Fs/2]);

figure(figure_properties{:})
hold on
plot(t, y_pdemod, 'b')
%plot(t, x, 'b')

figure(figure_properties{:})
hold on
plot(f, abs(s_pdemod), 'b')
xlim([-Fs/2, Fs/2]);

figure(figure_properties{:})
hold on
plot(t, y_fdemod, 'b')
%plot(t, x, 'b')

figure(figure_properties{:})
hold on
plot(f, abs(s_fdemod), 'b')
xlim([-Fs/2, Fs/2]);
