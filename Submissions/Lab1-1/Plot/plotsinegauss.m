%% Plot the sine-Gaussian signal

addpath('../functions');

% Signal parameters
t0 = 0.5;
sigma = 0.1;
f0 = 20;
phi0 = 0;
A = 10;

% Nyquist frequency guess
nyqFreq = 2*f0;

% Sampling frequency
samplFreq = 5*nyqFreq;
samplIntrvl = 1/samplFreq;

% Time samples
timeVec = 0:samplIntrvl:1.0;

% Number of samples
nSamples = length(timeVec);

% Generate the signal
sigVec = sinegaussf(timeVec,A,t0,sigma,f0,phi0);

% Plot the signal
figure;
plot(timeVec,sigVec,'Marker','.','MarkerSize',24);
xlabel('Time (sec)');
title('Sampled Sine-Gaussian Signal');

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
title('Sine-Gaussian Periodogram');