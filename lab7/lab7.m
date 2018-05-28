clc;
clear all;
close all;

%%
message = [1 0 1 0]
code = encode(message,7,4)
% code = 0 0 1 1 0 1 0
code = [0 1 1 1 0 1 0]
% code = 0 0 0 1 0 1 0
[decoded,err] = decode(code,7,4)
% decoded = 1 0 1 0
% err = 1

maxi = 8;
fig = 1:maxi;
% vodopadniy grafik binarnoy oshibki Pb(SNR) = Pb(Eb/No)
for i=1:1:maxi 
    errs = randerr(1, 7, 8-i)
    err_sigmod = xor(code, errs)
    [decoded,err] = decode(err_sigmod,7,4)
    fig(i) = biterr(decoded, message)
end;
figure;
hold on
plot(7:-1:0, awgn(fig,20), '--', 'Color', 'r');

%%

message = [1 0 1 0]
[h, g, n, k] = hammgen(3)
m = message * g
m = rem(m, ones(1, n).* 2)
%m(1) = not(m(1))
synd = m * h'
synd = rem(synd, ones(1, n-k).* 2)
stbl = syndtable(h)
tmp = bi2de(synd, 'left-msb')
z = stbl(tmp + 1, :)
% z = [1 0 0 0 0 0 0]
result = xor(m, z)

fig = 1:maxi;
% vodopadniy grafik binarnoy oshibki Pb(SNR) = Pb(Eb/No)
for i=1:1:maxi 
    errs = randerr(1, 7, 8-i)
    err_sigmod = xor(m, errs)
    synd = err_sigmod * h'
    synd = rem(synd, ones(1, n-k).* 2)
    stbl = syndtable(h)
    tmp = bi2de(synd, 'left-msb')
    z = stbl(tmp + 1, :)
    result = xor(err_sigmod, z)
    fig(i) = biterr(result(1, 4:7), message);
end;
plot(7:-1:0, awgn(fig,20), '--', 'Color', 'y');

%%

message = [1 0 1 0]
poly = cyclpoly(7, 4)
[h, g] = cyclgen(7, poly);
m = message * g;
m = rem(m, ones(1, n).* 2)
% m(1) = not(m(1))
synd = m * h'
synd = rem(synd, ones(1, n-k).* 2)
stbl = syndtable(h)
tmp = bi2de(synd, 'left-msb')
z = stbl(tmp + 1, :)
% z = [1 0 0 0 0 0 0]
result = xor(m, z)
% 0 1 1 1 0 1 0

fig = 1:maxi;
% vodopadniy grafik binarnoy oshibki Pb(SNR) = Pb(Eb/No)
for i=1:1:maxi 
    errs = randerr(1, 7, 8-i)
    err_sigmod = xor(m, errs)
    synd = m * h'
    synd = rem(synd, ones(1, n-k).* 2)
    stbl = syndtable(h)
    tmp = bi2de(synd, 'left-msb')
    z = stbl(tmp + 1, :)
    result = xor(err_sigmod, z)
    fig(i) = biterr(result(1, 4:7), message);
end;
plot(7:-1:0, awgn(fig,20), '--', 'Color', 'g');

%%

message = [1 0 1 0]
coder = comm.BCHEncoder(7, 4)
decoder = comm.BCHDecoder(7, 4)
temp = message;
m = step(coder, temp(:))'
% m(1) = not(m(1))
result = step(decoder, m')'
% 1 0 1 0

fig = 1:maxi;
% vodopadniy grafik binarnoy oshibki Pb(SNR) = Pb(Eb/No)
for i=1:1:maxi
    errs = randerr(1, 7, 8-i)
    err_sigmod = xor(m, errs)
    decoder = comm.BCHDecoder(7, 4)
    result = step(decoder, err_sigmod')'
    fig(i) = biterr(result, message);
end;
plot(7:-1:0, awgn(fig,20), '--', 'Color', 'c');

%%
l = 3;
n = 7;
k = 3;
m = 3;
message = gf(randi([0 2*m-1], l, k), m)
%   3   5   3
%   5   3   4
%   2   3   2

code = rsenc(message, n, k)
%   3   5   3   6   5   0   0
%   5   3   4   3   2   4   5
%   2   3   2   6   3   7   7

errors = gf([...
    0 0 0 0 0 0 1;...
    3 0 0 0 0 0 3;...
    0 0 0 0 0 0 0], m)
%code = code + errors;

[decode, errorCount] = rsdec(code, n, k)

fig = 1:maxi;
% vodopadniy grafik binarnoy oshibki Pb(SNR) = Pb(Eb/No)
for i=1:1:maxi
    errors = [randerr(1, 7, 8-i);randerr(1, 7, 8-i);randerr(1, 7, 8-i)];
    err_sigmod = code + errors;
    [decode, errorCount] = rsdec(err_sigmod, n, k);
    message.x
    decode.x
    abs(decode.x - message.x)
    sum(sum(abs(decode.x - message.x)))
    fig(i) = sum(sum(abs(decode.x - message.x)));
end;
plot(7:-1:0, awgn(fig,20), '--', 'Color', 'm');
%   3   5   3
%   5   3   4
%   2   3   2

%errorCount =

%     1
%     2
%     0
