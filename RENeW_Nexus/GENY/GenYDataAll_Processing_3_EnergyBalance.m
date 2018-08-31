%% Work through interpolated GenY data at 15 minute time step to calculate energy balance

clear all
close all
clc

load('GenYData_Interp.mat')

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


%% Energy Balance
temp = [];
temp = GenYData_TimeStep_15_Minute_DecumulatedData;
GenYData_TimeStep_15_Minute_EnergyBalance = [temp(:,1:9) temp(:,19) temp(:,31) temp(:,57:59) temp(:,53:55) temp(:,50:52) temp(:,56) temp(:,71:73) temp(:,80:82)];
DataKey_EnergyBalance = [DataKey(1:9,1)' DataKey(19,1) DataKey(31,1) DataKey(57:59,1)' DataKey(53:55,1)' DataKey(50:52,1)' DataKey(56,1) DataKey(71:73,1)' DataKey(80:82,1)']';

% Calculate the energy balance
rows = find(GenYData_TimeStep_15_Minute_EnergyBalance(:,1) == datenum(2017,11,01,0,0,0)); % day when we have all data collected and not crazy values
rowf = find(GenYData_TimeStep_15_Minute_EnergyBalance(:,1) == datenum(2018,06,01,0,0,0));
temp = [];
temp = GenYData_TimeStep_15_Minute_EnergyBalance(rows:rowf,:);

col = size(temp,2);
BattMaxCapacity = 8; %kWh (real max capacity is 10 kWh but it is set to 8kWh for battery's life

for i = 2:size(temp,1)
    temp(i,(col+1)) = temp(i,21)/100*BattMaxCapacity*1000; % Battery: energy available as SOC * MaxCapacitiy
    temp(i,(col+2)) = temp(i,(col+1)) - temp(i-1,(col+1)); % Battery: energy export from batt to load (-) or import from solar to batt(+) 
    temp(i,(col+3)) = nansum(temp(i,12:14)); % Total Solar (in Wh): sum of phase A, B and C 
    % temp(i,(col+4)) = nansum(temp(i,7:11)); % Total Load (in Wh): sum of Apt1, house services, rainwater pump, Apt2, Apt3 
    temp(i,(col+4)) = temp(i,25); % Total Load (in Wh) as per grid energy meter 
    
    if temp(i,col+3) == 0 % if solar energy is = 0
        temp(i,(col+5)) = 0; % solar to load
        temp(i,(col+6)) = 0; % solar to grid
        temp(i,(col+7)) = 0; % solar to battery
        
        temp(i,(col+8)) = temp(i,22); % grid to load
        temp(i,(col+9)) = temp(i,col+6); % grid from solar
        temp(i,(col+10)) = 0; % grid from battery
        temp(i,(col+11)) = temp(i,(col+9)) + temp(i,(col+10)); % grid export total
        
        temp(i,(col+12)) = temp(i,col+10); % battery to grid
        temp(i,(col+13)) = temp(i,(col+4)) - temp(i,(col+8)); % battery to load
        temp(i,(col+14)) = temp(i,(col+7)); % battery from solar = total battery demand
        temp(i,(col+15)) = temp(i,(col+12)) + temp(i,(col+13)); % total battery supply
        
        temp(i,(col+16)) = temp(i-1,col+1) + temp(i,col+14) - temp(i,col+15); % Energy available in battery(t): energy(t-1) + import to battery from solar - output from battery to load
        temp(i,(col+17)) = temp(i,(col+16))/(BattMaxCapacity*1000)*100;
              
    else if temp(i,col+3) > 0 % if solar energy is > 0
            if temp(i,(col+2)) > 0.00001 % battery is in charge
                temp(i,(col+5)) = 0; % solar to load
                temp(i,(col+6)) = temp(i,23); % solar to grid
                temp(i,(col+7)) = temp(i,(col+3)) - temp(i,(col+5)) - temp(i,(col+6)); % solar to battery
        
                temp(i,(col+8)) = temp(i,22); % grid to load
                temp(i,(col+9)) = temp(i,col+6); % grid from solar
                temp(i,(col+10)) = 0; % grid from battery
                temp(i,(col+11)) = temp(i,(col+9)) + temp(i,(col+10)); % grid export total
        
                temp(i,(col+12)) = temp(i,col+10); % battery to grid
                temp(i,(col+13)) = temp(i,(col+4)) - temp(i,(col+8)); % battery to load
                temp(i,(col+14)) = temp(i,(col+7)); % battery from solar = total battery demand
                temp(i,(col+15)) = temp(i,(col+12)) + temp(i,(col+13)); % total battery supply
        
                temp(i,(col+16)) = temp(i-1,col+1) + temp(i,col+14) - temp(i,col+15); % Energy available in battery(t): energy(t-1) + import to battery from solar - output from battery to load
                temp(i,(col+17)) = temp(i,(col+16))/(BattMaxCapacity*1000)*100;
        
            else if temp(i,(col+2)) <= 0  % battery is in use together with solar and grid
                temp(i,(col+5)) = 0; % solar to load
                temp(i,(col+6)) = temp(i,23); % solar to grid
                temp(i,(col+7)) = temp(i,(col+3)) - temp(i,(col+5)) - temp(i,(col+6)); % solar to battery
        
                temp(i,(col+8)) = temp(i,22); % grid to load
                temp(i,(col+9)) = temp(i,col+6); % grid from solar
                temp(i,(col+10)) = 0; % grid from battery
                temp(i,(col+11)) = temp(i,(col+9)) + temp(i,(col+10)); % grid export total
        
                temp(i,(col+12)) = temp(i,col+10); % battery to grid
                temp(i,(col+13)) = temp(i,(col+4)) - temp(i,(col+5)) - temp(i,(col+8)); % battery to load
                temp(i,(col+14)) = temp(i,(col+7)); % battery from solar = total battery demand
                temp(i,(col+15)) = temp(i,(col+12)) + temp(i,(col+13)); % total battery supply
        
                temp(i,(col+16)) = temp(i-1,col+1) + temp(i,col+14) - temp(i,col+15); % Energy available in battery(t): energy(t-1) + import to battery from solar - output from battery to load
                temp(i,(col+17)) = temp(i,(col+16))/(BattMaxCapacity*1000)*100;
                end
            end
        end
    end
       
    DataKey_EnergyBalance((col+1),1) = {'Battery: energy available at time t (Wh)'};
    DataKey_EnergyBalance((col+2),1) = {'Battery: delta energy ((t)-(t-1)), supply(-);recharge(+)'};
    DataKey_EnergyBalance((col+3),1) = {'Total solar (Wh)'};
    DataKey_EnergyBalance((col+4),1) = {'Total load (Wh)'};
    DataKey_EnergyBalance((col+5),1) = {'Solar to load (Wh)'};
    DataKey_EnergyBalance((col+6),1) = {'Solar to grid (Wh)'};
    DataKey_EnergyBalance((col+7),1) = {'Solar to battery (Wh)'};
    DataKey_EnergyBalance((col+8),1) = {'Grid to load (Wh)'};
    DataKey_EnergyBalance((col+9),1) = {'Grid from solar (Wh)'};
    DataKey_EnergyBalance((col+10),1) = {'Grid from battery (Wh)'};
    DataKey_EnergyBalance((col+11),1) = {'Grid export total (Wh)'};
    DataKey_EnergyBalance((col+12),1) = {'Battery to grid (Wh)'};
    DataKey_EnergyBalance((col+13),1) = {'Battery to load (Wh)'};
    DataKey_EnergyBalance((col+14),1) = {'Battery from solar: total battery demand (Wh)'};
    DataKey_EnergyBalance((col+15),1) = {'Total battery supply (Wh)'};
    DataKey_EnergyBalance((col+16),1) = {'Energy available in battery(t) calculated (Wh)'};
    DataKey_EnergyBalance((col+17),1) = {'SOC battery calculated (Wh)'};
end
GenYData_TimeStep_15_Minute_EnergyBalance = temp;

% xlswrite('temp.xls',temp)

save('GenYData_EnergyBalance.mat','GenYData_TimeStep_1_Minute','GenYData_TimeStep_15_Minute','GenYData_TimeStep_15_Minute_Corr','GenYData_TimeStep_15_Minute_DecumulatedData','GenYData_TimeStep_15_Minute_EnergyBalance','DataKey','DataKey_EnergyBalance') 

%% Plots

% plot raw data to look at decumulated values
Nov15 = [datenum(2017,11,15,0,0,0) datenum(2017,11,16,0,0,0)];
Dec15 = [datenum(2017,12,15,0,0,0) datenum(2017,12,16,0,0,0)];
Jan15 = [datenum(2018,01,15,0,0,0) datenum(2018,01,16,0,0,0)];
Feb15 = [datenum(2018,02,15,0,0,0) datenum(2018,02,16,0,0,0)];
Mar15 = [datenum(2018,03,15,0,0,0) datenum(2018,03,16,0,0,0)];
Apr15 = [datenum(2018,04,15,0,0,0) datenum(2018,04,16,0,0,0)];

plot_EnergyDataRaw(GenYData_TimeStep_15_Minute_EnergyBalance,Nov15)
plot_EnergyDataRaw(GenYData_TimeStep_15_Minute_EnergyBalance,Dec15)
plot_EnergyDataRaw(GenYData_TimeStep_15_Minute_EnergyBalance,Jan15)
plot_EnergyDataRaw(GenYData_TimeStep_15_Minute_EnergyBalance,Feb15)
plot_EnergyDataRaw(GenYData_TimeStep_15_Minute_EnergyBalance,Mar15)
plot_EnergyDataRaw(GenYData_TimeStep_15_Minute_EnergyBalance,Apr15)

% plot energy balance data 
Nov15 = [datenum(2017,11,15,0,0,0) datenum(2017,11,16,0,0,0)];
Dec15 = [datenum(2017,12,15,0,0,0) datenum(2017,12,16,0,0,0)];
Jan15 = [datenum(2018,01,15,0,0,0) datenum(2018,01,16,0,0,0)];
Feb15 = [datenum(2018,02,15,0,0,0) datenum(2018,02,16,0,0,0)];
Mar15 = [datenum(2018,03,15,0,0,0) datenum(2018,03,16,0,0,0)];
Apr15 = [datenum(2018,04,15,0,0,0) datenum(2018,04,16,0,0,0)];
May15 = [datenum(2018,05,15,0,0,0) datenum(2018,05,16,0,0,0)];

plot_EnergyBalance(GenYData_TimeStep_15_Minute_EnergyBalance,Nov15)
plot_EnergyBalance(GenYData_TimeStep_15_Minute_EnergyBalance,Dec15)
plot_EnergyBalance(GenYData_TimeStep_15_Minute_EnergyBalance,Jan15)
plot_EnergyBalance(GenYData_TimeStep_15_Minute_EnergyBalance,Feb15)
plot_EnergyBalance(GenYData_TimeStep_15_Minute_EnergyBalance,Mar15)
plot_EnergyBalance(GenYData_TimeStep_15_Minute_EnergyBalance,Apr15)
plot_EnergyBalance(GenYData_TimeStep_15_Minute_EnergyBalance,May15)































%% 
% % Hourly time step for Energy balance matrix
% temp=[];
% temp = GenYData_TimeStep15Minute_EnergyBalance;
% temp2 = [];
% tmp =[];
% k = 1;
% t = 1;
% for i = 1:(size(temp,1)-1)
%     if temp(i,5)==temp(i+1,5)
%         tmp(k,:) = temp(i,:);
%         k = k+1;
%     else
%         tmp(k,:) = temp(i,:);
%         k = k+1;
%         tmp(k,:) = temp((i+1),:);
%         temp2(t,1:6) = tmp(1,1:6);
%         temp2(t,7:20) = nansum(tmp(2:end,7:20));
%         temp2(t,21) = nanmean(tmp(2:end,21));
%         temp2(t,22:size(tmp,2)) = nansum(tmp(2:end,22:end));
%         t = t+1;
%         tmp =[];
%         k = 1;
%     end
% end
% GenYData_TimeStep1Hour_EnergyBalance = temp2;
% 
% % 6 Hours time step for Energy Balance matrix
% temp = [];
% temp = GenYData_TimeStep1Hour_EnergyBalance;
% temp(size(temp,1)+1,:) = 0;
% temp2 = [];
% tmp =[];
% k = 1;
% t = 1;
% for i = 1:(size(temp,1)-1)
%     if temp(i,4)==temp(i+1,4)
%         tmp(k,:) = temp(i,:);
%         k = k+1;
%     else
%         tmp(k,:) = temp(i,:);
%         
%         Sixam = find(tmp(:,5) == 6);
%         Midday = find(tmp(:,5) == 12);
%         Sixpm = find(tmp(:,5) == 18);
%         
%         temp2(t,1:6) = tmp(1,1:6);
%         temp2(t,7:20) = nansum(tmp(1:(Sixam-1),7:20));
%         temp2(t,21) = nanmean(tmp(1:(Sixam-1),21));
%         temp2(t,22:size(tmp,2)) = nansum(tmp(1:(Sixam-1),22:end));
%         t = t+1;
%         
%         temp2(t,1:6) = tmp(Sixam,1:6);
%         temp2(t,7:20) = nansum(tmp(Sixam:(Midday-1),7:20));
%         temp2(t,21) = nanmean(tmp(Sixam:(Midday-1),21));
%         temp2(t,22:size(tmp,2)) = nansum(tmp(Sixam:(Midday-1),22:end));
%         t = t+1;
%         
%         temp2(t,1:6) = tmp(Midday,1:6);
%         temp2(t,7:20) = nansum(tmp(Midday:(Sixpm-1),7:20));
%         temp2(t,21) = nanmean(tmp(Midday:(Sixpm-1),21));
%         temp2(t,22:size(tmp,2)) = nansum(tmp(Midday:(Sixpm-1),22:end));
%         t = t+1;
%         
%         temp2(t,1:6) = tmp(Sixpm,1:6);
%         temp2(t,7:20) = nansum(tmp(Sixpm:end,7:20));
%         temp2(t,21) = nanmean(tmp(Sixpm:end,21));
%         temp2(t,22:size(tmp,2)) = nansum(tmp(Sixpm:end,22:end));
%         t = t+1;
%         
%         tmp =[];
%         k = 1;
%     end
% end
% GenYData_TimeStep6Hour_EnergyBalance = temp2;
% 
% 

