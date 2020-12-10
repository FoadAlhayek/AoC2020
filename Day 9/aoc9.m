% Advent of Code
% Day: 9
% Date: 2020/12/09
% Auth: Foad Alhayek

clear variables; close all; clc;

data = importdata('aoc9_input.txt');

% Only 25 are active at once
n = 25;
i = 0;
imposter = false;

while ~imposter
  i = i + 1;
  setOfNo = data(i:n+(i - 1));
  nextNo = data(n+i);
  
  for j = 1:n
    indexPair = find(setOfNo == nextNo - setOfNo(j));
    indexPair = indexPair(indexPair ~= j);
    
    if ~isempty(indexPair)
      imposter = false;
      break;
    else
      imposter = true;
      imposterNo = nextNo;
    end
  end
  
end

% Task 2 - Find the of contiguous set which adds up to imposterNo
foundSet = false;
i = 1;
j = 1;

while ~foundSet
  i = i + 1;
  sumOfSet = sum(data(j:(2+i)));    % Must be at least 2
  
  if sumOfSet == imposterNo
    contiguousSet = data(j:(2+i));
    minMaxSum = sum([min(contiguousSet), max(contiguousSet)]);
    foundSet = true;
  elseif sumOfSet > imposterNo
      i = 1;
      j = j + 1;
  end
  
end

fprintf(['Task 1: The imposter number is %d\nTask 2: Contiguous set max ', ...
  'and min sum value is %d\n'], imposterNo, minMaxSum)
