% Advent of Code
% Day 2
% Date: 2020/12/02
% Auth: Foad Alhayek

clear variables; close all; clc;

fid = fopen('aoc2_input.txt', 'r');

a = textscan(fid, '%d%d%s%s', 'Delimiter', ' ');
lowerLim = a{:, 1};
upperLim = -a{:, 2};
policy = regexprep(a{:, 3}, ':', '');
password = a{:, 4};

% Task 1 and 2
nValidPasswords1 = 0;
nValidPasswords2 = 0;

for i = 1:size(password, 1)
  logicalList = policy{i} == password{i};
  freq = sum(logicalList);
  
  if freq >= lowerLim(i) && freq <= upperLim(i)
    nValidPasswords1 = nValidPasswords1 + 1;
  end
  
  xnor1 = logicalList(lowerLim(i)) && ~logicalList(upperLim(i));
  xnor2 = ~logicalList(lowerLim(i)) && logicalList(upperLim(i));
  
  if xnor1 || xnor2
    nValidPasswords2 = nValidPasswords2 + 1;
  end
  
end

fprintf('Amount of valid passwords in task 1 are %d\n', nValidPasswords1);
fprintf('Amount of valid passwords in task 2 are %d\n', nValidPasswords2);
