%% Performance of the Periodogram

% Consider the sequence of 100 samples
randn('state',0)
fs = 1000; % Sampling frequency
t = (0:fs/10)/fs; % One-tenth of a second worth of samples
A = [1 2]; % Sinusoid amplitudes
f = [150;140]; % Sinusoid frequencies
xn = A*sin(2*pi*f*t) + 0.1*randn(size(t));
Hs = spectrum.periodogram;
psd(Hs,xn,'Fs',fs,'NFFT',1024)

% Consider a sequence of 67 samples
randn('state',0)
fs = 1000; % Sampling frequency
t = (0:fs/15)./fs; % 67 samples
A = [1 2]; % Sinusoid amplitudes
f = [150;140]; % Sinusoid frequencies
xn = A*sin(2*pi*f*t) + 0.1*randn(size(t));
Hs=spectrum.periodogram;
psd(Hs,xn,'Fs',fs,'NFFT',1024)

% Cosidering noise
randn('state',0)
fs = 1000; % Sampling frequency
t = (0:fs/10)./fs; % One-tenth of a second worth of samples
A = [1 2]; % Sinusoid amplitudes
f = [150;140]; % Sinusoid frequencies
xn = A*sin(2*pi*f*t) + 2*randn(size(t));
Hs=spectrum.periodogram;
psd(Hs,xn,'Fs',fs,'NFFT',1024)

% Compare a default rectangular window and a Hamming window
randn('state',0)
fs = 1000; % Sampling frequency
t = (0:fs/10)./fs; % One-tenth of a second worth of samples
A = [1 2]; % Sinusoid amplitudes
f = [150;140]; % Sinusoid frequencies
xn = A*sin(2*pi*f*t) + 0.1*randn(size(t));
Hrect = spectrum.periodogram;
psd(Hrect,xn,'Fs',fs,'NFFT',1024);


Hhamm = spectrum.periodogram('Hamming');
psd(Hhamm,xn,'Fs',fs,'NFFT',1024);