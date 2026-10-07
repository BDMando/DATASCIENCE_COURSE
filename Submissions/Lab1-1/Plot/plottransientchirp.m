%% Plot the linear transient chirp

addpath('../functions');

% Signal parameters
ta = 0.25;
f0 = 10;
f1 = 10;
phi0 = 0;
L = 0.5;
A = 10;

% Maximum instantaneous frequency
maxFreq = f0+2*f1*L;

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
sigVec = transientchirpf(timeVec,A,ta,f0,f1,phi0,L);

% Plot the signal
figure;
plot(timeVec,sigVec,'Marker','.','MarkerSize',24);
xlabel('Time (sec)');
title('Sampled Linear Transient Chirp');

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
title('Linear Transient Chirp Periodogram');