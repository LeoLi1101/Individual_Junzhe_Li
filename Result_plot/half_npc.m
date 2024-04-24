% Plot four sets of waveforms, including a double y-axis plot

% __________Plot parameters_______________________

x_RangeScaler = 1000;                                                       % E.g. set to 1000 for a millisecond scale...

PlotStartTime    = 0.0;             % Set start time to 2.0 to check Q1     % ...and set these times in milliseconds.
PlotTimeInterval = 20;              % Set time interval to 4.0 to check Q1
x_IntervalNumber = 20;                                                      % X-axis scale intervals
x_Range = [PlotStartTime,PlotStartTime+PlotTimeInterval];                   % x-interval of times series vector that is plotted
x_RangeOffset = x_Range(1);                                                 % Plots start at 0s no matter what interval is chosen

skybule = [91, 155, 213] / 255;
x_Color = 'black';

y1_Color = 'black';
y2_Color = 'red';
y3_Color = skybule;




sp1_y1_Range = [-1.0,1.0];
sp1_y1_inc = 0.5;

sp2_y1_Range = [-1.0,1.0];
sp2_y1_inc = 0.5;

sp3_y1_Range = [-400,400];
sp3_y1_inc = 200;


sp4_y1_Range = [-30,30];
sp4_y1_inc = 10;

sp4_y2_Range = [-600,600];
sp4_y2_inc = 200;


Font_size = 10;
Font_type = 'Arial';
PlotSpacing = 0.05; %0.05
PlotHeight = 0.18; %0.18
PlotWidth = 0.3;  %0.80 %0.55
PlotOrigin = [0.1,0.1]; %-0.3

% __________Derived parameters_______________________
x_inc = (x_Range(2)-x_Range(1))/x_IntervalNumber;                           % x-scale increment
x_max = x_Range(2)-x_Range(1);                                              % x-scale max

% ___________Define and format figure1 and its axes_____________________
% figure1 = figure('Color',[1 1 1],...                                      % Colour of frame
%                 'OuterPosition',[1300,-50,1200,1200]);                    % left, bottom, width, height, in pixels
figure1 = figure('Color',[1 1 1],...                     
    'OuterPosition',[10,10,1200,1000]);                                     % Values for small screen
%[10,10,1200,1000]

% Sub-plot 1 _ control&reference signal half bridge
subplot1 = axes('position',[PlotOrigin(1),PlotOrigin(2)+3*(PlotHeight+PlotSpacing),... % Set position and size of the sub-plot
                            PlotWidth,PlotHeight],...                      % realitive to the figure. (0,0) is bottom left; (1,1) is top right
                'YColor',y1_Color,...                                      % Set y1 axis red. 
                'XTick',0:x_inc:x_max,...                    % Display specific gridlines along x-axis
                'YTick',sp1_y1_Range(1):sp1_y1_inc:sp1_y1_Range(2),...     % Display specific gridlines along y-axis
                'FontSize',Font_size,...
                'FontName',Font_type);


axis(subplot1,[ 0 x_max sp1_y1_Range(1) sp1_y1_Range(2) ])                 % Set x and y axis range (you cannot set x alone) 
box(subplot1,'on');
grid(subplot1,'on');
hold(subplot1,'all');


plot((out_half.V_control.time*x_RangeScaler-x_RangeOffset),out_half.V_control.signals.values(:,1),...
     'Color',y1_Color,...
     'LineWidth',2.5,...
     'LineStyle','-',...
     'Parent',subplot1)

plot((out_half.a_RefSig.time*x_RangeScaler-x_RangeOffset),out_half.a_RefSig.signals.values(:,2),...
     'Color',y3_Color,...
     'LineWidth',3,...
     'LineStyle','-',...
     'Parent',subplot1)



Label(1)={'Reference Signals (V)(Bridge Leg)'};
%Label(2)={' '};
% Label(3)={' '};
ylabel(subplot1,Label,'FontSize',Font_size,'FontName',Font_type);
clear Label;
% Legend(1)={'Reference','Color',y1_Color};
% Legend(2) = {'Carrier','Color',y3_Color};
Legend(3)={''};
textaxes=axes('position',get(subplot1,'Position'),...
              'visible','off');
axis([0 1 0 1]);
text(1.01,0.5,Legend,...
     'clipping','off',...
     'Parent',textaxes,...
     'FontSize',Font_size,...
     'FontName',Font_type);
clear Legend;


% Sub-plot 2 _ control&reference signal npc

subplot2 = axes('position',[PlotOrigin(1),PlotOrigin(2)+2*(PlotHeight+PlotSpacing),...
                            PlotWidth,PlotHeight],...
                'YColor',y1_Color,...                                                
                'XTick',0:x_inc:x_max,...                  
                'YTick',sp2_y1_Range(1):sp2_y1_inc:sp2_y1_Range(2),...   
                'FontSize',Font_size,...
                'FontName',Font_type);


axis(subplot2,[ 0 x_max sp2_y1_Range(1) sp2_y1_Range(2) ])               
box(subplot2,'on');
grid(subplot2,'on');
hold(subplot2,'all');

plot((out_npc.V_control.time*x_RangeScaler-x_RangeOffset),out_npc.V_control.signals.values(:,1),...
     'Color',y1_Color,...
     'LineWidth',2.5,...
     'LineStyle','-',...
     'Parent',subplot2)

plot((out_npc.a_RefSig.time*x_RangeScaler-x_RangeOffset),out_npc.a_RefSig.signals.values(:,2),...
     'Color',y3_Color,...
     'LineWidth',3,...
     'LineStyle','-',...
     'Parent',subplot2)

plot((out_npc.a_RefSig.time*x_RangeScaler-x_RangeOffset),out_npc.a_RefSig.signals.values(:,3),...
     'Color',y2_Color,...
     'LineWidth',3,...
     'LineStyle','-',...
     'Parent',subplot2)

Label(1)={'Reference Signals (V)(NPC)'};
%Label(2)={' '};
% Label(3)={' '};
ylabel(subplot2,Label,'FontSize',Font_size,'FontName',Font_type);
clear Label;
%Legend(1)={'\cdot-\cdot-\cdot V Control'};
%Legend(2)={'—— Carrier'};
% Legend(1)={'Reference','Color',y1_Color};
% Legend(2) = {'Upper Carrier','Color',y3_Color};
% Legend(3) = {'Lower Carrier','Color',y2_Color};
Legend(3)={''};
textaxes=axes('position',get(subplot2,'Position'),...
              'visible','off');
axis([0 1 0 1]);
text(1.01,0.5,Legend,...
     'clipping','off',...
     'Parent',textaxes,...
     'FontSize',Font_size,...
     'FontName',Font_type);
clear Legend;

% Sub-plot 3 output voltage_half
subplot3 = axes('position',[PlotOrigin(1),PlotOrigin(2)+1*(PlotHeight+PlotSpacing),...
                            PlotWidth,PlotHeight],...
                'YColor',y1_Color,...                                                
                'XTick',0:x_inc:x_max,...                  
                'YTick',sp3_y1_Range(1):sp3_y1_inc:sp3_y1_Range(2),...   
                'FontSize',Font_size,...
                'FontName',Font_type);

axis(subplot3,[ 0 x_max sp3_y1_Range(1) sp3_y1_Range(2) ])               
box(subplot3,'on');
grid(subplot3,'on');
hold(subplot3,'all');

area((out_half.Va_out.time*x_RangeScaler-x_RangeOffset),out_half.Va_out.signals.values(:,1),...
     'FaceColor',y3_Color,...                                               
     'EdgeColor',y1_Color,...
     'LineWidth',2,...
     'DisplayName', 'Output Voltage Bridge leg', ... % Add this line for legend
     'Parent',subplot3);
legend(subplot3, 'show'); % Add this line to show legend
hold on

Label = {'Bridge Leg output Voltages (V)'};
ylabel(subplot3, Label, 'FontSize', Font_size, 'FontName', Font_type);
clear Label;

% Sub-plot 4 output voltage_npc
subplot4 = axes('position',[PlotOrigin(1),PlotOrigin(2)+0*(PlotHeight+PlotSpacing),...
                            PlotWidth,PlotHeight],...
                'YColor',y1_Color,...                                                
                'XTick',0:x_inc:x_max,...                  
                'YTick',sp3_y1_Range(1):sp3_y1_inc:sp3_y1_Range(2),...   
                'FontSize',Font_size,...
                'FontName',Font_type);

axis(subplot4,[ 0 x_max sp3_y1_Range(1) sp3_y1_Range(2) ])               
box(subplot4,'on');
grid(subplot4,'on');
hold(subplot4,'all');

area((out_npc.Va_out.time*x_RangeScaler-x_RangeOffset),out_npc.Va_out.signals.values(:,1),...
     'FaceColor',y2_Color,...                                               
     'EdgeColor',y1_Color,...
     'LineWidth',2,...
     'DisplayName', 'Output Voltage NPC', ... % Add this line for legend
     'Parent',subplot4);
legend(subplot4, 'show'); % Add this line to show legend
hold on

Label = {'NPC output Voltages (V)'};
ylabel(subplot4, Label, 'FontSize', Font_size, 'FontName', Font_type);
clear Label;
