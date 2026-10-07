% Clear if needed
% Plots all generated signals in Functions folder

addpath('../functions');

% Sampling interval
deltaT = 0.001;

% Time vector: 0 to 1 second
dataX = 0:deltaT:1;

% Signal-to-noise ratio
snr = 10;

%% 1. Sinusoidal Signal

f0 = 10;
phi0 = 0;

sinSignal = sinusoidf(dataX,snr,f0,phi0);

figure;
plot(dataX,sinSignal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Sinusoidal Signal');
grid on;


%% 2. Linear Chirp

f0 = 5;
f1 = 20;
phi0 = 0;

linearChirp = linearchirpf(dataX,snr,f0,f1,phi0);

figure;
plot(dataX,linearChirp);
xlabel('Time (s)');
ylabel('Amplitude');
title('Linear Chirp');
grid on;


%% 3. Sine-Gaussian Signal

t0 = 0.5;
sigma = 0.1;
f0 = 20;
phi0 = 0;

sineGaussian = sinegaussf(dataX,snr,t0,sigma,f0,phi0);

figure;
plot(dataX,sineGaussian);
xlabel('Time (s)');
ylabel('Amplitude');
title('Sine-Gaussian Signal');
grid on;


%% 4. FM Sinusoid

b = 5;
f0 = 20;
f1 = 2;

fmSignal = FMf(dataX,snr,b,f0,f1);

figure;
plot(dataX,fmSignal);
xlabel('Time (s)');
ylabel('Amplitude');
title('FM Sinusoid');
grid on;


%% 5. AM Sinusoid

f0 = 20;
f1 = 2;
phi0 = 0;

amSignal = AMf(dataX,snr,f0,f1,phi0);

figure;
plot(dataX,amSignal);
xlabel('Time (s)');
ylabel('Amplitude');
title('AM Sinusoid');
grid on;


%% 6. AM-FM Sinusoid

b = 5;
f0 = 20;
f1 = 2;

amfmSignal = AMFMf(dataX,snr,b,f0,f1);

figure;
plot(dataX,amfmSignal);
xlabel('Time (s)');
ylabel('Amplitude');
title('AM-FM Sinusoid');
grid on;


%% 7. Linear Transient Chirp

ta = 0.25;
f0 = 5;
f1 = 20;
phi0 = 0;
L = 0.5;

transientSignal = transientchirpf(dataX,snr,ta,f0,f1,phi0,L);

figure;
plot(dataX,transientSignal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Linear Transient Chirp');
grid on;