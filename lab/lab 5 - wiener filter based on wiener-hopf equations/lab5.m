%% Lab 5: Wiener Filter based on Wiener-Hopf equations

% This demo shows how Wiener filtering works for recovering the reference signal
clc; 
clear; 
close all;

fs = 4000;                         % sampling frequency
T = 1;                             % total recording time
L = T .* fs;                       % signal length
tt = (0:L-1)/fs;                   % time vector
ff = (0:L-1)*fs/L;
y = sin(2*pi*120 .* tt); y = y(:); % reference sinusoid
x = 0.50*randn(L,1) + y; x = x(:); % sinusoid with additive Gaussian noise
N = 200;                           % filter order
[xest,MSE] = wienerFilt(x,y,N);  % use Wiener Filter function to process

% plot results
subplot(3,1,1), plot(tt,x,'k'), hold on, plot(tt,y,'r')
title('Wiener filtering example')
legend(' noisy signal',' reference')
subplot(3,1,2), plot(tt(N+1:end),xest,'k')
legend(' estimated signal')
subplot(3,1,3), plot(tt(N+1:end),(x(N+1:end) - xest),'k')
legend(' residue signal')
xlabel('time (s)')

% function definition
function [xest,MSE] = wienerFilt(x,y,N)
 % Wiener filter based on Wiener-Hopf equations
% This function takes as inputs a noisy signal, x, and a reference signal, y,
% in order to compute a N-order linear filter that provides an estimate of y
% from x

% OUTPUTS
% xest = estimated signal, b = Wiener filter coefficents
% MSE = mean squared error
X = 1/N .* fft(x(1:N));
Y = 1/N .* fft(y(1:N));
X = X(:);
Y = Y(:);
Rxx = N .* real(ifft(X .* conj(X))); % Autocorrelation function
Rxy = N .* real(ifft(X .* conj(Y))); % Crosscorrelation function
Rxx = toeplitz(Rxx);
Rxy = Rxy';
B = Rxy / Rxx; B = B(:);             % Wiener-Hopf eq., B = inv(Rxx)*Rxy
xest = fftfilt(B,x);
xest = xest(N+1:end);                % cut first N samples due to distorsion during filtering operation
MSE = mean(y(N+1:end) - xest) .^2;   % mean squared error
end