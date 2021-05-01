%Emily Rivera
%Matching zip codes and pulling percentages from FloridasZipCodesFinal
clear
clc

county = readtable('PAS_clean.xlsx'); %county.ZIP
zips = readtable('FloridasZipCodesFinal.xlsx'); %zips.ZIP
subEthnicities = zips.Properties.VariableNames;
%%
f = waitbar(0,'Please wait...');
fileID = 'ZipCodes.csv';
[~, ~, raw] = xlsread(fileID);
raw = raw(:, 1:21);
try raw(2:end, :) = []; %if file already has data, clearing data
catch
end
for i = 1:size(county,1)
    percent=0;
    dataTemp=[];
%     i =35992;%my mom
    dataTemp = {county.VoterID(i),[county.NameFirst{i},county.NameLast{i}]};
    row = find(county.ZIP(i) == zips.ZIP);
    for k = 7:2:size(zips,2)-11
        percent = zips{row, k};
        dataTemp = [dataTemp, percent];
    end
    %normalization of data
    dataTempSum = sum(cell2mat(dataTemp(3:end)));
    for x=3:length(dataTemp)
        if dataTempSum ~= 0
            try
                dataTemp{x} = dataTemp{x}/dataTempSum;
            catch
                dataTemp{x} = 0;
            end
        end
    end
    raw = [raw; dataTemp];
    
    waitbar(i/size(county,1),f,'Loading your data');
end
%%
xlswrite(fileID, raw);
close(f)
fclose('all');




