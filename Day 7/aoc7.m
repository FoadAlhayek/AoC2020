% Advent of Code
% Day: 7
% Date: 2020/12/07
% Auth: Foad Alhayek

clear variables; close all; clc;

fid = fopen('aoc7_input.txt', 'r');

% Initialize
colorInfo = struct([]);
searchQueue = struct('match', []);
currentSearch = 'shiny gold';
i = 1;
run = 1;

% Search through all unique bags
tic
while ~isempty(currentSearch)
  readline = fgetl(fid);
  splitIndex = regexp(readline, 'contain');
  
  % Rewrite so struct can handle it
  currentColor = regexprep(readline(1:(splitIndex - 7)), '\s', '_'); 
  otherColors = readline((splitIndex + 8):end);  % 8 char for contain & ws
  
  otherColorInfo = regexp(otherColors,'\w*.\w*.(?= bag)','match');
  
  % This if-statement is for task 2
  if run == 1
    amountInfo = regexp(readline,'\d+','match');
    currentInfo = struct('color', otherColorInfo, 'amount', amountInfo);
    colorInfo(1).(currentColor) = currentInfo;
  end

  if any(strcmp(otherColorInfo, currentSearch))
    if ~any(strcmp({searchQueue.match}, currentColor))  % Unique check
      searchQueue(i).match = currentColor;
      i = i + 1;
    end
  end
  
  % Reset and re-search
  if feof(fid)
    try 
      currentSearch = regexprep(searchQueue(run).match, '_', ' ');
      run = run + 1;
      frewind(fid);
    catch
      break;
    end
  end
  
end
toc

nUniqueBags = size(searchQueue, 2);

% Task 2
% Similar as task 1 but we search from the other end instead
frewind(fid);
searchQueue = struct('match', []);
currentSearch = 'shiny gold';
i = 1;
run = 1;

tic
while ~isempty(currentSearch)
  readline = fgetl(fid);
  splitIndex = regexp(readline, 'contain');
  
  % Rewrite so struct can handle it
  currentColor = regexprep(readline(1:(splitIndex - 7)), '\s', '_'); 
  otherColors = readline((splitIndex + 8):end);  % 8 char for contain & ws
  
  otherColorInfo = regexp(otherColors,'\w*.\w*.(?= bag)','match');
  
  if any(strcmp(currentColor, currentSearch))
    if ~any(strcmp({searchQueue.match}, currentColor))  % Unique check
      searchQueue(i).match = currentColor;
      i = i + 1;
    end
  end
  
  % Reset and re-search
  if feof(fid)
    try 
      currentSearch = regexprep(searchQueue(run).match, '_', ' ');
      run = run + 1;
      frewind(fid);
    catch
      break;
    end
  end
  
  amountInfo = regexp(readline,'\d+','match');
end
toc

fclose(fid);
% 261
fprintf('Task 1: %d\n', nUniqueBags)
