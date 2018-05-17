clc;
clear all;
close all;

%BPSK
modulator = modem.pskmod('M', 2);
demodulator = modem.pskdemod('M', 2);
msg = randi([0 1],8,1)
modSignal = modulate(modulator,msg);
errSignal = (randerr(1, 8, 4) ./ 20)';
modSignal = modSignal + errSignal;
demodSignal = demodulate(demodulator,modSignal);
scatterplot(modSignal);
%8PSK
modulator = modem.pskmod('M', 8);
demodulator = modem.pskdemod('M', 8);
msg = randi([0 7],20,1)
modSignal = modulate(modulator,msg);
errSignal = (randerr(1, 20, 10) ./ 20)';
modSignal = modSignal + errSignal;
demodSignal = demodulate(demodulator,modSignal);
scatterplot(modSignal)
%MSK
modulator = modem.mskmod('SamplesPerSymbol', 7);
demodulator = modem.mskdemod('SamplesPerSymbol', 7);
msg = randi([0 1],7,1);
modSignal = modulate(modulator, msg);
errSignal = (randerr(1, 49, 4) ./ 20)';
modSignal = modSignal + errSignal;
demodSignal = demodulate(demodulator, modSignal);
scatterplot(modSignal);
%OQPSK
dataIn = randi([0 3],100,1)
txSig = oqpskmod(dataIn);
rxSig = awgn(txSig,25);
dataOut = oqpskdemod(rxSig);
numErrs = symerr(dataIn,dataOut)
scatterplot(txSig);