%% Plot the linear chirp signal

addpath('../functions');

% Signal parameters
f0 = 10;
f1 = 10;
phi0 = 0;
A = 10;

% Maximum instantaneous frequency after 1 sec
maxFreq = f0+f1;

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
sigVec = linearchirpf(timeVec,A,f0,f1,phi0);

% Plot the signal
figure;
plot(timeVec,sigVec,'Marker','.','MarkerSize',24);
xlabel('Time (sec)');
title('Sampled Linear Chirp Signal');

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
title('Linear Chirp Periodogram');