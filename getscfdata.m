function [ data ] = getscfdata( idata, liqColumn )
% Imports age, liq, and wgt data for the given data index (year) and with 
% the given column containing liq data, from Excel files in the format: 
% SCFP[YEAR].xlsx

disp(strcat('Importing SCFP', num2str(1986 + 3*idata),'.xlsx data...'))
age = xlsread(strcat('SCFP', num2str(1986 + 3*idata),'.xlsx'),'E:E');
wgt = xlsread(strcat('SCFP', num2str(1986 + 3*idata),'.xlsx'),'C:C');
liq = xlsread(strcat('SCFP', num2str(1986 + 3*idata),'.xlsx'),...
    strcat(liqColumn,':',liqColumn));
data = [age liq wgt];
