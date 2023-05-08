%% Lab 4: Spectral Estimation Method - Welch's Method

% Consider an original signal consisting of 301 samples
randn('state',1)
fs = 1000; % Sampling frequency
t = (0:0.3*fs)./fs; % 301 samples
A = [2 8]; % Sinusoid amplitudes
(row vector)
f = [150;140]; % Sinusoid frequencies
(column vector)
xn = A*sin(2*pi*f*t) + 5*randn(size(t));
Hs = spectrum.periodogram('rectangular')
psd(Hs,xn,'Fs',fs,'NFFT',1024);

% Welch's spectral estimate for 3 segmants with 50% overlap
Hs = spectrum.welch('rectangular',150,50);
psd(Hs,xn,'Fs',fs,'NFFT',512);

% Reducing vaiance, the loss of resolution causes one of the sinusoids to
% be lost altogether
Hs = spectrum.welch('rectangular',100,75);
psd(Hs,xn,'Fs',fs,'NFFT',512);