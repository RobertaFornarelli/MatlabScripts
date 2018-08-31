%% Open csv files from folder containing raw data
clear all
close all
clc

delimiter = ',';
comment   = '';
quotes    = '';
option1   = 'numeric';
option2   = 'textual';

file_name_open1=['C:\Users\277803E\Dropbox\Work\Curtin_University\RENeW_Nexus_Smart_Cities\WGV_Data\WeatherDataBoM\IDCJAC0009_009192_1800\IDCJAC0009_009192_1800_Data.csv'];
fid1=fopen(file_name_open1);
data1 = readtext(file_name_open1,delimiter, comment, quotes, option1);
text1 = readtext(file_name_open1,delimiter, comment, quotes, option2);

T = datenum(data1(2:end,3),data1(2:end,4),data1(2:end,5));
Rain(:,1) = T; % Matlab date
Rain(:,2) = data1(2:end,3); % Year
Rain(:,3) = data1(2:end,4); % Month
Rain(:,4) = data1(2:end,5); % Day
Rain(:,5) = data1(2:end,6); % Rainfall amount (mm)
Rain(:,6) = data1(2:end,7); % Period over which rainfall was measured (days)
Rain(:,7) = data1(2:end,8); % Quality

% Rain from 1st January 2004 - before Jan 2004 there are lots of missing data (for example no data at all from Jan 2000 to Mar 2004)
row = find(Rain(:,1) == datenum(2004,1,1));
RainFrom2004 = [];
RainFrom2004 = Rain(row:end,:);
col = size(RainFrom2004,2);
RainFrom2004(:,col+1) = RainFrom2004(:,5);

for i = 1:size(RainFrom2004,1)
    if RainFrom2004(i,6) > 1
        days = RainFrom2004(i,6);
        rain = RainFrom2004(i,5);
        RainFrom2004((i-days+1):i,end) = rain/days;
    end
end
row = find(isnan(RainFrom2004(:,end))); % Let's put all NaN values to zeros: I have checked measurement individually and it makes sense

for i = 1:size(RainFrom2004,1)
    if isnan(RainFrom2004(i,end))
        RainFrom2004(i,end) = 0;
    end
end

% Monthly Stats from 1st January 2004
tmp = [];
k = 1;
t = 1;
RainFrom2004(end+1,:) = 0;
for i = 1:(size(RainFrom2004,1)-1)
    if RainFrom2004(i,3)==RainFrom2004(i+1,3)
        tmp(k,:) = RainFrom2004(i,:);
        k = k+1;
    else
        tmp(k,:) = RainFrom2004(i,:);
        RainStats_Month(t,1:4) = tmp(1,1:4);
        RainStats_Month(t,5) = nansum(tmp(:,end)); % sum of rainfall in mm
        RainStats_Month(t,6) = nanmin(tmp(:,end)); % min value of rain in mm
        RainStats_Month(t,7) = nanmax(tmp(:,end)); % max value of rain in mm
        t = t+1;
        tmp =[];
        k = 1;
    end
end
RainFrom2004(end,:) = [];

% Annual Stats from 1st January 2004
tmp =[];
k = 1;
t = 1;
RainFrom2004(end+1,:) = 0;
for i = 1:(size(RainFrom2004,1)-1)
    if RainFrom2004(i,2)==RainFrom2004(i+1,2)
        tmp(k,:) = RainFrom2004(i,:);
        k = k+1;
    else
        tmp(k,:) = RainFrom2004(i,:);
        RainStats_Year(t,1:4) = tmp(1,1:4);
        RainStats_Year(t,5) = nansum(tmp(:,end)); % sum of rainfall in mm
        RainStats_Year(t,6) = nanmin(tmp(:,end)); % min value of rain in mm
        RainStats_Year(t,7) = nanmax(tmp(:,end)); % max value of rain in mm
        t = t+1;
        tmp =[];
        k = 1;
    end
end
RainFrom2004(end,:) = [];

DataKey_Rain(1:8,1) = {'Matlab date' 'Year' 'Month' 'Day' 'Rainfall amount (mm)' 'Period over which rainfall was measured (days)' 'Quality' 'Corrected'};

save('RainData.mat','Rain','RainFrom2004','RainStats_Month','RainStats_Year','DataKey_Rain')


