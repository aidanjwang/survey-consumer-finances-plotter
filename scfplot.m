% Imports Survey of Consumer Finances Summary Extract Public Data, in Excel
% format, for 1989-2016 and plots trends of the average liquid assets for 
% young (25-50) and old (50-75) households. Values in 2015 U.S. dollars.

% Get age, survey weight, and liquid assets data from Excel files.
rawData = cell(1,10);
i = 1;
rawData{i} = getscfdata(i, 'CX');
i = 2;
rawData{i} = getscfdata(i, 'CZ');
i = 3;
rawData{i} = getscfdata(i, 'DG');
for i = 4 : 7
rawData{i} = getscfdata(i, 'EB');
end
for i = 8 : 9
rawData{i} = getscfdata(i, 'ED');
end
i = 10;
rawData{i} = getscfdata(i, 'EE');

% Calculate weighted average liquid assets for young and old households.
data = zeros(10, 3);
for i = 1 : 10
    youngWeightedLiq = 0;
    youngTotalWeight = 0;
    oldWeightedLiq = 0;
    oldTotalWeight = 0;
    raw = rawData{i};
    for r = 1 : length(raw)
        age = raw(r,1);
        if (age >= 25 && age < 50)
            youngWeightedLiq = youngWeightedLiq + raw(r,2) * raw(r,3);
            youngTotalWeight = youngTotalWeight + raw(r,3);
        elseif (age >= 50 && age < 75)
            oldWeightedLiq = oldWeightedLiq + raw(r,2) * raw(r,3);
            oldTotalWeight = oldTotalWeight + raw(r,3);    
        end
    end
    data(i,2) = youngWeightedLiq / youngTotalWeight;
    data(i,3) = oldWeightedLiq / oldTotalWeight;
end

% Convert dollar values to 2015 dollar values.
JUL_2015_CPI = 237.876;
JUL_2016_CPI = 239.898;
data = (JUL_2015_CPI / JUL_2016_CPI) .* data;

% Plot average liquid assets for young and old households vs year.
for i = 1 : 10
    data(i,1) = 1986 + 3*i;
end
figure
plot(data(:,1), data(:,2), data(:,1), data(:, 3))
ylabel('Average liquid assets, USD (2015)')
xlabel('Year')
title({'Average liquid assets for young and old households';
    'in the U.S. from 1989 - 2016'})
legend('Young households (25-50)','Old households (50-75)','Location',...
    'southeast')
