%% Lab 1_2 — Nyquist sampling

addpath('../Lab1-1/functions');

% {name, function, estimated maximum frequency}
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

rateFactors = [1, 2, 10];
rateNames = {'Nyquist', 'Twice Nyquist', '10x Nyquist'};

for i = 1:size(signals,1)

    signalName = signals{i,1};
    signalFunction = signals{i,2};
    maxFreq = signals{i,3};

    figure('Name',[signalName ' — Nyquist Sampling']);
    tiledlayout(3,2);

    for j = 1:length(rateFactors)

        % Sampling rate
        samplFreq = rateFactors(j)*2*maxFreq;
        dt = 1/samplFreq;

        % One-second record, excluding the repeated endpoint
        nSamples = round(samplFreq*1.0);
        timeVec = (0:nSamples-1)/samplFreq;

        % Zero-phase sine and sine-Gaussian vanish at Nyquist.
        % Avoid normalizing their numerical roundoff.
        zeroAtNyquist = (j == 1) && (i == 1 || i == 5);

        if zeroAtNyquist
            sigVec = zeros(size(timeVec));
        else
            sigVec = signalFunction(timeVec);
        end

        % FFT magnitude, normalized by sample count
        fftSig = fft(sigVec);
        kNyq = floor(nSamples/2)+1;
        posFreq = (0:kNyq-1)*(samplFreq/nSamples);
        fftMagnitude = abs(fftSig(1:kNyq))/nSamples;

        % Time domain
        nexttile;
        plot(timeVec,sigVec,'.-','MarkerSize',10);
        xlabel('Time (sec)');
        ylabel('Amplitude');
        title(sprintf('%s: fs = %g Hz', ...
            rateNames{j},samplFreq));
        grid on;

        % Fourier domain
        nexttile;
        plot(posFreq,fftMagnitude,'.-');
        xlabel('Frequency (Hz)');
        ylabel('|FFT| / N');
        title([rateNames{j} ' — FFT']);
        grid on;

    end

    sgtitle(signalName);

end