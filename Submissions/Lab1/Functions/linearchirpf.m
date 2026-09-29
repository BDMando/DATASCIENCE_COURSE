function sigVec = linearchirpf(dataX,snr,f0,f1,phi0)
% Generate a linear chirp signal
% S = CRCBGENLCSIG(X,SNR,F0,F1,PHI0)
% Generates a linear chirp signal S. X is the vector of time stamps.
% SNR determines the norm of the signal. F0 and F1 control the
% frequency evolution and PHI0 is the initial phase.
%
% Armando Villarreal, September 2026

phaseVec = f0*dataX + 0.5*f1*dataX.^2 + phi0;

sigVec = sin(2*pi*phaseVec);

% Normalize signal to specified SNR
sigVec = snr*sigVec/norm(sigVec);

end