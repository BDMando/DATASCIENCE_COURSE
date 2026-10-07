%% Lab 1_2 — Spectrograms of all seven signals

addpath('../Lab1-1/functions');

% {signal name, signal function, estimated maximum frequency}
signals = {
    'Sinusoidal', ...
    @(t) sinusoidf(t,10,10,0), 10;

    'Linear Chirp', ...
    @(t) linearchirpf(t,10,10,10,0), 20;

    'AM Sinusoid', ...
    @(t) AMf(t,10,20,2,0), 22;

    'FM Sinusoid', ...
    @(t) FMf(t,10,2,20,2), 24;

    'Sine-Gaussian', ...
    @(t) sinegaussf(t,10,0.5,0.1,20,0), 20;

    'Linear Transient Chirp', ...
    @(t) transientchirpf(t,10,0.25,10,10,0,0.5), 20;

    'AM-FM Sinusoid', ...
    @(t) AMFMf(t,10,2,20,2), 24
    };

%% Generate signals and spectrograms

for i = 1:size(signals,1)

    signalName = signals{i,1};
    signalFunction = signals{i,2};
    maxFreq = signals{i,3};

    % Use 10 times the estimated Nyquist rate
    samplFreq = 10*2*maxFreq;

    % One-second recording
    nSamples = round(samplFreq);
    timeVec = (0:nSamples-1)/samplFreq;

    sigVec = signalFunction(timeVec);

    % Spectrogram settings
    % Window duration: approximately 0.25 seconds
    windowLength = round(0.25*samplFreq);
    windowVec = hann(windowLength);

    % Overlap adjacent windows by approximately 90%
    overlapLength = floor(0.90*windowLength);

    % Zero padding gives a denser frequency grid
    nFFT = max(1024,2^nextpow2(windowLength));

    % Calculate the power spectral density
    [~,freqVec,specTime,powerDensity] = spectrogram( ...
        sigVec,windowVec,overlapLength,nFFT,samplFreq);

    % Convert power to dB
    powerDB = 10*log10(max(powerDensity,realmin));

    % One figure: time signal above, spectrogram below
    figure('Name',[signalName ' — Spectrogram']);
    tiledlayout(2,1);

    nexttile;
    plot(timeVec,sigVec);
    xlabel('Time (sec)');
    ylabel('Amplitude');
    title('Time Domain');
    xlim([0 1]);
    grid on;

    nexttile;
    imagesc(specTime,freqVec,powerDB);
    axis xy;
    xlabel('Time (sec)');
    ylabel('Frequency (Hz)');
    title('Spectrogram');
    xlim([0 1]);
    ylim([0 40]);

    % Display the strongest 60 dB within each signal
    peakPowerDB = max(powerDB(:));
    clim([peakPowerDB-60 peakPowerDB]);

    cb = colorbar;
    cb.Label.String = 'PSD (dB/Hz)';

    sgtitle(signalName);

end