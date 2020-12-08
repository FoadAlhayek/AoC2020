% Advent of Code
% Day: 7
% Date: 2020/12/07
% Auth: Foad Alhayek

clear variables; close all; clc;

fid = fopen('aoc7_input.txt', 'r');

% Initialize
colorInfo = struct([]);
searchedBags = struct('match', []);
currentSearch = 'shiny_gold';
i = 1;
run = 1;

% Search through all unique bags
while ~isempty(currentSearch)
  readline = fgetl(fid);
  splitIndex = regexp(readline, 'contain');
  
  % Rewrite so struct can handle it
  currentColor = regexprep(readline(1:(splitIndex - 7)), '\s', '_'); 
  otherColors = readline((splitIndex + 8):end);  % 8 char for contain & ws
  
  otherColorInfo = regexprep(...
    regexp(otherColors,'\w*.\w*.(?= bag)','match'), '\s', '_');
  
  % This if-statement is for task 2 - save what each bag contains
  if run == 1
    amountInfo = regexp(readline,'\d+','match');
    currentInfo = struct('color', otherColorInfo, 'amount', amountInfo);
    colorInfo(1).(currentColor) = currentInfo;
  end
  
  % Store all unique colors in queue to be searched if matched
  if any(strcmp(otherColorInfo, currentSearch))
    if ~any(strcmp({searchedBags.match}, currentColor))
      searchedBags(i).match = currentColor;
      i = i + 1;
    end
  end
  
  % Reset and re-search
  if feof(fid)
    try 
      currentSearch = searchedBags(run).match;
      run = run + 1;
      frewind(fid);
    catch
      break;  % All bags have been searched
    end
  end
  
end

fclose(fid);

nUniqueBags = size(searchedBags, 2);

% Task 2
currentSearch = 'shiny_gold';

searchQueue = struct('queue', []);
colorHistory = struct([]);

queueIndex = 1;
sumOfBags = 0;
previousAmount = 1;

% Initialize
currentInfo = struct('color', currentSearch, 'amount', previousAmount);
colorHistory(1).(currentSearch) = currentInfo;
searchQueue(1).queue = currentSearch;

% NOTE: What a bag contains is NOT unique!
while ~isempty(currentSearch)
  % Info of what the current bag contains
  bagColors = {colorInfo.(regexprep(currentSearch, '\d', '')).color};
  bagAmount = {colorInfo.(regexprep(currentSearch, '\d', '')).amount};
  
  % Check how many we have of the current bag
  previousAmount = colorHistory.(currentSearch).amount;
  
  % Get the new amount and sum up
  newAmount = previousAmount*str2double(bagAmount);
  sumOfBags = sumOfBags + sum(newAmount);
  nColors = size(bagColors, 2);
  
  % Store the content so it can be be used later when revisited
  for i = 1:nColors
    bagColor = bagColors{i};
    checkDuplicate = contains(fieldnames(colorHistory), bagColor);
    
    % If duplicate store it as a new branch
    if ~any(checkDuplicate)
      currentInfo = struct('color', bagColor, 'amount', newAmount(i));
      colorHistory.(bagColor) = currentInfo;
    else
      nUnique = sum(checkDuplicate);
      bagColor = append(bagColor, num2str(nUnique));
      currentInfo = struct('color', bagColor, 'amount', newAmount(i));
      colorHistory.(bagColor) = currentInfo;
    end
    
  end
  
  nQueue = size(searchQueue, 2) + 1;
  i = 1;
  
  % Add bags to the search queue
  for j = nQueue:(nColors + (nQueue - 1))
    bagColor = bagColors{i};
    checkDuplicate = contains({searchQueue.queue}, bagColor);
    
    % If duplicate store it as a new search term
    if ~any(checkDuplicate)
      searchQueue(j).queue = bagColor;
    else
      nUnique = sum(checkDuplicate);
      searchQueue(j).queue = append(bagColor, num2str(nUnique));
    end
    
    i = i + 1;
  end
  
  % Pick new bag and go through search queue until the end
  try
    queueIndex = queueIndex + 1;
    currentSearch = searchQueue(queueIndex).queue;
  catch
    break;  % All paths of bags have been searched
  end
  
end

fprintf(['Task 1: %d bag colors can at least contain one shiny gold bag\n',...
  'Task 2: %d individual bags are required inside a single shiny gold bag\n'], ...
  nUniqueBags, sumOfBags)
