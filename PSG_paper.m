%% this file could draw PSG
load record31.mat
dif=662;

f=512;
wid=75;
markloc=-200;
linewidth=0.3;
frame=record(1:10,(dif-1)*f*30+1:dif*f*30); % EOG,F,C,O,EMG
frame(1:2,:)=frame(1:2,:)*1000;
frame(9:10,:)=frame(9:10,:)*1000; % unit mV to uV


%% Change the order of channels to the reference pic
frame_change = zeros(10, f*30);
frame_change(1,:) = frame(9, :);%EMG
frame_change(2,:) = frame(10,:);%EMG
frame_change(3,:) = frame(2,:);%EOG2:E2-M2
frame_change(4,:) = frame(1,:);%EOG1:E1-M2
frame_change(5,:) = frame(8,:);%O2-M1
frame_change(6,:) = frame(7,:);%O1-M2
frame_change(7,:) = frame(6,:);%C4-M1
frame_change(8,:) = frame(5,:);%C3-M2
frame_change(9,:) = frame(4,:);%F4-M1
frame_change(10,:) = frame(3,:);%F3-M2

%% Draw the picture
h = figure(dif)
% set(gcf, 'Position', [100 100 260 220]);
% set(gca, 'Position', [.13 .17 .80 .74])
% set(h, 'unit', 'normalized', 'position', [0,0,1,1]);
set(gcf,'position',[10 50 1350 630])
set(gca, 'Position', [0.05 0.05 0.93 0.9])
set(gca,'xtick',[]);
set(gca,'xtick',0:f:30*f,'xticklabel',{'0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30'});
set(gca,'Ytick',0:125:125*10);
set(gca,'YTickLabel',{'EMG','EMG','EOG','EOG','O2-M1','O1-M2','C4-M1','C3-M2','F4-M1','F3-M2',''},'Fontname', 'Times New Roman','FontSize',12, 'FontWeight','bold');
set(gca,'xgrid','on');
% set(gca,'gridlinestyle','--','linewidth',2);
% set(gca,'box','on');
axis([0,30*f,-50,125*9+150]);
% set(gca,'FontSize',10);
% set(gca,'FontWeight','bold');
% set(get(gca, 'YLabel'), 'FontSize', 8);
% set(get(gca,'YLable'), 'FontSize', 8);
% set(findobj(get(gca,'Children'),'LineWidth', 0.5), 'LineWidth', 2);
%raise=zeros(10,1);
% raise=[0,150,280,400,520,620,690,750,800,850]; % Fixed to compare in one scale
% raise=[0, 150, 300, 450, 600, 750, 900, 1050, 1200, 1350];
raise=0:125:125*9;
% transducer={'EOG';'EOG';'F';'F';'C';'C';'O';'O';'EMG';'EMG'};

color=['b','b','m','m','k','k','k','k','k','k'];
for n=1:2
    hold on
    plot(frame_change(n,:)+raise(n),color(n),'LineWidth',linewidth)
%     text(markloc,raise(n),transducer(n),'FontWeight','Bold')
    %raise(n+1)=raise(n)+max(frame(n,:))-min(frame(n+1,:));
end
for n=3:10
    hold on
    plot(frame_change(n,:)+raise(n),color(n),'LineWidth',linewidth)
%     text(markloc,raise(n),transducer(n),'FontWeight','Bold')
    %raise(n+1)=raise(n)+max(frame(n,:))-min(frame(n+1,:));
end
% hold on
% plot(frame(10,:)+raise(10),color(10),'LineWidth',linewidth)
% text(markloc,raise(10),transducer(10),'FontWeight','Bold') % Notes of transducer
% xmin=markloc-100;
% xmax=f*30;
% ymin=-100;
% ymax=1400;

% for n=1:29
%     hold on
%     plot([n*f,n*f],[ymin,ymax],'--r')
%     text(n*f,ymin-markloc*0.2,num2str(n),'FontWeight','Bold')
% end
% Plot the border of 75uV
xmin=0;
xmax=30*f;
loc_f1=(max(frame_change(10,:))+min(frame_change(10,:)))*0.5;
loc_f2=(max(frame_change(9,:))+min(frame_change(9,:)))*0.5;
plot([xmin,xmax],[loc_f1+raise(10)-wid*0.5,loc_f1+raise(10)-wid*0.5],'--m','LineWidth',linewidth)
plot([xmin,xmax],[loc_f1+raise(10)+wid*0.5,loc_f1+raise(10)+wid*0.5],'--m','LineWidth',linewidth)
plot([xmin,xmax],[loc_f2+raise(9)-wid*0.5,loc_f2+raise(9)-wid*0.5],'--m','LineWidth',linewidth)
plot([xmin,xmax],[loc_f2+raise(9)+wid*0.5,loc_f2+raise(9)+wid*0.5],'--m','LineWidth',linewidth)
set(gca,'TickLength',[0 0.001])

fig = gcf;
fig.InvertHardcopy = 'on';
print(h, '-r300','-depsc', [num2str(dif),'.eps'])
% print(h, '-r600', '-djpeg', 'aaa')

% saveas(gcf,[num2str(dif),'.pdf'])