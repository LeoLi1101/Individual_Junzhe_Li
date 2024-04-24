% Create a new figure window
figure;
% Subplot for the high side voltage
subplot(2, 1, 1); % This divides the figure into 2 rows, 2 columns, and selects the 1st subplot
plot(GateDriveComparsion.time, GateDriveComparsion.Vhighside, 'b'); % Plotting the high side signal in blue
title('High Side Voltage Waveform');
xlabel('Time (s)');
ylabel('Voltage (V)');
yticks(0:2:25);
legend('High Side');


% Subplot for the low side voltage
subplot(2, 1, 2); % Selects the 2nd subplot
plot(GateDriveComparsion.time, GateDriveComparsion.Vlowside, 'r'); % Plotting the low side signal in red
title('Low Side Voltage Waveform');
xlabel('Time (s)');
ylabel('Voltage (V)');
yticks(0:1:25);
legend('Low Side');

figure;
% Subplot for the gate-source voltage difference
subplot(2, 1, 1); % Selects the 3rd subplot
plot(GateDriveComparsion.time, GateDriveComparsion.VhighsideVout, 'g'); % Plotting the gate-source voltage difference in green
title('Gate Source Voltage Difference Waveform');
xlabel('Time (s)');
ylabel('Voltage (V)');
yticks(0:1:25);
legend('Gate-Source Voltage Difference');

% Subplot for the output voltage
subplot(2, 1, 2); % Selects the 4th subplot
plot(GateDriveComparsion.time, GateDriveComparsion.Vout, 'm'); % Plotting the output voltage in magenta
title('Output Voltage Waveform');
xlabel('Time (s)');
ylabel('Voltage (V)');
yticks(0:1:25);
legend('Output Voltage');





