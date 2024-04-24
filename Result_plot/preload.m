% Pre-load circuit parameters into workspace
% ___________________________________________________________________

% 1_____ Simulation parameters _1____
SampleTime = 10e-8;         % E.g. oringinal 10e-6
                            % For a switching period of 50us (fs=20kHz),  
                            % a sampling period of 100ns (fs=10MHz) is enough to
							% resolve the fastest events (e.g. the triangle). 
                            % For 1kHz switching / 1000us period, a sampling
							% period of 10us is ok.


% 2______ Grid parameters ______
V_grid_amplitude = sqrt(2)*240;         % [V]
V_grid_frequency = 2*pi*50;             % [rad/sec]


% 3______ Inverter control parameters ______ 

% DC link
Vdc = 752;  % provides enough headrooom for grid voltage tolerance,
            % inductor loss, device forward voltage drops, etc.

% Triangle signal for pulse width modulation
%mf = 401;                 % Switching above audible frequency range,
                            % requires use of realistic filter inductance
mf = 51;                    % oringinal 21
fs = 50*mf;                 % Switching frequency [Hz]

Sequence_frequency = fs;    %             
Sequence_amplitude = 1;     %  oringinal 1

% Control signal for pulse width modulation
ma = 0.85;                               %original 0.85
V_control_phase = 12*(2*pi/360);          % [Rads]  Angle between grid voltage and inverter reference
V_control_amplitude = ma;
V_control_frequency = V_grid_frequency;


% 4______ Inverter component parameters ______ 

% Ideal Switches
Cs = inf;                             
Rs = 1e5;
Ron = 0.1;

% Filter
L_load  = 10e-3;          % Use 1-2 mH for 20 kHz switching oringinal 10mH


R_load = 1e-3;



%5__________Calculations__________________________





% Calculation of initial current conditions in inductors

V_out = [Vdc/2]*V_control_amplitude*exp(1i*V_control_phase);% Create V_control phasor
V_grid= V_grid_amplitude;                               % Create V_grid phasor (which is real)
V_L   = V_out - V_grid;                                 % Complex
I_L   = V_L / (1i * V_grid_frequency * L_load + R_load);

I_out = abs(I_L)*cos(angle(I_L));                 % Convert phasor I_L to cos function and set t=0



% 6______ Parameters for disconnected blocks ______ 
Cf  =4e-6;