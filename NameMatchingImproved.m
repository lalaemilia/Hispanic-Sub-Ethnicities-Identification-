%Emily Rivera
%Matching last names and pulling percentages from FullListofNames
clear
clc

%read in necessary data
county = readtable('PAS_clean.xlsx'); %county.ZIP
names = readcell('FullListofNames.xlsx'); %zips.ZIP
names = names(:, 1:38);

%% Last Names
f = waitbar(0,'Please wait...');
fileID = 'PercentsLastNames.csv';
[~, ~, raw] = xlsread(fileID);
try raw(2:end, :) = []; %if file already has data, clearing data
catch
end
for i=1:size(county,1) %through each person
    dataTemp= [];
    ln = lower(county.NameLast(i));
    ln = regexprep(ln,'(\<[a-z])','${upper($1)}');
    dataTemp = {county.VoterID(i), ln{:}};
    for j=1:2:size(names,2)
        rowNums = find(strcmp(ln, names(:,j)));
        try
            percent = names{rowNums, 2};
            if ismissing(percent)
                percent = 0;
            end
        catch
            percent = 0;
        end
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
end %end for going through county file
xlswrite(fileID, raw);
close(f);
%% Second Last Names
f = waitbar(0,'Please wait...');
fileID = 'PercentsSecondLastNames.csv';
[~, ~, raw] = xlsread(fileID);
try raw(2:end, :) = []; %if file already has data, clearing data
catch
end
for i=1:size(county,1) %through each person
    dataTemp= [];
    sln = lower(county.NameSecondLast(i));
    sln = regexprep(sln,'(\<[a-z])','${upper($1)}');
    dataTemp = {county.VoterID(i), sln{:}};
    for j=1:2:size(names,2)
        rowNums = find(strcmp(sln, names(:,j)));
        try
            percent = names{rowNums, 2};
            if ismissing(percent)
                percent = 0;
            end
        catch
            percent = 0;
        end
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
end %end for going through county file
xlswrite(fileID, raw);
close(f);
%% First Names
f = waitbar(0,'Please wait...');
names = readcell('FirstNames.xlsx'); %zips.ZIP
fileID = 'PercentsFirstNames.csv';
[~, ~, raw] = xlsread(fileID);
try raw(2:end, :) = []; %if file already has data, clearing data
catch
end
for i=1:size(county,1) %through each person
    dataTemp= [];
    fn = lower(county.NameFirst(i));
    fn = regexprep(fn,'(\<[a-z])','${upper($1)}');
    dataTemp = {county.VoterID(i), fn{:}};
    for j=1:2:size(names,2)
        rowNums = find(strcmp(fn, names(:,j)));
        try
            percent = names{rowNums, 2};
            if ismissing(percent)
                percent = 0;
            end
        catch
            percent = 0;
        end
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
end %end for going through county file
xlswrite(fileID, raw);
close(f);
%% Middle Names
f = waitbar(0,'Please wait...');
names = readcell('FullListofNames.xlsx'); %zips.ZIP
names = names(:, 1:38);
fnames = readcell('FirstNames.xlsx'); %zips.ZIP
fileID = 'PercentsMiddleNames.csv';
[~, ~, raw] = xlsread(fileID);
try 
    raw(2:end, :) = []; %if file already has data, clearing data
catch
end
for i=1:size(county,1) %through each person
    dataTemp= [];
    mn = lower(county.NameMiddle(i));
    mn = regexprep(mn,'(\<[a-z])','${upper($1)}');
    dataTemp = {county.VoterID(i), mn{:}};
    
    for j=1:2:size(names,2)
        rowNums = find(strcmp(mn, names(:,j)));
        try
            percent = names{rowNums, 2};
            if ismissing(percent)
                percent = 0;
            end
        catch
            percent = 0;
        end
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
    
    for j=1:2:size(names,2)
        rowNums2 = find(strcmp(mn, fnames(:,j)));
        try
            if dataTemp{x} > 0 
                percent = dataTemp{x} * fnames{rowNums, 2};
            else 
                percent = fnames{rowNums, 2}; 
            end
            if ismissing(percent)
                percent = 0;
            end
        catch
            percent = 0;
        end
        dataTemp{x} = percent;
    end
    %normalizing again
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
end %end for going through county file
xlswrite(fileID, raw);
close(f);