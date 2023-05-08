%% Lab 1: Remove High-Frequency Noise in Measured Data

% Read Data
[humidity,time] = thingSpeakRead(12397,'NumPoints',8000,'Fields',3);

filtertype = 'FIR';
Fs = 1/60;
N = 3;
Fpass = 1/(24*60*60);
Fstop = 1/(2*60*60);
Rp = 0.5;
Astop = 50;

LPF = dsp.LowpassFilter('SampleRate',Fs,...
'FilterType',filtertype,...
'PassbandFrequency',Fpass,...
'StopbandFrequency',Fstop,...
'PassbandRipple',Rp,...
'StopbandAttenuation',Astop);

% Process and Send the Data to ThingSpeak

Output = step(LPF, humidity);

channelID = 17504;
writeAPIKey='23ZLGOBBU9TWHG2H';
thingSpeakWrite(channelID,Output,'Timestamps',time,'WriteKey',writeAPIKey);
plot(time,humidity,time,Output);
ylabel('Relative Humidity');
legend('Raw Data', 'Filtered Data');