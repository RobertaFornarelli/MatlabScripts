
function [ temp,DataKey,DataKey_file1,DataKey_file2 ] = DataImportCSV( file1,file2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

delimiter = ',';
comment   = '';
quotes    = '';
option1   = 'numeric';
option2   = 'textual';

file_name_open1 = file1;
fid1=fopen(file_name_open1);
data1 = readtext(file_name_open1,delimiter, comment, quotes, option1);
text1 = readtext(file_name_open1,delimiter, comment, quotes, option2);

file_name_open2 = file2;
fid2=fopen(file_name_open2);
data2 = readtext(file_name_open2,delimiter, comment, quotes, option1);
text2 = readtext(file_name_open2,delimiter, comment, quotes, option2);

T = [text1(2:end,1);text2(2:end,1)];
[y,m,d,h,min,sec] = datevec(T,'yyyy-mm-dd HH:MM:SS');
TT = datetime(y,m,d,h,min,sec,'TimeZone','UTC');
TT.TimeZone = '+08:00';
[y,m,d,h,min,sec] = datevec(TT);
TTT = datenum(y,m,d,h,min,sec);
TTT(:,2:6)=([y m d h min]);

DataKey_file1 = text1(1,:)';
DataKey_file2 = text2(1,:)';
DataKey_Time = {'Date';'Year';'Month';'Day';'Hour';'Min'};
DataKey = [DataKey_Time;DataKey_file1(2:end,1)];

data = [data1(2:end,2:end);data2(2:end,2:end)];
temp = [TTT data];
temp = sortrows(temp,1);

end

