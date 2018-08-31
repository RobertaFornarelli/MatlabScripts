% Extract data from Web Service API qith Matlab 

% https://au.mathworks.com/help/matlab/ref/webread.html
% https://au.mathworks.com/help/matlab/internet-file-access.html

% https://jsonplaceholder.typicode.com/

% https://renewnexus.energyos.com.au/habi-ws-renewnexus/api/v1/site

%% List of sites
clear all
api = 'https://renewnexus.energyos.com.au/habi-ws-renewnexus/api/v1/site';
url = [api];
options = weboptions('Username','roberta.fornarelli@curtin.edu.au','Password','Salsiccia01','KeyName','e5eab7c1c1828d4cec4c398ed260421f');
S = webread(url,options);

%% List of nodes per site
clear all
SiteId = [cellstr('20') cellstr('20')];
SiteId_char = char(SiteId(1,1));

LoadSite = 
api = 'https://renewnexus.energyos.com.au/habi-ws-renewnexus/api/v1/site';
url = [api,'/',SiteId_char,'/meter'];

options = weboptions('Username','roberta.fornarelli@curtin.edu.au','Password','Salsiccia01','KeyName','e5eab7c1c1828d4cec4c398ed260421f');
S_meter_summary = webread(url,options);

%% Power data
api = 'https://renewnexus.energyos.com.au/habi-ws-renewnexus/api/v1/site';
url = [api '/20/powerHistoryData'];

U = matlab.net.URI(url);
DateStart = datetime(2018,08,12,'Format','yyyy-MM-dd');
DateEnd = datetime(2018,08,12,'Format','yyyy-MM-dd');
intervalLength = 3600; %5 seconds

U.Query = matlab.net.QueryParameter('startDate',DateStart,'endDate',DateEnd,'intervalLength',intervalLength);

options = weboptions('Username','roberta.fornarelli@curtin.edu.au','Password','Salsiccia01','KeyName','e5eab7c1c1828d4cec4c398ed260421f','RequestMethod','get','ArrayFormat','csv');
file = 'test.csv';
S = websave(file,U,options,'startDate',DateStart,'endDate',DateEnd,'intervalLength',intervalLength);

delimiter = ',';
temp = readtext(S,delimiter);
temp2 = regexp(temp, ':', 'split')';

for i = 1:size(temp2,1)
    datakey{i,1} = [temp2{i,1}(1,1)];
    datakey{i,2} = [temp2{i,1}(1,2)];
    datavalue(i,1) = str2double(vertcat(temp2{i,1}(1,end)));
end

DataKey_subset = [datakey{1,1};datakey{2,1};datakey{3,1};datakey{4,1};datakey{6,1};datakey{8,1};datakey{10,1};datakey{12,1};datakey{14,1};datakey{28,1}];

k = 1;
for i = 1:size(datavalue,1)
   for j = 1:size(DataKey_subset,1)
       ans = strcmp(datakey{i,1},DataKey_subset{j,1});
       if ans == 1
            datakey2{k,1} = datakey{i,1};
            datakey2{k,2} = datakey{i,2};
            datavalue2(k,1) = datavalue(i,1);
            k = k+1;
        end
    end
end

VarNo = size(DataKey_subset,1) - 1;
ind = [1:VarNo:size(datavalue2,1)]';

k = 1;
for i = 1:(size(ind,1)-1)
   
       temp_datakey2 = {datakey2{ind(i):(ind(i)+VarNo-1),1}}';
       temp_datavalue2 = datavalue2(ind(i):(ind(i)+VarNo-1),:);
       
       datakey3(:,k) = {temp_datakey2{:,1}}';
       datavalue3(k,1:VarNo) = temp_datavalue2(:,1)';
       k = k+1;
       
       temp_datakey2 = [];
       temp_datavalue2 = [];
end

time = datetime(datavalue3(:,2), 'ConvertFrom', 'posixtime' ,'TimeZone','+10:00');
time2 = datevec(time);

k = 1;
for i = 1:size(datavalue3,1)
    if datavalue3(i,1) == 20
        datavalue3_20(k,:) = datavalue3(i,:);
        k = k+1;
    end
end




       
       
  
        




































https://au.mathworks.com/matlabcentral/answers/297520-filter-a-struct-based-on-the-field-name
cell2struct(datakey);
fieldnames(temp)




curl -X GET -u 'roberta.fornarelli@curtin.edu.au:e5eab7c1c1828d4cec4c398ed260421f' -H 'Accept:csv' https://renewnexus.energyos.com.au/habi-ws-renewnexus/api/v1/site/<site ID>/powerHistoryData



temps = [S.data];
years = [S.year];

api = 'http://climatedataapi.worldbank.org/climateweb/rest/v1/';
url = [api 'country/cru/tas/year/USA'];
S = webread(url);
temps = [S.data];
years = [S.year];


api = 'https://jsonplaceholder.typicode.com/';
url = [api 'comments'];
S = webread(url,"postId",1,"id",1,"id",2,"id",3);


api = 'https://myeddy.info/habi-ws-eddy/#/';
url = [api 'aggregation'];
S = webread(url);


% Example of Dan's script coded in Phyton to extract data between two dates or after a certain date

% def get_by_date(start_date, completion_date, sentinel_number):
% Retreive a list of satellite metadata files that were collected between two dates.  Retuns json array
% param start_date: The start date the files were collected from the sensor
% param completion_date: The end date the files were collected from the sensor
% param sentinel_number:
% return: .JSON array containing all the metadata

url_opener = saraclient.makeUrlOpener()
sentinel = sentinel_number
param_list = ['startDate={}'.format(start_date), 'completionDate={}'.format(completion_date)]
results = saraclient.searchSara(url_opener, sentinel, param_list)
return results

% def get_published_after(sentinel_number, published_date):
% Retrieve a list of satellite metadata files that were published after a particular date.
% The published date is the date that it was made public at the NCI.  Not the date it was collected
% param sentinel_number: The major sentinel number.  i.e. 2  not 2a
% param published_date: The date the files were published at the NCI
% return: .JSON array containing all the metadata

url_opener = saraclient.makeUrlOpener()
sentinel = sentinel_number
param_list = ['publishedAfter={}'.format(published_date)]
results = saraclient.searchSara(url_opener, sentinel, param_list)
return results



