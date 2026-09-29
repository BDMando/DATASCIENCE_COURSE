%% Plot the sinusoidal signal

% Add functions folder
addpath('../functions');

% Signal parameters
f0 = 10;
phi0 = 0;
A = 10;

% Nyquist frequency guess: 2 * signal frequency
nyqFreq = 2*f0;

% Sampling frequency
samplFreq = 5*nyqFreq;
samplIntrvl = 1/samplFreq;

% Time samples
timeVec = 0:samplIntrvl:1.0;

% Number of samples
nSamples = length(timeVec);

% Generate the signal
sigVec = sinusoidf(timeVec,A,f0,phi0);

% Plot the signal
figure;
plot(timeVec,sigVec,'Marker','.','MarkerSize',24);
xlabel('Time (sec)');
title('Sampled Sinusoidal Signal');


% Plot the periodogram
% ---------------------

% Length of data
dataLen = timeVec(end)-timeVec(1);

% DFT sample corresponding to Nyquist frequency
kNyq = floor(nSamples/2)+1;

% Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);

% FFT of signal
fftSig = fft(sigVec);

% Discard negative frequencies
fftSig = fftSig(1:kNyq);

% Plot periodogram
figure;
plot(posFreq,abs(fftSig));
xlabel('Frequency (Hz)');
ylabel('|FFT|');
title('Periodogram');