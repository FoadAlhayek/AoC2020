% Advent of Code
% Day 10
% Date: 2020/12/10
% Auth: Foad Alhayek

clear variables; close all; clc;

data = importdata('aoc10_input.txt');
deviceVolt = max(data) + 3;    % Device voltage
nData = size(data, 1);

% Add starting and device voltage
data(nData + 1) = 0;
data(nData + 2) = deviceVolt;

% Sort the data and compute the difference
data = sort(data);
dataDiff = diff(data);

% Add up and solve
sumNOnes = sum(size(dataDiff(dataDiff == 1), 1));
sumNThrees = sum(size(dataDiff(dataDiff == 3), 1));
solution1 = sumNOnes*sumNThrees;

% Task 2 - N different arrangements
lenOfConsecutive = [];
consecutiveNo = 1;
i = 0;

while i < length(dataDiff)
  
  i = i + 1;
  if data(i) + 1 == data(i + 1)
    consecutiveNo = consecutiveNo + 1;
  else
    lenOfConsecutive = [lenOfConsecutive; consecutiveNo];
    consecutiveNo = 1;
  end
end

% We are only interested of consecutive numbers that are larger than 2.
% Why? Because ex: 1,2 can only be written as 1,2 due first and last number
% are "static". For ex. 1,2,3 we get 1,2,3 and 1,3, thus 2 combinations.
% For ex. 1,2,3,4 we get 1,2,3,4 - 1,3,4 - 1,2,4 and 1,4, thus 4
% combinations. On further investigation one can notice it will eventually
% follow a modified tribonacci formula where if we only have 1 digit we get
% 1 and for 0 digits we get 0. Thus the pattern will be 0, 1, 1, 2, 4, 7,
% 13, 24, 44 etc.
% Modified tribonacci due to the offset is n = 0, 1... and not n = 1, 2...

lenOfConsecutive = sort(lenOfConsecutive(lenOfConsecutive > 2));
nConsecutive = length(lenOfConsecutive);
solution2 = 1;

for i = 1:nConsecutive
  tribonacci = [0, 1, 1];
  lenC = lenOfConsecutive(i) - 2;   % -2 due to we start at n = 2
  for j = 1:lenC
    nextNo = sum(tribonacci);
    lenOfConsecutive(j);
    tribonacci(1:2) = tribonacci(2:3);
    tribonacci(3) = nextNo;
  end
  solution2 = solution2 * nextNo;
end

fprintf('Task 1: %d\nTask 2: %d\n', solution1, solution2)
