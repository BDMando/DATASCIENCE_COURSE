%% Plot the AM-FM sinusoid

addpath('../functions');

% Signal parameters
b = 2;
f0 = 20;
f1 = 2;
A = 10;

% Maximum instantaneous frequency
maxFreq = f0+b*f1;

% Nyquist frequency guess
nyqFreq = 2*maxFreq;

% Sampling frequency
samplFreq = 5*nyqFreq;
samplIntrvl = 1/samplFreq;

% Time samples
timeVec = 0:samplIntrvl:1.0;

% Number of samples
nSamples = length(timeVec);

% Generate the signal
sigVec = AMFMf(timeVec,A,b,f0,f1);

% Plot the signal
figure;
plot(timeVec,sigVec,'Marker','.','MarkerSize',24);
xlabel('Time (sec)');
title('Sampled AM-FM Sinusoid');

% Plot the periodogram
dataLen = timeVec(end)-timeVec(1);
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);

fftSig = fft(sigVec);
fftSig = fftSig(1:kNyq);

figure;
plot(posFreq,abs(fftSig));
xlabel('Frequency (Hz)');
ylabel('|FFT|');
title('AM-FM Sinusoid Periodogram');