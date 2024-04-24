figure;
time_pin9 = PIN09{:, 1}; % Extract the first column for the x-axis (time)
voltage_pin9 = PIN09{:, 2}; % Extract the second column for the y-axis (voltage)

time_pin10 = PIN10{:, 1}; % Extract the first column for the x-axis (time)
voltage_pin10 = PIN10{:, 2}; % Extract the second column for the y-axis (voltage)

% Index for starting the plot from element 65475 to the end
start_index = 65475;

% Verify if the start index is within the array length
if start_index <= length(time_pin9)
    % pin 9
    subplot(2, 1, 1); % This divides the figure into 2 rows, 1 column, and selects the 1st subplot
    plot(time_pin9(start_index:end), voltage_pin9(start_index:end), 'b'); % Plotting the high side signal in blue from index 65475 to the end
    title('High Side Voltage Waveform');
    xlabel('Time (s)');
    ylabel('VHighside (V)');
    legend('High Side Voltage');
    set(gca, 'FontSize', 18);
else
    disp('Start index exceeds array length for PIN09.');
end

% Verify if the start index is within the array length
if start_index <= length(time_pin10)
    % pin 10
    subplot(2, 1, 2); % Selects the 2nd subplot
    plot(time_pin10(start_index:end), voltage_pin10(start_index:end), 'r'); % Plotting the low side signal in red from index 65475 to the end
    title('Low Side Voltage Waveform');
    xlabel('Time (s)');
    ylabel('Low side Voltage (V)');
    legend('Low Side Voltage');
    set(gca, 'FontSize', 18);
else
    disp('Start index exceeds array length for PIN10.');
end
%%

figure;
 
time_Out =SPWM03{:, 1}; % Extract the first column for the x-axis (time)
voltage_Out = SPWM03{:, 2}; % Extract the second column for the y-axis (voltage)


% Initialize the adjusted voltage array
adjusted_time_Out = zeros(size(time_Out)); % Preallocate for efficiency

% Loop through each element in the voltage array and add 0.0796
for i = 1:length(time_Out)
    adjusted_time_Out(i) = time_Out(i) + 0.0796;
end

plot(adjusted_time_Out, voltage_Out, 'm'); % Plotting the output voltage in magenta
title('Output Voltage Waveform');
xlabel('Time (s)');
ylabel('Vout (V)');
legend('Output Voltage');
yticks(0:1:10);
grid on;
set(gca, 'FontSize', 18);

