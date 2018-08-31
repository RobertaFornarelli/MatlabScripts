%% Work through GenY data to create a matrix with all data at minute time step
% Run this script in this subfolder: C:\Users\277803E\Documents\MATLAB\RENeW_Nexus\GENY\

clear all
close all
clc

cd C:\Users\277803E\Documents\MATLAB\RENeW_Nexus\GENY\
cd Data_Loading
list = ls('GenY*.mat');
for i = 1:size(list,1)
    load(list(i,:));
end
cd ../

%% Create a time series at minute time step from 1/Jun/2017 to 31/Dec/2018
time = [datenum(2017,6,1,0,0,0):datenum(0,0,0,0,1,0):datenum(2019,1,1,0,0,0)]';
[y,m,d,h,min,sec] = datevec(time);
T = ([time y m d h min]);
temp =[];
temp(:,1:6) = T;

% Copy data into the 1 minute time step matrix
% ComX
for i=1:size(temp,1)
    index = find(temp(i,1) == GenYComX_Raw(:,1)); 
    if isfinite(index)
       temp(i,7:18) = GenYComX_Raw(index(1,1),7:end);
    end
end
col_size = size(temp,2);

% Sim10
for i=1:size(temp,1)
    index = find(temp(i,1) == GenYSim10_Raw(:,1)); 
    if isfinite(index)
       temp(i,(col_size+1):(col_size+(size(GenYSim10_Raw,2)-6))) = GenYSim10_Raw(index(1,1),7:end);
    end
end
col_size = size(temp,2);

% RHMeter
for i=1:size(temp,1)
    index = find(temp(i,1) == GenYTempRH_Raw(:,1)); 
    if isfinite(index)
       temp(i,(col_size+1):(col_size+(size(GenYTempRH_Raw,2)-6))) = GenYTempRH_Raw(index(1,1),7:end);
    end
end
col_size = size(temp,2);

% DESS
for i=1:size(temp,1)
    index = find(temp(i,1) == GenYDESS_Raw(:,1)); 
    if isfinite(index)
       temp(i,(col_size+1):(col_size+(size(GenYDESS_Raw,2)-6))) = GenYDESS_Raw(index(1,1),7:end);
    end
end
col_size = size(temp,2);

% EnergyMeter
for i=1:size(temp,1)
    index = find(temp(i,1) == GenYEnergyMeter_Raw(:,1)); 
    if isfinite(index)
       temp(i,(col_size+1):(col_size+(size(GenYEnergyMeter_Raw,2)-6))) = GenYEnergyMeter_Raw(index(1,1),7:end);
    end
end
col_size = size(temp,2);

% GridMeter
for i=1:size(temp,1)
    index = find(temp(i,1) == GenYGridMeter_Raw(:,1)); 
    if isfinite(index)
       temp(i,(col_size+1):(col_size+(size(GenYGridMeter_Raw,2)-6))) = GenYGridMeter_Raw(index(1,1),7:end);
    end
end
col_size = size(temp,2);

% LoadMeter
for i=1:size(temp,1)
    index = find(temp(i,1) == GenYLoadMeter_Raw(:,1)); 
    if isfinite(index)
       temp(i,(col_size+1):(col_size+(size(GenYLoadMeter_Raw,2)-6))) = GenYLoadMeter_Raw(index(1,1),7:end);
    end
end
col_size = size(temp,2);
GenYData_TimeStep_1_Minute = temp;

DataKey = [DataKey_ComX;DataKey_Sim10(7:end,:);DataKey_TempRH(7:end,:);DataKey_DESS(7:end,:);DataKey_EnergyMeter(7:end,:);DataKey_GridMeter(7:end,:);DataKey_LoadMeter(7:end,:)];
    

%% Aggregate data from 1 minute to 15 minute time step
temp = [];
temp = GenYData_TimeStep_1_Minute;
temp2 =[];
tmp =[];
k = 1;
t = 1;
for i = 1:(size(temp,1)-1)
    if temp(i,5) == temp(i+1,5)
        tmp(k,:) = temp(i,:);
        k = k+1;
    else
        tmp(k,:) = temp(i,:);
        k = k+1;
        temp2(t,:) = tmp(find(tmp(:,6)==0),:);
        t = t+1;
        temp2(t,:) = tmp(find(tmp(:,6)==15),:);
        t = t+1;
        temp2(t,:) = tmp(find(tmp(:,6)==30),:);
        t = t+1;
        temp2(t,:) = tmp(find(tmp(:,6)==45),:);
        t = t+1;
        tmp =[];
        k = 1;
    end
end
GenYData_TimeStep_15_Minute = temp2;
temp2 = [];
temp =[];

%% Count data 
rows = find(GenYData_TimeStep_15_Minute(:,1) == datenum(2017,10,04,0,0,0));
rowf = find(GenYData_TimeStep_15_Minute(:,1) == datenum(2018,06,01,0,0,0));

temp = GenYData_TimeStep_15_Minute(rows:rowf,:);
count = zeros(5,size(temp,2));
t = 1;
k = 1;
p = 1;
q = 1;
for j = 1:size(temp,2)
    for i = 1:size(temp,1)
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
Counter = count';
Counter1 = num2cell(Counter);
DataKey(:,3:(size(Counter,2)+2)) = Counter1;
DataKey(1,3:7) = {'=0';'NaN';'>0';'<0';'Sum'};

save('GenYData_Raw.mat','GenYData_TimeStep_1_Minute','GenYData_TimeStep_15_Minute','DataKey')

%Digital_Input_Counter_DI1: ElectricityConsumptionApt1_Wh
%Digital_Input_Counter_DI2: ElectricityConsumptionRainWaterPump_Wh
%Digital_Input_Counter_DI3: ElectricityConsumptionHouseService_Wh
%Digital_Input_Counter_DI4: GasConsumptionApt1_Units
%Digital_Input_Counter_DI5: MainWaterConsumptionApt1_L
%Digital_Input_Counter_DI6: RainWaterConsumptionApt1_L
%
%Digital_Input_Flow_DI1: InstantaneousPowerApt1_W
%Digital_Input_Flow_DI2: InstantaneousPowerRainWaterPump_W
%Digital_Input_Flow_DI3: InstantaneousPowerHouseService_W
%Digital_Input_Flow_DI4: GasFlowRateApt1_L/h
%Digital_Input_Flow_DI5: MainWaterFlowRateApt1_L/h
%Digital_Input_Flow_DI6: RainWaterFlowRateApt1_L/h
%
% Digital_Input_Counter_DI0: ElectricityConsumptionApt2_Wh
% Digital_Input_Counter_DI1: GasConsumptionApt2_Units
% Digital_Input_Counter_DI2: MainWaterConsumptionApt2_L
% Digital_Input_Counter_DI3: RainWaterConsumptionApt2_L
% Digital_Input_Counter_DI4: NA
% Digital_Input_Counter_DI5: NA
% 
% Digital_Input_Counter_DI0: ElectricityConsumptionApt3_Wh
% Digital_Input_Counter_DI1: GasConsumptionApt3_Units
% Digital_Input_Counter_DI2: MainWaterConsumptionApt3_L
% Digital_Input_Counter_DI3: RainWaterConsumptionApt3_L
% Digital_Input_Counter_DI4: NA
% Digital_Input_Counter_DI5: NA
% 
% Analog_Output_.Apt_1_Rel_Hum: RelativeHumidityApt1_Perc
% Analog_Output.Apt_1_Temp: TemperatureApt1_oC
% Analog_Output_.Apt_2_Rel_Hum: RelativeHumidityApt2_Perc
% Analog_Output.Apt_2_Temp: TemperatureApt2_oC
% Analog_Output_.Apt_3_Rel_Hum: RelativeHumidityApt3_Perc
% Analog_Output.Apt_3_Temp: TemperatureApt3_oC
% 
% Analog_Output_Solar_A: SolarPVPower_PhaseA_W
% Analog_Output_Solar_B: SolarPVPower_PhaseB_W
% Analog_Output_Solar_C: SolarPVPower_PhaseC_W
% 
% Analog_Output_Load_A: PowerConsumption_PhaseA_W
% Analog_Output_Load_B: PowerConsumption_PhaseB_W
% Analog_Output_Load_C: PowerConsumption_PhaseC_W
% 
% Analog_Output_Grid_A: PowerExport_PhaseA_W
% Analog_Output_Grid_B: PowerExport_PhaseB_W
% Analog_Output_Grid_C: PowerExport_PhaseC_W
% 
% Analog_Output_VoltageBattery: DCVoltageBatteryPack_V
% Analog_Output_CurrentBattery: DCCurrentBatteryPack_A
% Analog_Output_SOCBattery: StateOfChargeBattery_Perc
