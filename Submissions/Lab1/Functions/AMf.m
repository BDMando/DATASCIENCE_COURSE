function sigVec = AMf(dataX,snr,f0,f1,phi0)
% Generate an amplitude-modulated sinusoidal signal
% S = CRCBGENAMSIG(X,SNR,F0,F1,PHI0)
% Generates an AM sinusoid S. X is the vector of time stamps.
% SNR determines the norm of the signal. F0 is the carrier frequency,
% F1 is the modulation frequency, and PHI0 is the initial phase.
%
% Armando Villarreal, September 2026

amplitudeEnvelope = cos(2*pi*f1*dataX);

sigVec = amplitudeEnvelope .* sin(2*pi*f0*dataX + phi0);

% Normalize signal to specified SNR
sigVec = snr*sigVec/norm(sigVec);

end