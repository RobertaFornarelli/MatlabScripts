%% Work through interpolated GenY data at 15 minute time step to calculate water balance

clear all
close all
clc
cd C:\Users\277803E\Documents\MATLAB\RENeW_Nexus\GENY\

load('GenYData_Interp.mat')
cd Data_Loading
load('RainData.mat')
cd ../


%% Decumulate energy and water values and convert everything into energy (in Wh) and water (in L)
% Processing 15-minute data
% Decumulate the energy measurements
% Decumulate the water readings
% Convert power into energy usage (assume instantaneous power was constant in the 15 min interval - true for solar, not very accurate for loads and grid)

temp = GenYData_TimeStep_15_Minute_Corr;
temp2 = temp;
temp2(1,7:end) = 0;

for i = 2:size(temp2,1)
        temp2(i,7:12) = temp(i,7:12) - temp(i-1,7:12);
        temp2(i,13:18) = temp(i,13:18);
        temp2(i,19:24) = temp(i,19:24) - temp(i-1,19:24);
        temp2(i,25:30) = temp(i,25:30);
        temp2(i,31:36) = temp(i,31:36) - temp(i-1,31:36);
        temp2(i,37:49) = temp(i,37:49);
        temp2(i,50:55) = temp(i,50:55)*15/60;
        temp2(i,56) = temp(i,56);
        temp2(i,57:59) = temp(i,57:59)*15/60;
        temp2(i,60:70) = temp(i,60:70);
        temp2(i,71) = (temp(i,71) - temp(i-1,71))*1000;
        temp2(i,72) = (temp(i,72) - temp(i-1,72))*1000;
        temp2(i,73) = temp(i,73)*15/60*1000;
        temp2(i,74:79) = temp(i,74:79);
        temp2(i,80) = (temp(i,80) - temp(i-1,80))*1000;        
        temp2(i,81) = (temp(i,81) - temp(i-1,81))*1000;
        temp2(i,82) = temp(i,82)*15/60*1000;
end
GenYData_TimeStep_15_Minute_DecumulatedData = temp2;
temp2=[];
temp=[];


%% Water Balance
temp = [];
temp = GenYData_TimeStep_15_Minute_DecumulatedData;
GenYData_TimeStep_15_Minute_WaterBalance = [temp(:,1:6) temp(:,8) temp(:,11:12) temp(:,21:22) temp(:,33:34) temp(:,43:48)];
DataKey_WaterBalance = [DataKey(1:6,:);DataKey(8,:);DataKey(11:12,:);DataKey(21:22,:);DataKey(33:34,:);DataKey(43:48,:)];

% Calculate the water balance
rows = find(GenYData_TimeStep_15_Minute_WaterBalance(:,1) == datenum(2017,10,30,0,0,0)); % Monday: day when we have all data collected and not crazy values
rowf = find(GenYData_TimeStep_15_Minute_WaterBalance(:,1) == datenum(2018,06,05,0,0,0)); % Sunday
temp = [];
temp = GenYData_TimeStep_15_Minute_WaterBalance(rows:rowf,:);

col = size(temp,2);
RainTankCapacity = 10000; % 10 kL rainwater tank (to feed three apartments)
hh = 3.5; % Two apts with 1 adult each and one with 1 adult + 1 child: 3.5 persons)
RoofArea = 107; % 107m2 of roof area 

for i = 1:size(temp,1)
    temp(i,(col+1)) = temp(i,8) + temp(i,9); % Water demand Apt 1
    temp(i,(col+2)) = temp(i,10) + temp(i,11); % Water demand Apt 2
    temp(i,(col+3)) = temp(i,12) + temp(i,13); % Water demand Apt 3
    temp(i,(col+4)) = temp(i,9) + temp(i,11) + temp(i,13); % Total non potable water demand GenY
    temp(i,(col+5)) = temp(i,8) + temp(i,10) + temp(i,12); % Total potable water demand GenY
    temp(i,(col+6)) = temp(i,(col+4)) + temp(i,(col+5)); % Total water demand GenY
    temp(i,(col+7)) = temp(i,(col+4))/hh; % Total non potable water demand per person at GenY
    temp(i,(col+8)) = temp(i,(col+5))/hh; % Total potable water demand per person at GenY
    temp(i,(col+9)) = temp(i,(col+6))/hh; % Total water demand per person at GenY
       
    DataKey_WaterBalance((col+1),1) = {'Water demand Apt 1 (L)'};
    DataKey_WaterBalance((col+2),1) = {'Water demand Apt 2 (L)'};
    DataKey_WaterBalance((col+3),1) = {'Water demand Apt 3 (L)'};
    DataKey_WaterBalance((col+4),1) = {'Total non potable water demand GenY (L)'};
    DataKey_WaterBalance((col+5),1) = {'Total potable water demand GenY (L)'};
    DataKey_WaterBalance((col+6),1) = {'Total water demand GenY (L)'};
    DataKey_WaterBalance((col+7),1) = {'Non potable water demand GenY per person (L/hh)'};
    DataKey_WaterBalance((col+8),1) = {'Potable water demand GenY per person (L/hh)'};
    DataKey_WaterBalance((col+9),1) = {'Total water demand GenY per person (L/hh)'};
end
GenYData_TimeStep_15_Minute_WaterBalance = temp;

% Hourly time step for Water balance
temp2 = [];
tmp =[];
k = 1;
t = 1;
for i = 1:(size(temp,1)-1)
    if temp(i,5)==temp(i+1,5)
        tmp(k,:) = temp(i,:);
        k = k+1;
    else
        tmp(k,:) = temp(i,:);
        k = k+1;
        tmp(k,:) = temp((i+1),:);
        temp2(t,1:6) = tmp(1,1:6);
        for j = 7:13
            temp2(t,j) = sum(tmp(2:end,j));
        end
        for j = 14:19
            temp2(t,j) = nanmean(tmp(2:end,j));
        end
        for j = 20:size(tmp,2)
            temp2(t,j) = sum(tmp(2:end,j));
        end
        t = t+1;
        tmp =[];
        k = 1;
    end
end
GenYData_TimeStep_1_Hour_WaterBalance = temp2;

% Daily time step for Water balance
temp3 = [];
tmp =[];
k = 1;
t = 1;
for i = 1:(size(temp2,1)-1)
    if temp2(i,4)==temp2(i+1,4)
        tmp(k,:) = temp2(i,:);
        k = k+1;
    else
        tmp(k,:) = temp2(i,:);
        temp3(t,1:6) = tmp(1,1:6);
        for j = 7:13
            temp3(t,j) = sum(tmp(2:end,j));
        end
        for j = 14:19
            temp3(t,j) = nanmean(tmp(2:end,j));
        end
        for j = 20:size(tmp,2)
            temp3(t,j) = sum(tmp(2:end,j));
        end
        t = t+1;
        tmp =[];
        k = 1;
    end
end

rows = find(RainFrom2004(:,1) == temp3(1,1));
%rowf = find(RainFrom2004(:,1) == temp3(end,1));
col = size(temp3,2);

temp3(:,col+1) = [RainFrom2004(rows:end,end);0;0;0];
temp3(:,col+2) = (temp3(:,col+1)/1000*RoofArea)*1000; % L/d of rainwater available

GenYData_TimeStep_1_Day_WaterBalance = temp3;

DataKey_WaterBalance((col+1),1) = {'Rainfall (mm)'};
DataKey_WaterBalance((col+2),1) = {'Captured Rainfall (L/d)'};

save('GenYData_WaterBalance.mat','GenYData_TimeStep_1_Minute','GenYData_TimeStep_15_Minute','GenYData_TimeStep_15_Minute_Corr','GenYData_TimeStep_15_Minute_DecumulatedData','GenYData_TimeStep_15_Minute_WaterBalance','GenYData_TimeStep_1_Hour_WaterBalance','GenYData_TimeStep_1_Day_WaterBalance','DataKey','DataKey_WaterBalance') 


