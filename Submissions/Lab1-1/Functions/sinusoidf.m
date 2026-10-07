function sigVec = sinusoidf(dataX,snr,f0,phi0)
% Generate a sinusoidal signal
% S = CRCBGENSINSIG(X,SNR,F0,PHI0)
% Generates a sinusoidal signal S. X is the vector of time stamps.
% SNR determines the norm of the signal. F0 is the frequency in Hz
% and PHI0 is the initial phase.
%
% Armando Villarreal, September 2026

sigVec = sin(2*pi*f0*dataX + phi0);

% Normalize signal to specified SNR
sigVec = snr*sigVec/norm(sigVec);

end