% Extract data from Energy OS platform through API calls 
clear all
close all
clc

%% Credentials
Username = 'roberta.fornarelli@curtin.edu.au';
Password = 'Salsiccia01';
APIKey = 'e5eab7c1c1828d4cec4c398ed260421f';

%% Get list of sites
api = 'https://renewnexus.energyos.com.au/habi-ws-renewnexus/api/v1/site';
url = [api];
options = weboptions('Username',Username,'Password',Password,'KeyName',APIKey);
SiteList = webread(url,options);
filename = sprintf('SiteList.xlsx');
writetable(struct2table(SiteList),filename)

list = ls('*.xlsx');
f = fullfile(pwd,list);
movefile(f,'R:\RENeW_Nexus-MORRIG-HU04892\EnergyOS_EoI_Data')


%% Get list of nodes for each site

SiteId = {SiteList.id}';
SiteId2 = string(SiteId);

for i = 1:size(SiteId2,1)
    SiteId_char = char(SiteId2(i,1));
    api = 'https://renewnexus.energyos.com.au/habi-ws-renewnexus/api/v1/site';
    url = [api,'/',SiteId_char,'/meter'];
    options = weboptions('Username',Username,'Password',Password,'KeyName',APIKey);
    S_meter_summary = webread(url,options);
    eval(sprintf('NodeSummary_Site_%d = S_meter_summary',str2double(SiteId_char)));
    
    if isempty(S_meter_summary)
       xx = 0;
    else
        % Save in spreadsheet
        filename = sprintf('NodeSummary_Site_%d.xlsx',str2double(SiteId_char));
        writetable(struct2table(S_meter_summary),filename)
        % Move to R drive
        list = ls('*.xlsx');
        f = fullfile(pwd,list);
        movefile(f,'R:\RENeW_Nexus-MORRIG-HU04892\EnergyOS_EoI_Data\NodeSummary_Site') 
        list = [];
        
    end
    
end

save(SiteList_SiteNodes)



    



