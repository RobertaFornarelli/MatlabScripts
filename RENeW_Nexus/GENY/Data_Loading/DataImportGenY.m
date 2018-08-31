%% Script to import data from CSV files
% Run this script in this subfolder: C:\Users\277803E\Documents\MATLAB\RENeW_Nexus\GENY\Data_Loading

%% GenY ComX
clear all
close all
clc

cd C:\Users\277803E\Dropbox\Work\Curtin_University\RENeW_Nexus_Smart_Cities\WGV_Data\data\GENY
cd COMX_510
list = ls('*.csv');
f = fullfile(pwd,{list(1,:);list(2,:)});
file1 = char(f(1,1));
file2 = char(f(2,1));

cd C:\Users\277803E\Documents\MATLAB\RENeW_Nexus\GENY\Data_Loading
[ temp,DataKey,DataKey_file1,DataKey_file2 ] = DataImportCSV( file1,file2 );

DataKey_ComX = DataKey;
GenYComX_Raw = temp;

DataKey_ComX(7:12,2) = {'ElectricityConsumptionApt1_Wh' 'ElectricityConsumptionRainWaterPump_Wh' 'ElectricityConsumptionHouseService_Wh' 'GasConsumptionApt1_Units' 'MainWaterConsumptionApt1_L' 'RainWaterConsumptionApt1_L'};
DataKey_ComX(13:18,2) = {'InstantaneousPowerApt1_W' 'InstantaneousPowerRainWaterPump_W' 'InstantaneousPowerHouseService_W' 'GasFlowRateApt1_L/h' 'MainWaterFlowRateApt1_L/h' 'RainWaterFlowRateApt1_L/h'};

save('GenYComXData.mat','DataKey_ComX','GenYComX_Raw')

%% GenY Sim10
clear all
close all
clc

cd C:\Users\277803E\Dropbox\Work\Curtin_University\RENeW_Nexus_Smart_Cities\WGV_Data\data\GENY
cd SIM10M
list = ls('*.csv');
f = fullfile(pwd,{list(1,:);list(2,:)});
file1 = char(f(1,1));
file2 = char(f(2,1));

cd C:\Users\277803E\Documents\MATLAB\RENeW_Nexus\GENY\Data_Loading
[ temp,DataKey,DataKey_file1,DataKey_file2 ] = DataImportCSV( file1,file2 );

DataKey_Sim10 = DataKey;
GenYSim10_Raw = temp;

DataKey_Sim10(7:12,2) = {'ElectricityConsumptionApt2_Wh' 'GasConsumptionApt2_Units' 'MainWaterConsumptionApt2_L' 'RainWaterConsumptionApt2_L' 'NA' 'NA'};
DataKey_Sim10(19:24,2) = {'ElectricityConsumptionApt3_Wh' 'GasConsumptionApt3_Units' 'MainWaterConsumptionApt3_L' 'RainWaterConsumptionApt3_L' 'NA' 'NA'};

save('GenYSim10Data.mat','DataKey_Sim10','GenYSim10_Raw')

%% GenY TempSensors
clear all
close all
clc

cd C:\Users\277803E\Dropbox\Work\Curtin_University\RENeW_Nexus_Smart_Cities\WGV_Data\data\GENY
cd Temp_sensors
list = ls('*.csv');
f = fullfile(pwd,{list(1,:);list(2,:)});
file1 = char(f(1,1));
file2 = char(f(2,1));

cd C:\Users\277803E\Documents\MATLAB\RENeW_Nexus\GENY\Data_Loading
[ temp,DataKey,DataKey_file1,DataKey_file2 ] = DataImportCSV( file1,file2 );

DataKey_TempRH = DataKey;
DataKey_TempRH(7:8,2) = {'%' 'oC'};
GenYTempRH_Raw = temp;

save('GenYTempRHData.mat','DataKey_TempRH','GenYTempRH_Raw')

%% GenY DESS
clear all
close all
clc

cd C:\Users\277803E\Dropbox\Work\Curtin_University\RENeW_Nexus_Smart_Cities\WGV_Data\data\GENY
cd DESS
list = ls('*.csv');
f = fullfile(pwd,{list(1,:);list(2,:)});
file1 = char(f(1,1));
file2 = char(f(2,1));

cd C:\Users\277803E\Documents\MATLAB\RENeW_Nexus\GENY\Data_Loading
[ temp,DataKey,DataKey_file1,DataKey_file2 ] = DataImportCSV( file1,file2 );

DataKey_DESS = DataKey;
GenYDESS_Raw = temp;

DataKey_DESS(8:13,2) = {'InstPower_W'};
DataKey_DESS(15:17,2) = {'InstPower_W'};

save('GenYDESSData.mat','DataKey_DESS','GenYDESS_Raw')

%% GenY GridMeter
clear all
close all
clc

cd C:\Users\277803E\Dropbox\Work\Curtin_University\RENeW_Nexus_Smart_Cities\WGV_Data\data\GENY
cd Grid_and_Load_Meters\Grid_Meter
list = ls('*.csv');
f = fullfile(pwd,{list(1,:);list(2,:)});
file1 = char(f(1,1));
file2 = char(f(2,1));

cd C:\Users\277803E\Documents\MATLAB\RENeW_Nexus\GENY\Data_Loading
[ temp,DataKey,DataKey_file1,DataKey_file2 ] = DataImportCSV2( file1,file2 );

DataKey_GridMeter = DataKey;
GenYGridMeter_Raw = temp;

DataKey_GridMeter(13:15,2) = {'EnergyImportGridToLoad_kWh' 'EnergyExportToGrid_kWh' 'InstPower_kW'};

save('GenYGridMeterData.mat','DataKey_GridMeter','GenYGridMeter_Raw')

%% GenY LoadMeter
clear all
close all
clc

cd C:\Users\277803E\Dropbox\Work\Curtin_University\RENeW_Nexus_Smart_Cities\WGV_Data\data\GENY
cd Grid_and_Load_Meters\Load_Meter
list = ls('*.csv');
f = fullfile(pwd,{list(1,:);list(2,:)});
file1 = char(f(1,1));
file2 = char(f(2,1));

cd C:\Users\277803E\Documents\MATLAB\RENeW_Nexus\GENY\Data_Loading
[ temp,DataKey,DataKey_file1,DataKey_file2 ] = DataImportCSV2( file1,file2 );

DataKey_LoadMeter = DataKey;
GenYLoadMeter_Raw = temp;

DataKey_LoadMeter(13:15,2) = {'EnergyImportToLoad_kWh' 'EnergyExportFromLoad_kWh' 'InstPower_kW'};

save('GenYLoadMeterData.mat','DataKey_LoadMeter','GenYLoadMeter_Raw')

%% GenY EnergyMeters_1MinInterval
clear all
close all
clc

cd C:\Users\277803E\Dropbox\Work\Curtin_University\RENeW_Nexus_Smart_Cities\WGV_Data\data\GENY
cd Grid_and_Load_Meters
list = ls('*.csv');
f = fullfile(pwd,{list(1,:)});
file1 = char(f(1,1));

cd C:\Users\277803E\Documents\MATLAB\RENeW_Nexus\GENY\Data_Loading

delimiter = ',';
comment   = '';
quotes    = '';
option1   = 'numeric';
option2   = 'textual';
file_name_open1 = file1;
fid1=fopen(file_name_open1);
data1 = readtext(file_name_open1,delimiter, comment, quotes, option1);
text1 = readtext(file_name_open1,delimiter, comment, quotes, option2);

T = text1(2:end,1);
[y,m,d,h,min,sec] = datevec(T,'yyyy-mm-dd HH:MM:SS');
TT = datetime(y,m,d,h,min,sec,'TimeZone','UTC');
TT.TimeZone = '+08:00';
[y,m,d,h,min,sec] = datevec(TT);
TTT = datenum(y,m,d,h,min,sec);
TTT(:,2:6)=([y m d h min]);
data = data1(2:end,2:end);
temp = [TTT data];
temp = sortrows(temp,1);
GenYEnergyMeter_Raw = temp;

DataKey_file1 = text1(1,:)';
DataKey_Time = {'Date';'Year';'Month';'Day';'Hour';'Min'};
DataKey = [DataKey_Time;DataKey_file1(2:end,1)];
DataKey_EnergyMeter = DataKey;
DataKey_EnergyMeter(7:10,2) = {'kWh' 'kWh' 'kWh' 'kWh'};

save('GenYEnergyMeter.mat','DataKey_EnergyMeter','GenYEnergyMeter_Raw')
