
% Assuming the first column is time and the second column is the signal amplitude
time_Low = HIGHIN01{:, 1}*1000;
signal_Low = HIGHIN01{:, 2};

time_High = LOWIN01{:, 1}*1000;
signal_High = LOWIN01{:, 2};

time_Output = OUTPUT{:, 1}*1000;
signal_Output = OUTPUT{:, 2};

% Create the plot
figure;
subplot(2, 1, 1);
plot(time_High, signal_High, 'r');
title('High side Input');
xlabel('Time(ms)');
ylabel('VHiside(V)');
legend('HIGH Side','FontSize',18);
yticks(0:4:26);
set(gca, 'FontSize', 15);


% Display the plot
grid on;

% Create the plot
subplot(2, 1, 2);
plot(time_Low, signal_Low, 'g');
title('Low side Input');
xlabel('Time(ms)');
ylabel('VLow(V)');
legend('LOW Side','FontSize',18);
set(gca, 'FontSize', 15);
yticks(0:4:26);
% Display the plot
grid on;

% Create the plot
figure;
plot(time_Output, signal_Output, 'b');
title('Output');
xlabel('Time(ms)');
ylabel('VOutput(V)');
legend('OUTPUT','FontSize',18);
set(gca, 'FontSize', 15);
yticks(0:2:26);
% Display the plot
grid on;


