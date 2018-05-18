clear all;
close all;
clc;

M=4;
% x = randi([0,M-1], 1000, 1);

[H, G] = hammgen(3)
H'

% gen2par(G);
msg = [1 0 0 1]
code=encode(msg, 7,4) % 0 1 1 1 0 0 1
code = [1 1 1 1 0 0 1] % added 1 error
decode(code,7,4) % 1 0 0 1 (error corrected)

code = [1 0 1 1 0 0 1] % added 2 errors
decode(code,7,4) % 0 0 0 1 (error occurred in bit 0)

%%
msg = [1 0 0 1 1]
% create syndrome 
H = [
 1 0 0 1; %a4
 0 1 1 1; %a3
 0 1 1 0; %a2
 0 1 0 1; %a1
 0 0 1 1; %a0
 1 0 0 0; %b3 %E
 0 1 0 0; %b2
 0 0 1 0; %b1
 0 0 0 1]' %b0
a0 = msg(5)
a1 = msg(4)
a2 = msg(3)
a3 = msg(2)
a4 = msg(1)
b0 = mod(a4, 2)
b1 = mod(a1 + a2 + a3, 2)
b2 = mod(a0 + a2 + a3, 2)
b3 = mod(a0 + a1 + a3 + a4, 2)
code = [msg, b3, b2, b1, b0]
mod(code * (H'), 2)% 0 - no error

code = [1 0 0 1 1 1 1 1 0]
mod(code * (H'), 2) % 1 - error in bit 1
