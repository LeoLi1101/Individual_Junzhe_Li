% Assuming GatDriveTest is a table with 'time' and 'Vmiddle' variables

% Define the time limit
timeLimit = 0.2;

% Plot the original signal
figure; % Creates a new figure window
% Find the index where the time reaches 0.1 seconds
timeIndexLimit = find(GatDriveTest.time <= timeLimit, 1, 'last');

yyaxis left; % Setting the left y-axis for Vmiddle
plot(GatDriveTest.time, GatDriveTest.Vmiddle,'LineWidth',2.5);
ylabel('VOut');
xlabel('Time (s)');
title('Op-amp based Bridge Leg Output');
%yticks(-2:2:12);


hold on; % Keep the current plot while adding the next one

% Plotting Vv
yyaxis right; % Setting the right y-axis for Vv
plot(GatDriveTest.time, GatDriveTest.Vvreference, '--','LineWidth',1.5);
ylabel('V Reference');

legend('V Out', 'V Reference', 'FontSize', 18);
grid on;
set(gca, 'FontSize', 15);


% Sample rate and signal length
Fs = 1 / mean(diff(GatDriveTest.time)); % Using the entire time range for interval calculation
L = numel(GatDriveTest.time); % Total number of samples

% Compute the FFT for the entire signal
Y = fft(GatDriveTest.Vmiddle);

% Compute the two-sided spectrum and then convert to a single-sided spectrum
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

% Define the frequency domain f
f = Fs*(0:(L/2))/L;

% Find the index where the frequency reaches 3 kHz
fmax = 3000; % Maximum frequency in Hz
maxIndex = find(f >= fmax, 1, 'first'); % Find the first index with frequency >= 3 kHz

% Plotting the single-sided amplitude spectrum in a new figure
figure; % Creates another new figure window
plot(f(1:maxIndex), P1(1:maxIndex),'LineWidth',1.5); % Limit the plot to 0 - 3 kHz
hold on;

% Plotting the point at x-axis value of 20 (Fundamental frequency)
fundamental_freq = 20;
fundamental_index = find(f >= fundamental_freq, 1, 'first');
plot(f(fundamental_index), P1(fundamental_index), 'ro', 'MarkerSize', 10); % Plotting the point
text(f(fundamental_index), P1(fundamental_index), 'f1 20 Hz', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 12); % Labeling the point

% Plotting another point at x-axis value of 200 (Switching frequency)
switching_freq = 200;
switching_index = find(f >= switching_freq, 1, 'first');
plot(f(switching_index), P1(switching_index), 'ro', 'MarkerSize', 10); % Plotting the point
text(f(switching_index), P1(switching_index), 'fs 200 Hz', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 12); % Labeling the point

title('Opamp based Bridge Leg output frequency spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
legend('Frequency Response', 'FontSize', 18);
grid on;
set(gca, 'FontSize', 15);
