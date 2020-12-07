% Advent of Code
% Day: 7
% Date: 2020/12/07
% Auth: Foad Alhayek

clear variables; close all; clc;

fid = fopen('aoc7_input.txt', 'r');

% Initialize
colorInfo = struct([]);
searchInfo = struct('match', []);
currentSearch = 'shiny gold';
i = 1;
j = 1;

% Search through all unique bags
tic
while ~isempty(currentSearch)
  readline = fgetl(fid);
  splitIndex = regexp(readline, 'contain');
  
  % Rewrite so struct can handle it
  currentColor = regexprep(readline(1:(splitIndex - 7)), '\s', '_'); 
  otherColors = readline((splitIndex + 8):end);  % 8 char for contain & ws
  
  otherColorInfo = regexp(otherColors,'\w*.\w*.(?= bag)','match');

  if any(strcmp(otherColorInfo, currentSearch))
    % Only store unique colors
    if ~any(strcmp({searchInfo.match}, currentColor))
      searchInfo(i).match = currentColor;
      i = i + 1;
    end
  end
  
  % Reset and re-search
  if feof(fid)
    try 
      currentSearch = regexprep(searchInfo(j).match, '_', ' ');
      j = j + 1;
      frewind(fid);
    catch
      break;
    end
  end
  
end
toc

fclose(fid);
% 261
fprintf('Task 1: %d\n', size(searchInfo, 2))
