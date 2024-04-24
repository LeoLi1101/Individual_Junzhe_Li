% Sample rate and signal length
Fs = 1 / mean(diff(GatDriveTest.time)); % Assuming uniform time intervals
L = length(GatDriveTest.Vmiddle);

% Compute the FFT
Y = fft(GatDriveTest.Vmiddle);

% Compute the two-sided spectrum and then convert to a single-sided spectrum
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

% Define the frequency domain f
f = Fs*(0:(L/2))/L;

% Plotting the single-sided amplitude spectrum
figure;
plot(f, P1);
title('Single-Sided Amplitude Spectrum of Vmiddle');
xlabel('Frequency (Hz)');
ylabel('|P1(f)|');

