close all
clear all
clc

signal = [0 0 0 1 1 1 0 1 1 1 0 0 0 0 1 0];
sync = [1 0 1];

signalLength = length(signal);
syncLength = 3;
dataLength = 8;

t = 0:(signalLength-1);

[corr, lag] = xcorr(signal, sync);
corr = corr(signalLength:end);
lag = lag(signalLength:end);

maxCorrIndex = (corr == max(corr));

figure
stem(lag, corr)
xticks(lag)
xlabel('Lag')
ylabel('Correlation')

for i = 1:length(maxCorrIndex)
    if (maxCorrIndex(i))
        syncRange = (lag(i):(lag(i)+syncLength-1)) + 1
        dataRange = syncRange(end)+1:syncRange(end)+8;
        if (dataRange(end) > signalLength)
            dataRange = dataRange(1):signalLength;
        end
        dataRange
        figure
        hold on
        stem(t, signal)
        stem(t(syncRange), sync, 'g*')
        stem(t(dataRange), signal(dataRange), 'y*')
        legend('Signal', 'Sync', 'Data')
        xticks(t)
        xlabel('t')
        ylabel('s(t)')
    end
end

dataStart = min(lag(maxCorrIndex));
dataRange = (dataStart+1:dataStart+dataLength) + syncLength;
data = signal(dataRange)




