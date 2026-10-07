%% Lab 1_2 — Filtering three sinusoids
% For fs = 1024 Hz, the Nyquist frequency is fs/2 = 512 Hz.
% Sinusoids below 512 Hz can be sampled without aliasing.
% Exactly 512 Hz is phase-dependent

addpath('../Lab1-1/functions');

%% Generate the input signal

nSamples = 2048;
samplFreq = 1024;
timeVec = (0:nSamples-1)/samplFreq;

% sinusoidf normalizes its output.
% Rescale each sinusoid to the required physical amplitude.

sig1 = sinusoidf(timeVec,10*sqrt(nSamples/2),100,0);
sig2 = sinusoidf(timeVec,5*sqrt(nSamples/2),200,pi/6);
sig3 = sinusoidf(timeVec,2.5*sqrt(nSamples/2),300,pi/4);

inputSig = sig1 + sig2 + sig3;

%% Design filters
% fir1 frequencies are normalized by fs/2 = 512 Hz.

filterOrder = 100;
nyquistFreq = samplFreq/2;

% Lowpass: isolate 100 Hz
bLow = fir1(filterOrder,150/nyquistFreq,'low');

% Bandpass: isolate 200 Hz
bBand = fir1(filterOrder,[150 250]/nyquistFreq,'bandpass');

% Highpass: isolate 300 Hz
bHigh = fir1(filterOrder,250/nyquistFreq,'high');

%% Apply filters

outputLow = filter(bLow,1,inputSig);
outputBand = filter(bBand,1,inputSig);
outputHigh = filter(bHigh,1,inputSig);

%% Plot input and output periodograms
% Exclude startup samples from all signals for a fair comparison.

validSamples = filterOrder+1:nSamples;

plotSignals = {
    inputSig,   'Input: 100 + 200 + 300 Hz';
    outputLow,  'Lowpass Output: 100 Hz';
    outputBand, 'Bandpass Output: 200 Hz';
    outputHigh, 'Highpass Output: 300 Hz'
    };

figure('Name','Filtering — Periodograms');
tiledlayout(2,2);

for i = 1:size(plotSignals,1)

    signal = plotSignals{i,1};

    [powerDensity,freqVec] = periodogram( ...
        signal(validSamples),[],nSamples,samplFreq);

    nexttile;
    plot(freqVec,10*log10(max(powerDensity,realmin)));
    xlabel('Frequency (Hz)');
    ylabel('PSD (dB/Hz)');
    title(plotSignals{i,2});
    xlim([0 nyquistFreq]);
    grid on;

end

sgtitle('Input and Filtered Output Periodograms');