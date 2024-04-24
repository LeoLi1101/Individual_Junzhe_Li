% Plot a figure containing two spectra

% __________ Figure 1 plot parameters_______________________

x_Color = 'black';

y1_Color = 'black';
y2_Color = 'red';
y3_Color = [91, 155, 213] / 255;


sp1_y1_Range2 = [0,14];
sp1_y1_inc2 = 2;

sp2_y1_Range2 = [0.01,30];

f_Range = [0,6*fs];
f_inc   = fs;

PlotSpacing2 = 0.1;
PlotHeight2 = 0.36;
PlotWidth2 = 0.50;
PlotOrigin2 = [0.1,0.1];

Font_size = 16;
Font_type = 'Arial';

%fft fot half
% Compute some numbers we'll need for scaling, frequency vector creation etc.
recordLength_half = length(out_half.IL.signals.values(:,1));
sampleRate_half = 1/(out_half.IL.time(2)-(out_half.IL.time(1)));
fftLength_half = uint32((recordLength_half/2)+1);
freqRes_half = sampleRate_half/recordLength_half;
f0_half = V_control_frequency/(2*pi);
f0_idx_half = uint32((f0_half/freqRes_half)+1);

% Generate windowing vector (improves dynamic range of FFT)
% w = window(@hamming,recordLength_half);
w_half = window(@rectwin,recordLength_half);

% Compute window gain to correct amplitudes
windowGain_half = (sum(w_half))/recordLength_half;

% Compute DFT of current waveform using FFT.
Ia_fft_half = fft(w_half.*out_half.IL.signals.values(:,1));
% Non-windowed for time domain output via IFFT
Ia_fft_nonwin_half = fft(out_half.IL.signals.values(:,1));
% Compute one-sided magnitude spectrum of current waveform from DFT
Ia_mag_spec_half = (2/(windowGain_half*length(Ia_fft_half)))*(abs(Ia_fft_half(1:fftLength_half)));
% Generate freqency vector
f_v_half = single(sampleRate_half/2*linspace(0,1,fftLength_half));

% Suppress DC and fundamental terms in DFT (at both ends)
Ia_fft_mod_half = Ia_fft_nonwin_half;
Ia_fft_mod_half(1) = 0.1;
Ia_fft_mod_half(f0_idx_half) = 0.1;
Ia_fft_mod_half(length(Ia_fft_mod_half)-(f0_idx_half-2))=0.1;

% Compute inverse FFT of modified DFT
Ia_mod_half = ifft(Ia_fft_mod_half);


%FFT for _npc
% Compute some numbers we'll need for scaling, frequency vector creation etc.
recordLength_npc = length(out_npc.IL.signals.values(:,1));
sampleRate_npc = 1/(out_npc.IL.time(2)-(out_npc.IL.time(1)));
fftLength_npc = uint32((recordLength_npc/2)+1);
freqRes_npc = sampleRate_npc/recordLength_npc;
f0_npc = V_control_frequency/(2*pi);
f0_idx_npc = uint32((f0_npc/freqRes_npc)+1);

% Generate windowing vector (improves dynamic range of FFT)
% w = window(@hamming,recordLength);
w_npc = window(@rectwin,recordLength_npc);

% Compute window gain to correct amplitudes
windowGain_npc = (sum(w_npc))/recordLength_npc;

% Compute DFT of current waveform using FFT.
Ia_fft_npc = fft(w_npc.*out_npc.IL.signals.values(:,1));
% Non-windowed for time domain output via IFFT
Ia_fft_nonwin_npc = fft(out_npc.IL.signals.values(:,1));
% Compute one-sided magnitude spectrum of current waveform from DFT
Ia_mag_spec_npc = (2/(windowGain_npc*length(Ia_fft_npc)))*(abs(Ia_fft_npc(1:fftLength_npc)));
% Generate freqency vector
f_v_npc = single(sampleRate_npc/2*linspace(0,1,fftLength_npc));

% Suppress DC and fundamental terms in DFT (at both ends)
Ia_fft_mod_npc = Ia_fft_nonwin_npc;
Ia_fft_mod_npc(1) = 0.1;
Ia_fft_mod_npc(f0_idx_npc) = 0.1;
Ia_fft_mod_npc(length(Ia_fft_mod_npc)-(f0_idx_npc-2))=0.1;

% Compute inverse FFT of modified DFT
Ia_mod_npc = ifft(Ia_fft_mod_npc);




% ___________Define and format figure2 and its axes_____________________
figure2 = figure('Color',[1 1 1], 'OuterPosition',[10, 10, 1200, 1000]);

% Sub-plot 1
subplot2_1 = axes('Position',[PlotOrigin2(1), PlotOrigin2(2) + 1 * (PlotHeight2 + PlotSpacing2), PlotWidth2, PlotHeight2],...
                  'YColor', y1_Color, 'XTick', f_Range(1):f_inc:f_Range(2), 'YTick', sp1_y1_Range2(1):sp1_y1_inc2:sp1_y1_Range2(2),...
                  'FontSize', Font_size, 'FontName', Font_type);
xlabel(subplot2_1, 'Frequency (Hz)', 'FontSize', Font_size, 'FontName', Font_type);
ylabel(subplot2_1, 'Current magnitude (A)', 'FontSize', Font_size, 'FontName', Font_type);
axis(subplot2_1, [0 f_Range(2) sp1_y1_Range2(1) sp1_y1_Range2(2)]);
box(subplot2_1, 'on');
grid(subplot2_1, 'on');
hold(subplot2_1, 'on');

% Plotting for subplot 1
%plot(f_v_half, Ia_mag_spec_half, 'Color', y3_Color, 'LineWidth', 1, 'DisplayName', 'Bridge Leg', 'Parent', subplot2_1);
plot(f_v_npc, Ia_mag_spec_npc, 'Color', y2_Color, 'LineWidth', 1, 'DisplayName', 'NPC', 'Parent', subplot2_1);

% Add legend to subplot 1
legend(subplot2_1, 'show');

% Sub-plot 2
subplot2_2 = axes('Position',[PlotOrigin2(1), PlotOrigin2(2) + 0 * (PlotHeight2 + PlotSpacing2), PlotWidth2, PlotHeight2],...
                  'YColor', y1_Color, 'XTick', f_Range(1):f_inc:f_Range(2), 'YScale', 'log', 'FontSize', Font_size, 'FontName', Font_type);
xlabel(subplot2_2, 'Frequency (Hz)', 'FontSize', Font_size, 'FontName', Font_type);
ylabel(subplot2_2, 'Current magnitude (A)', 'FontSize', Font_size, 'FontName', Font_type);
axis(subplot2_2, [0 f_Range(2) sp2_y1_Range2(1) sp2_y1_Range2(2)]);
box(subplot2_2, 'on');
grid(subplot2_2, 'on');
hold(subplot2_2, 'on');

% Plotting for subplot 2
%plot(f_v_half, Ia_mag_spec_half, 'Color', y3_Color, 'LineWidth', 1, 'DisplayName', 'Bridge Leg(Log Scale)', 'Parent', subplot2_2);
plot(f_v_npc, Ia_mag_spec_npc, 'Color', y2_Color, 'LineWidth', 1, 'DisplayName', 'NPC (Log Scale)', 'Parent', subplot2_2);

% Add legend to subplot 2
legend(subplot2_2, 'show');
