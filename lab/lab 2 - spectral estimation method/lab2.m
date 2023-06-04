%% Lab 2: Spectral Estimation Method
clear
close all
clc

% Consider 1001 element signal xn, which consists of two sinusoids plus
% noise
randn('state',0);
fs = 1000; % Sampling frequency
t = (0:fs)/fs; % One second worth of samples
A = [1 2]; % Sinusoid amplitudes (row vector)
f = [150;140]; % Sinusoid frequencies (column vector)
xn = A*sin(2*pi*f*t) + 0.1*randn(size(t));

% Compute periodogram estimate of the PSD by creating a periodogram object
Hs = spectrum.periodogram('Hamming');

% PSD method used to plot the estimate
psd(Hs,xn,'Fs',fs,'NFFT',1024,'SpectrumType','twosided');

% Compute average power by approximating the integral 
[Pxx,F] = psd(Hs,xn,fs,'twosided');
Pow = (fs/length(Pxx)) * sum(Pxx);

% Compute average power from the one-sided PSD estimate
[Pxxo,F] = psd(Hs,xn,fs,'onesided');
Pow = (fs/(2*length(Pxxo))) * sum(Pxxo);