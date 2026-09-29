function sigVec = transientchirpf(dataX,snr,ta,f0,f1,phi0,L)
% Generate a linear transient chirp signal
% S = CRCBGENLTCSIG(X,SNR,TA,F0,F1,PHI0,L)
% Generates a transient linear chirp S. The signal is zero outside
% the interval [TA, TA+L]. SNR determines the norm of the signal.
% F0 and F1 control the chirp, PHI0 is the initial phase, and
% L is the duration of the transient.
%
% Armando Villarreal, September 2026

% Start with a signal containing only zeros
sigVec = zeros(size(dataX));

% Find samples inside the transient interval
validSamples = (dataX >= ta) & (dataX <= ta + L);

% Time measured from beginning of transient
transientTime = dataX(validSamples) - ta;

% Calculate phase inside transient interval
phaseVec = f0*transientTime + ...
           f1*transientTime.^2 + phi0;

% Generate chirp only inside transient interval
sigVec(validSamples) = sin(2*pi*phaseVec);

% Normalize signal to specified SNR
sigVec = snr*sigVec/norm(sigVec);

end