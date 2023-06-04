%% Performance of the Periodogram
clear
close all
clc

%% Consider the following sequence of 100 samples
randn('state',0)
fs = 1000;                                   % Sampling frequency
t = (0:fs/10)/fs;                            % One-tenth of a second worth of samples
A = [1 2];                                   % Sinusoid amplitudes
f = [150;140];                               % Sinusoid frequencies
xn = A*sin(2*pi*f*t) + 0.1*randn(size(t));
Hs = spectrum.periodogram;
psd(Hs,xn,'Fs',fs,'NFFT',1024)
figure;
% Consider a case where this criterion is not met, as for the sequence of 67 samples
randn('state',0)
t = (0:fs/15)./fs;                           % 67 samples
xn = (A*sin(2*pi*f*t))+(0.1*randn(size(t)));
psd(Hs,xn,'Fs',fs,'NFFT',1024)
% The above discussion about resolution did not consider the effects of noise since the Signal-to-Noise Ratio(SNR) has been relatively high thus far.
% When the SNR is low, true spectral features are much harder to distinguish, and noise artifacts appear in spectral estimates based on the periodogram.
figure;
randn('state',0)
t = (0:fs/10)./fs;                           % One-tenth of a second worth of samples
xn = (A*sin(2*pi*f*t))+(2*randn(size(t)));
psd(Hs,xn,'Fs',fs,'NFFT',1024)
% The periodogram function allows you to compute a modified periodogram by specifying the window to be used on the data. For example, compare a default rectangular window and a Hamming window
figure;
randn('state',0)
xn = (A*sin(2*pi*f*t))+(0.1*randn(size(t)));
Hrect = spectrum.periodogram;
psd(Hrect,xn,'Fs',fs,'NFFT',1024)
figure;
Hhamm = spectrum.periodogram('Hamming');
psd(Hhamm,xn,'Fs',fs,'NFFT',1024)