%% Lab 4: Spectral Estimation Method - Welch's Method
clear
close all
clc

% Welch's method is implemented in the Signal Processing Toolbox by the 'spectrum.welch' object or pwelch function. By default, the data is divided into four segments with 50% overlap between them.
% A Hamming window is used to compute the modified periodogram of each segment.

% Consider an original signal consisting of 301 samples
randn('state',1)
fs = 1000; % Sampling frequency
t = (0:0.3*fs)./fs; % 301 samples
A = [2 8]; % Sinusoid amplitudes (row vector)
f = [150;140]; % Sinusoid frequencies (column vector)
xn = (A*sin(2*pi*f*t))+(5*randn(size(t)));
Hs = spectrum.periodogram('rectangular');
psd(Hs,xn,'Fs',fs,'NFFT',1024)
figure;
% We can obtain Welch's spectral estimate for 3 segments with 50% overlap with
Hs = spectrum.welch('rectangular',150,50);
psd(Hs,xn,'Fs',fs,'NFFT',512)
figure;
% However, if we try to reduce the variance further, the loss of resolution causes one of the sinusoids to be lost altogether
Hs = spectrum.welch('rectangular',100,75);
psd(Hs,xn,'Fs',fs,'NFFT',512)