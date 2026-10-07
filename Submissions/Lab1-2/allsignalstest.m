%% Lab 1_2 — Time, FFT, and spectrogram plots

addpath('../Lab1-1/functions');

% {signal name, signal function, estimated maximum frequency}
% The value 10 passed to each function sets the signal norm.

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

%% Generate and plot each signal

for i = 1:size(signals,1)

    signalName = signals{i,1};
    signalFunction = signals{i,2};
    maxFreq = signals{i,3};

    %% Sampling
    % Use 10 times the estimated Nyquist rate.

    samplFreq = 10*2*maxFreq;
    nSamples = round(samplFreq*1.0);
    timeVec = (0:nSamples-1)/samplFreq;

    sigVec = signalFunction(timeVec);

    %% FFT

    fftSig = fft(sigVec);

    kNyq = floor(nSamples/2)+1;
    posFreq = (0:kNyq-1)*(samplFreq/nSamples);
    fftMagnitude = abs(fftSig(1:kNyq))/nSamples;

    %% Spectrogram
    % Approximately 0.25-second Hann window, 90% overlap.

    windowLength = round(0.25*samplFreq);
    windowVec = hann(windowLength);
    overlapLength = floor(0.90*windowLength);

    % Zero padding refines the frequency grid;
    % actual resolution is set by the window duration.
    nFFT = max(1024,2^nextpow2(windowLength));

    [~,freqVec,specTime,powerDensity] = spectrogram( ...
        sigVec,windowVec,overlapLength,nFFT,samplFreq);

    powerDB = 10*log10(max(powerDensity,realmin));

    %% Plot layout
    % Time and FFT above; spectrogram spans the bottom row.

    figure('Name',signalName);
    tiledlayout(2,2,'TileSpacing','compact','Padding','compact');

    % Time domain
    nexttile;
    plot(timeVec,sigVec,'.-','MarkerSize',6);
    xlabel('Time (sec)');
    ylabel('Amplitude');
    title('Time Domain');
    xlim([0 1]);
    grid on;

    % FFT magnitude
    nexttile;
    plot(posFreq,fftMagnitude);
    xlabel('Frequency (Hz)');
    ylabel('|FFT| / N');
    title('FFT Magnitude');
    xlim([0 40]);
    grid on;

    % Spectrogram spanning two columns
    nexttile([1 2]);
    imagesc(specTime,freqVec,powerDB);
    axis xy;
    xlabel('Time (sec)');
    ylabel('Frequency (Hz)');
    title('Spectrogram');
    xlim([0 1]);
    ylim([0 40]);

    peakPowerDB = max(powerDB(:));
    clim([peakPowerDB-60 peakPowerDB]);

    cb = colorbar;
    cb.Label.String = 'PSD (dB/Hz)';

    sgtitle(sprintf('%s — Sampling Rate: %g Hz', ...
        signalName,samplFreq));

end