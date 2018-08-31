%% Work through the raw csv files donwnloaded from EnergyOS
clear all
close all
clc

intervalLength = 1800; % seconds

cd R:\RENeW_Nexus-MORRIG-HU04892\EnergyOS_EoI_Data\

FolderToOpen = sprintf('PowerData_Site_%d',intervalLength);
cd(FolderToOpen)

list = ls('*.csv');
for i = 1:size(list,1)
    filename(i,1) = fullfile(pwd,{list(i,:)});
end

cd C:\Users\277803E\Documents\MATLAB\RENeW_Nexus\EOI_Energy

%% Power data
for t = 1:size(filename,1)
    
    delimiter = ',';
    temp = readtext(filename{t,1},delimiter)';
    temp2 = regexp(temp, ':', 'split');
       
    for i = 1:size(temp2,1)
        datakey{i,1} = [temp2{i,1}(1,1)];
        datavalue(i,1) = str2double(vertcat(temp2{i,1}(1,end)));
    end

    % Select a subest of variables of interest
    DataKey_subset{1,1} ='NodeId'; DataKey_subset{1,2} = datakey{1,1};
    DataKey_subset{2,1} ='Timestamp'; DataKey_subset{2,2} = datakey{2,1};
    DataKey_subset{3,1} ='Power'; DataKey_subset{3,2} = datakey{3,1};
    DataKey_subset{4,1} ='PowerImporting'; DataKey_subset{4,2} = datakey{4,1};
    DataKey_subset{5,1} ='PowerImportingFromGrid'; DataKey_subset{5,2} = datakey{6,1};
    DataKey_subset{6,1} ='PowerExporting'; DataKey_subset{6,2} = datakey{8,1};
    DataKey_subset{7,1} ='PowerExportingToGrid'; DataKey_subset{7,2} = datakey{10,1};
    DataKey_subset{8,1} ='PowerConsuming'; DataKey_subset{8,2} = datakey{12,1};
    DataKey_subset{9,1} ='PowerGenerating'; DataKey_subset{9,2} = datakey{14,1};
    DataKey_subset{10,1} ='PowerGeneratingAndConsuming'; DataKey_subset{10,2} = datakey{16,1};
    DataKey_subset{11,1} ='PowerConsumingFromGenerating'; DataKey_subset{11,2} = datakey{20,1};
    DataKey_subset{12,1} ='SiteId'; DataKey_subset{12,2} = datakey{28,1};
    
    % NodeId and SiteId in the same vector
    k = 1;
    for i = 1:(size(datavalue,1)-1)
        ans = strcmp(datakey{i,1},DataKey_subset{1,2}) || strcmp(datakey{i,1},DataKey_subset{end,2});
            if ans == 1
                NodeId_SiteId(k,1) = datavalue(i,1);
                k = k+1;
            end
    end
    
    % Others
    k = 1;
    for j = 2:(size(DataKey_subset,1)-1)
        for i = 1:size(datavalue,1)
            ans = strcmp(datakey{i,1},DataKey_subset{j,2});
            if ans == 1
                temp3(k,1) = datavalue(i,1);
                k = k+1;
            end
        end
        eval(sprintf('Var_%d = temp3',j));
        temp3 = [];
        k = 1;
    end
    
    % Rename variables
    Timestamp = Var_2; Var_2 = [];
    Power = Var_3; Var_3 = [];
    PowerImporting = Var_4; Var_4 = [];
    PowerImportingFromGrid = Var_5; Var_5 = [];
    PowerExporting = Var_6; Var_6 = [];
    PowerExportingToGrid = Var_7; Var_7 = [];
    PowerConsuming = Var_8; Var_8 = [];
    PowerGenerating = Var_9; Var_9 = [];
    PowerGeneratingAndConsuming = Var_10; Var_10 = [];
    PowerConsumingFromGenerating = Var_11; Var_11 = [];
    
    % Create time variable
    Time = datetime(Timestamp, 'ConvertFrom', 'posixtime' ,'TimeZone','+10:00');
    Time2 = datevec(Time);
    Year = Time2(:,1); Month = Time2(:,2); Day = Time2(:,3); 
    Hour = Time2(:,4); Minute = Time2(:,5); Sec = Time2(:,6);
    
    % Specify name of each nodeId
    SiteId = string(NodeId_SiteId(1,1));
    SiteId_char = char(SiteId);
    
    tmp = 'R:\RENeW_Nexus-MORRIG-HU04892\EnergyOS_EoI_Data\NodeSummary_Site';
    filename_nodeId = [tmp,'\NodeSummary_Site_',SiteId_char,'.xlsx'];
    temp_nodeId = readtable(filename_nodeId);
    NodeName = {};
    
    for i = 1:size(NodeId_SiteId,1)
        index = find(NodeId_SiteId(i,1) == temp_nodeId.id(:,1));
        if isfinite(index)
            NodeName{i,1} = temp_nodeId.name(index,1);
        else
            NodeName{i,1} = 'SiteId';
        end
    end
    
    % Create table to export as csv
    
    DataTable = table(Timestamp,Year,Month,Day,Hour,Minute,Sec,NodeId_SiteId,NodeName,Power,PowerImporting,PowerImportingFromGrid,PowerExporting,PowerExportingToGrid,PowerConsuming,PowerGenerating,PowerGeneratingAndConsuming,PowerConsumingFromGenerating);
    
    writetable(DataTable,sprintf('PowerData_Site_%d_%d_L1.csv',datavalue(1,1),intervalLength));
    
    % Move to R drive
    list = ls('*.csv');
    f = fullfile(pwd,list);
    movefile(f,'R:\RENeW_Nexus-MORRIG-HU04892\EnergyOS_EoI_Data\PowerData_Site_1800_L1') 
    list = [];
        
    temp = []; temp2 = []; datakey = []; datavalue = []; 
    Time = []; Time2 = []; Year = []; Month = []; Day = []; Hour = []; Minute = []; Sec = [];
    
    Timestamp = []; NodeId_SiteId = []; NodeName = []; Power = []; PowerImporting = [];
    PowerImportingFromGrid = []; PowerExporting = []; PowerExportingToGrid = [];
    PowerConsuming = []; PowerGenerating = []; PowerGeneratingAndConsuming = [];
    PowerConsumingFromGenerating = []; DataTable = [];
    
end


%% Second method
%    
%     % Get rid off unwanted variables
%     k = 1;
%     for i = 1:size(datavalue,1)
%         for j = 1:size(DataKey_subset,1)
%             ans = strcmp(datakey{i,1},DataKey_subset{j,2});
%             if ans == 1
%                 datakey2{k,1} = datakey{i,1};
%                 datavalue2(k,1) = datavalue(i,1);
%                 k = k+1;
%             end
%         end
%     end
%     
%     VarNo = size(DataKey_subset,1) - 1;
%     ind = [1:VarNo:size(datavalue2,1)]';
%     
%     k = 1;
%     for i = 1:(size(ind,1)-1)
%         temp_datavalue2 = datavalue2(ind(i):(ind(i)+VarNo-1),:);
%         datavalue3(k,1:VarNo) = temp_datavalue2(:,1)';
%         k = k+1;
%         temp_datavalue2 = [];
%     end
%     
%     % Create table and save in csv file
%     Time = datetime(datavalue3(:,2), 'ConvertFrom', 'posixtime' ,'TimeZone','+10:00');
%     Time2 = datevec(Time);
%     
%     Year = Time2(:,1); Month = Time2(:,2);
%     Day = Time2(:,3); Hour = Time2(:,4);
%     Minute = Time2(:,5); Sec = Time2(:,6);
%     
%     SiteId_NodeId = datavalue3(:,1); Timestamp = datavalue3(:,2);
%     Power = datavalue3(:,3); PowerImporting = datavalue3(:,4); PowerImportingFromGrid = datavalue3(:,5);
%     PowerExporting = datavalue3(:,6); PowerExportingToGrid = datavalue3(:,7);
%     PowerConsuming = datavalue3(:,8); PowerGenerating = datavalue3(:,9);
%     PowerGeneratingAndConsuming = datavalue3(:,10); PowerConsumingFromGenerating = datavalue3(:,11);
%     
