%% Lab 1_1 — All seven signals
% Keep the signal functions in their separate function files.

addpath('../functions');

% Each row contains:
% {signal name, signal function, estimated maximum frequency}
% The second function argument sets the signal norm (snr = 10).

signals = {
    'Sinusoidal', ...
    @(t) sinusoidf(t,10,10,0), ...
    10;

    'Linear Chirp', ...
    @(t) linearchirpf(t,10,10,10,0), ...
    10+10;

    'AM Sinusoid', ...
    @(t) AMf(t,10,20,2,0), ...
    20+2;

    'FM Sinusoid', ...
    @(t) FMf(t,10,2,20,2), ...
    20+2*2;

    'Sine-Gaussian', ...
    @(t) sinegaussf(t,10,0.5,0.1,20,0), ...
    20;

    'Linear Transient Chirp', ...
    @(t) transientchirpf(t,10,0.25,10,10,0,0.5), ...
    10+2*10*0.5;

    'AM-FM Sinusoid', ...
    @(t) AMFMf(t,10,2,20,2), ...
    20+2*2
};

%% Generate and plot each signal

for i = 1:size(signals,1)

    % Select signal
    signalName = signals{i,1};
    signalFunction = signals{i,2};
    maxFreq = signals{i,3};

    % Sampling parameters
    nyqFreq = 2*maxFreq;
    samplFreq = 5*nyqFreq;
    samplIntrvl = 1/samplFreq;

    % Time samples
    timeVec = 0:samplIntrvl:1.0;
    nSamples = length(timeVec);

    % Generate signal
    sigVec = signalFunction(timeVec);

    % Calculate FFT
    kNyq = floor(nSamples/2)+1;
    posFreq = (0:kNyq-1)*(samplFreq/nSamples);

    fftSig = fft(sigVec);
    fftSig = fftSig(1:kNyq);

    % One figure per signal with two plots
    figure('Name',signalName);
    tiledlayout(1,2);

    % Time domain — left
    nexttile;
    plot(timeVec,sigVec,'.-','MarkerSize',10);
    xlabel('Time (sec)');
    ylabel('Amplitude');
    title('Time Domain');
    grid on;

    % Fourier domain — right
    nexttile;
    plot(posFreq,abs(fftSig));
    xlabel('Frequency (Hz)');
    ylabel('|FFT|');
    title('FFT Magnitude');
    grid on;

    % Overall figure title
    sgtitle(signalName);

end