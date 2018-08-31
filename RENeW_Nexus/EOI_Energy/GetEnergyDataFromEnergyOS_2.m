% Extract power data from Energy OS platform through API calls 
clear all
close all
clc

%% Credentials
Username = 'roberta.fornarelli@curtin.edu.au';
Password = 'Salsiccia01';
APIKey = 'e5eab7c1c1828d4cec4c398ed260421f';

%% Query parameters
DateStart = datetime(2018,07,23,'Format','yyyy-MM-dd');
DateEnd = datetime(2018,08,21,'Format','yyyy-MM-dd');
intervalLength = 30; % seconds

%% Define folder to save csv
cd R:\RENeW_Nexus-MORRIG-HU04892\EnergyOS_EoI_Data\
mkdir(sprintf('PowerData_Site_%d',intervalLength));

cd C:\Users\277803E\Documents\MATLAB\RENeW_Nexus\EOI_Energy

%% Get list of sites
api = 'https://renewnexus.energyos.com.au/habi-ws-renewnexus/api/v1/site';
url = [api];
options = weboptions('Username',Username,'Password',Password,'KeyName',APIKey,'Timeout',Inf);
SiteList = webread(url,options);

%% Get list of nodes for each site

SiteId = {SiteList.id}';
SiteId2 = string(SiteId);

for i = 1:size(SiteId2,1)
    
    SiteId_char = char(SiteId2(i,1));
    api = 'https://renewnexus.energyos.com.au/habi-ws-renewnexus/api/v1/site';
    url = [api,'/',SiteId_char,'/powerHistoryData'];
       
    U = matlab.net.URI(url);
    U.Query = matlab.net.QueryParameter('startDate',DateStart,'endDate',DateEnd,'intervalLength',intervalLength);
    options = weboptions('Username',Username,'Password',Password,'KeyName',APIKey,'RequestMethod','get','ArrayFormat','csv');
    filename = sprintf('PowerData_Site_%d.csv',str2double(SiteId_char));
    S = websave(filename,U,options);
    
    %cd R:\RENeW_Nexus-MORRIG-HU04892\EnergyOS_EoI_Data\
    %FolderToSave = sprintf('PowerData_Site_%d',intervalLength);
    %movefile(S,FolderToSave) 
    
    %cd C:\Users\277803E\Documents\MATLAB\RENeW_Nexus\EOI_Energy
    
end

