function sigVec = FMf(dataX,snr,b,f0,f1)
% Generate a frequency-modulated sinusoidal signal
% S = CRCBGENFMSIG(X,SNR,B,F0,F1)
% Generates an FM sinusoid S. X is the vector of time stamps.
% SNR determines the norm of the signal. F0 is the carrier frequency,
% F1 is the modulation frequency, and B is the modulation parameter.
%
% Armando Villarreal, September 2026

phaseVec = 2*pi*f0*dataX + b*cos(2*pi*f1*dataX);

sigVec = sin(phaseVec);

% Normalize signal to specified SNR
sigVec = snr*sigVec/norm(sigVec);

end