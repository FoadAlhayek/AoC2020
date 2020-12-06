% Advent of Code
% Day: 6
% Date: 2020/12/06
% Auth: Foad Alhayek

clear variables; close all; clc;

fid = fopen('aoc6_input.txt', 'r');

% Initialize
char2ind = int32('a') - 1;
questions1 = zeros(1, 26);    % 26 letters from a-z
questions2 = zeros(1, 26);
totalSum1 = 0;
totalSum2 = 0;
nPeople = 0;

while ~feof(fid)
  readline = fgetl(fid);
  index = int32(readline) - char2ind;
  
  questions1(index) = 1;
  questions2(index) = questions2(index) + 1;
  nPeople = nPeople + 1;
  
  % Sum up and reset for new group
  if isempty(readline) || feof(fid)
    totalSum1 = totalSum1 + sum(questions1);
    questions1 = zeros(1, 26);
    
    % Empty line
    if ~feof(fid)
      nPeople = nPeople - 1;  
    end
    
    totalSum2 = totalSum2 + length(find(questions2 == nPeople));
    questions2 = zeros(1, 26);
    nPeople = 0;
  end
  
end

fclose(fid);

fprintf('Task 1 total sum: %d\nTask 2 total sum: %d\n', ...
  totalSum1, totalSum2);
