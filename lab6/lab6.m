clc;
clear all;
close all;

%BPSK
modulator = modem.pskmod('M', 2);
demodulator = modem.pskdemod('M', 2);
msg = randi([0 1],256 / 2,1)
modSignal = modulate(modulator,msg);
demodSignal = demodulate(demodulator,modSignal);

maxi = 32;
fig = 1:maxi;
% vodopadniy grafik binarnoy oshibki Pb(SNR) = Pb(Eb/No)
for i=1:1:maxi 
    err_sigmod = awgn(modSignal, i);
    err_sigdemod = demodulate(demodulator, err_sigmod);
    err=biterr(msg, err_sigdemod);
    fig(i) = err;
end;
figure;
hold on
plot(1:maxi, fig, '-', 'Color', 'r');

%8PSK
modulator = modem.pskmod('M', 8);
demodulator = modem.pskdemod('M', 8);
msg = randi([0 7],256 / 8,1);
modSignal = modulate(modulator,msg);
demodSignal = demodulate(demodulator,modSignal);

fig = 1:maxi;
% vodopadniy grafik binarnoy oshibki Pb(SNR) = Pb(Eb/No)
for i=1:1:maxi 
    err_sigmod = awgn(modSignal, i);
    err_sigdemod = demodulate(demodulator, err_sigmod);
    err=biterr(msg, err_sigdemod);
    fig(i) = err;
end;
plot(1:maxi, fig, '-', 'Color', 'y');

%MSK
msg = randi([0 1],256/2,1)
modSignal = mskmod(msg, 1);
demodSignal = mskdemod(modSignal, 1)

fig = 1:maxi;
% vodopadniy grafik binarnoy oshibki Pb(SNR) = Pb(Eb/No)
for i=1:1:maxi 
    err_sigmod = awgn(modSignal, i);
    err_sigdemod = mskdemod(err_sigmod, 1);
    err=biterr(msg, err_sigdemod);
    fig(i) = err;
end;
plot(1:maxi, fig, '-', 'Color', 'g');

%OQPSK
msg = randi([0 3],256 / 4,1);
txSig = oqpskmod(msg);

fig = 1:maxi;
% vodopadniy grafik binarnoy oshibki Pb(SNR) = Pb(Eb/No)
for i=1:1:maxi 
    err_sigmod = awgn(txSig, i);
    err_sigdemod = oqpskdemod(err_sigmod);
    err=biterr(msg, err_sigdemod);
    fig(i) = err;
end;
hold on
plot(1:maxi, fig, '-', 'Color', 'c');


