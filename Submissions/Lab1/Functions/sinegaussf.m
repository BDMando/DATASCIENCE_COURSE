function sigVec = sinegaussf(dataX,snr,t0,sigma,f0,phi0)
% Generate a sine-Gaussian signal
% S = CRCBGENSGSG(X,SNR,T0,SIGMA,F0,PHI0)
% Generates a sine-Gaussian signal S. X is the vector of time stamps.
% SNR determines the norm of the signal. T0 is the center time,
% SIGMA controls the Gaussian width, F0 is the sinusoidal frequency,
% and PHI0 is the initial phase.
%
% Armando Villarreal, September 2026

gaussianEnvelope = exp(-(dataX-t0).^2/(2*sigma^2));

sigVec = gaussianEnvelope .* sin(2*pi*f0*dataX + phi0);

% Normalize signal to specified SNR
sigVec = snr*sigVec/norm(sigVec);

end