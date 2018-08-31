
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
T1 = text1(2:end,1);
[y,m,d,h,min] = datevec(T1,'dd/mm/yyyy HH:MM');
sec = zeros(size(y,1),1);
TT1 = datetime(y,m,d,h,min,sec,'TimeZone','UTC');
TT1.TimeZone = '+08:00';
[y,m,d,h,min,sec] = datevec(TT1);
TTT1 = datenum(y,m,d,h,min,sec);
TTT1(:,2:6)=([y m d h min]);
data = data1(2:end,2:end);
temp1 = [TTT1 data];
y=[];m=[];d=[];h=[];min=[];sec=[];data=[];

file_name_open2 = file2;
fid2=fopen(file_name_open2);
data2 = readtext(file_name_open2,delimiter, comment, quotes, option1);
text2 = readtext(file_name_open2,delimiter, comment, quotes, option2);
T2 = text2(2:end,1);
[y,m,d,h,min,sec] = datevec(T2,'yyyy-mm-dd HH:MM:SS');
TT2 = datetime(y,m,d,h,min,sec,'TimeZone','UTC');
TT2.TimeZone = '+08:00';
[y,m,d,h,min,sec] = datevec(TT2);
TTT2 = datenum(y,m,d,h,min,sec);
TTT2(:,2:6)=([y m d h min]);
data = data2(2:end,2:end);
temp2 = [TTT2 data];

DataKey_file1 = text1(1,:)';
DataKey_file2 = text2(1,:)';
DataKey_Time = {'Date';'Year';'Month';'Day';'Hour';'Min'};
DataKey = [DataKey_Time;DataKey_file1(2:end,1)];

temp = [temp1;temp2];
temp = sortrows(temp,1);

end

