function sigVec = AMFMf(dataX,snr,b,f0,f1)
% Generate an amplitude- and frequency-modulated sinusoidal signal
% S = CRCBGENAMFMSIG(X,SNR,B,F0,F1)
% Generates an AM-FM sinusoid S. X is the vector of time stamps.
% SNR determines the norm of the signal. F0 is the carrier frequency,
% F1 is the modulation frequency, and B is the FM parameter.
%
% Armando Villarreal, September 2026

amplitudeEnvelope = cos(2*pi*f1*dataX);

phaseVec = 2*pi*f0*dataX + b*cos(2*pi*f1*dataX);

sigVec = amplitudeEnvelope .* sin(phaseVec);

% Normalize signal to specified SNR
sigVec = snr*sigVec/norm(sigVec);

end