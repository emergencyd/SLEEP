%% this file could draw PSG
load record31.mat
dif = 662;

f = 512;
wid = 75;
markloc = -200;
linewidth = 0.3;
frame = record(1: 10, (dif - 1) * f * 30 + 1: dif * f * 30); % EOG,F,C,O,EMG
frame(1: 2, :) = frame(1: 2, :) * 1000;
frame(9: 10, :) = frame(9: 10, :) * 1000; % unit mV to uV


%% Change the order of channels to the reference pic
frame_change = zeros(10, f*30);
frame_change(1, :) = frame(9, :);%EMG
frame_change(2, :) = frame(10, :);%EMG
frame_change(3, :) = frame(2, :);%EOG2:E2-M2
frame_change(4, :) = frame(1, :);%EOG1:E1-M2
frame_change(5, :) = frame(8, :);%O2-M1
frame_change(6, :) = frame(7, :);%O1-M2
frame_change(7, :) = frame(6, :);%C4-M1
frame_change(8, :) = frame(5, :);%C3-M2
frame_change(9, :) = frame(4, :);%F4-M1
frame_change(10, :) = frame(3, :);%F3-M2

%% Draw the picture
h = figure(dif)
set(gcf, 'position', [10 50 1350 630])
set(gca, 'Position', [0.05 0.05 0.93 0.9])
set(gca, 'xtick', []);
set(gca, 'xtick', 0:f:30*f,'xticklabel',{'0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30'});
set(gca, 'Ytick', 0:125:125*10);
set(gca, 'YTickLabel', {'EMG','EMG','EOG','EOG','O2-M1','O1-M2','C4-M1','C3-M2','F4-M1','F3-M2',''},'Fontname', 'Times New Roman','FontSize',12, 'FontWeight','bold');
set(gca, 'xgrid', 'on');

axis([0, 30 * f, -50, 125 * 9 + 150]);
raise = 0: 125: 125 * 9;

color = ['b','b','m','m','k','k','k','k','k','k'];
for n = 1: 2
    hold on
    plot(frame_change(n, :) + raise(n), color(n), 'LineWidth', linewidth)
end
for n = 3: 10
    hold on
    plot(frame_change(n, :) + raise(n), color(n), 'LineWidth', linewidth)
end

xmin = 0;
xmax = 30 * f;
loc_f1 = (max(frame_change(10, :)) + min(frame_change(10, :))) * 0.5;
loc_f2 = (max(frame_change(9, :)) + min(frame_change(9, :))) * 0.5;
plot([xmin, xmax], [loc_f1 + raise(10) - wid * 0.5, loc_f1 + raise(10) - wid * 0.5], '--m', 'LineWidth', linewidth)
plot([xmin, xmax], [loc_f1 + raise(10) + wid * 0.5, loc_f1 + raise(10) + wid * 0.5], '--m', 'LineWidth', linewidth)
plot([xmin, xmax], [loc_f2 + raise(9) - wid * 0.5, loc_f2 + raise(9) - wid * 0.5], '--m', 'LineWidth', linewidth)
plot([xmin, xmax], [loc_f2 + raise(9) + wid * 0.5, loc_f2 + raise(9) + wid * 0.5], '--m', 'LineWidth', linewidth)
set(gca, 'TickLength', [0 0.001])

fig = gcf;
fig.InvertHardcopy = 'on';
