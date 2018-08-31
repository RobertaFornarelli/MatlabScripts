%% Work through GenY data at 15 minute time step to clean data/interpolate for missing values

clear all
close all
clc

cd C:\Users\277803E\Documents\MATLAB\RENeW_Nexus\GENY\
load('GenYData_Raw.mat')

%% Interpolation of missing values (as NaNs and zeros) for cumulated curves
% Select time window where I have data
rows = find(GenYData_TimeStep_15_Minute(:,1) == datenum(2017,10,04,0,0,0));
rowf = find(GenYData_TimeStep_15_Minute(:,1) == datenum(2018,06,05,0,0,0));

temp = [];
temp = GenYData_TimeStep_15_Minute;

% Whether I have only one missing measurement at time t, calculate the value at time t as the average of values at t-1 and t+1 (i.e., linear interpolation)
for i = 2:(size(temp,1)-1)
    for j = [7:12,19:22,31:34,71:72,80:81]
    if isnan(temp(i,j)) && temp(i-1,j) > 0 && temp(i+1,j) > 0
        temp(i,j) = mean([temp(i-1,j),temp(i+1,j)]);
    else if temp(i,j) == 0 && temp(i-1,j) > 0 && temp(i+1,j) > 0
        temp(i,j) = mean([temp(i-1,j),temp(i+1,j)]);
        end
    end
    end
end

% Whether I have a few consecutive missing points, I can use spline interpolation for cumulated readings
% Interpolation of the cumulated data
% Cumulated data cannot be zeros, so transform all zeros to NaN values 
% Spline interpolation is then used on the cumulated curves
for i = rows:rowf
    for j = [7:12,19:22,31:34,71:72,80:81]
        if temp(i,j) == 0
            temp(i,j) = NaN;
        end
    end
end

for j = [7:12,19:22,31:34,71:72,80:81] 
    y = spline(temp(:,1),temp(:,j),temp(:,1));
    for i = rows:rowf
        if isnan(temp(i,j)) || temp(i,j) == 0
            temp(i,j) = y(i,1);
        end
    end
end

%% ADD INTERPOLATION OF NON CUMULATED VARIABLES

% Interpolation of DESS Solar A, B, C values
rows_NanA = find(isnan(temp(:,57)));
rows_NanB = find(isnan(temp(:,58)));
rows_NanC = find(isnan(temp(:,59)));

% Same missing dates for each phase A,B and C 
% Whether I have only one missing measurement at time t, calculate the value at time t as the average of values at t-1 and t+1 (i.e., linear interpolation)
for i = 2:(size(temp,1)-1)
    for j = [57:59]
    if isnan(temp(i,j)) && temp(i-1,j) >= 0 && temp(i+1,j) >= 0
        temp(i,j) = mean([temp(i-1,j),temp(i+1,j)]);
    else if temp(i,j) == 0 && temp(i-1,j) >= 0 && temp(i+1,j) >= 0
        temp(i,j) = mean([temp(i-1,j),temp(i+1,j)]);
        end
    end
    end
end
% If the NaNs values happen at night, set the value to zero
for i = 1:size(temp,1)
    for j = [57:59]
    if isnan(temp(i,j))
        if (temp(i,5) > 21 || temp(i,5) < 5)
            temp(i,j) = 0;
        end
    end
    end
end
% The other NaNs of solar values are at the beginning of the time series (10/Oct/2017) and they can just be disregarded as the energy balance calculations and models will all start from Novermber 1st


% Interpolation of Relative Humidity and Temperature data
% Whether I have only one missing measurement at time t, calculate the value at time t as the average of values at t-1 and t+1 (i.e., linear interpolation)
for i = 2:(size(temp,1)-1)
    for j = [43:48]
    if isnan(temp(i,j)) && temp(i-1,j) >= 0 && temp(i+1,j) >= 0
        temp(i,j) = mean([temp(i-1,j),temp(i+1,j)]);
    else if temp(i,j) == 0 && temp(i-1,j) >= 0 && temp(i+1,j) >= 0
        temp(i,j) = mean([temp(i-1,j),temp(i+1,j)]);
        end
    end
    end
end
% Temperature and humidity cannot be zero, so I transform all zeros to NaN
for i = rows:rowf
    for j = [43:48]
        if temp(i,j) == 0
            temp(i,j) = NaN;
        end
    end
end
% xlswrite('temp.xls',temp)


%% Count how many zeroes and NaNs values are left. 
% In the cumulated measurements, no zero or NaN value is expected 
rows = find(GenYData_TimeStep_15_Minute(:,1) == datenum(2017,11,01,0,0,0));
rowf = find(GenYData_TimeStep_15_Minute(:,1) == datenum(2018,06,05,0,0,0));

count = zeros(5,size(temp,2));
t = 1;
k = 1;
p = 1;
q = 1;
for j = 1:size(temp,2)
    for i = rows:rowf
        if temp(i,j) == 0
            count(1,j) = t;
            t = t+1;
        else if isnan(temp(i,j))
            count(2,j) = k;
            k = k+1;
        else if temp(i,j) > 0
            count(3,j) = p;
            p = p+1;
        else if temp(i,j) < 0
            count(4,j) = q;
            q = q+1;
        end
        end
        end
        end
    end
    count(5,j) = sum(count(1:4,j));
    t = 1;
    k = 1;
    p = 1;
    q = 1;
end
tmp = count';
Counter1 = num2cell(tmp);
DataKey(:,8:(end+size(tmp,2))) = Counter1;
DataKey(1,8:end) = {'=0';'NaN';'>0';'<0';'Sum'};

GenYData_TimeStep_15_Minute_Corr = temp;
temp = [];

save('GenYData_Interp.mat','GenYData_TimeStep_1_Minute','GenYData_TimeStep_15_Minute','GenYData_TimeStep_15_Minute_Corr','DataKey') 

