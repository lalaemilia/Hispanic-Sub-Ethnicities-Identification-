%Combining probabilities for each sub ethnicity for each person for zip
%codes, and last, first, and middle names 

clear; 
clc; 
%Loading in Data 
zips = readcell('PercentsBasedOnZips.csv');
lastNames = readcell('PercentsBasedOnLastNames.csv'); 
firstNames = readcell('PercentsBasedOnFirstNames.csv'); 
secondLastNames = readcell('PercentsBasedOnMiddleNames.csv'); 
%middleNames = readcell('PercentsBasedOnMiddleNames.csv') 
i=97301; %Miguel Flores   
%% Actual Computation 
