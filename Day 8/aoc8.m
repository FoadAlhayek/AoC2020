% Advent of Code
% Day: 8
% Date: 2020/12/08
% Auth: Foad Alhayek

clear variables; close all; clc;

fid = fopen('aoc8_input.txt', 'r');
instructions = textscan(fid, '%s%d');
fclose(fid);

operators = instructions{:, 1};
arguments = instructions{:, 2};
pointer = 1;

% Initialize
accumulator1 = 0;
nOperators = size(operators, 1);
visitedInstructions = zeros(nOperators, 1);
visitedInstructions(pointer) = 1;

% Stop before second run
while ~any(visitedInstructions == 2)
  switch operators{pointer}
    case 'acc'
      accumulator1 = accumulator1 + arguments(pointer);
      pointer = pointer + 1;
    case 'jmp'
      pointer = pointer + arguments(pointer);
    case 'nop'
      pointer = pointer + 1;
    otherwise
      fprintf('Something weird happened at pointer %f', pointer);
  end
  
  visitedInstructions(pointer) = visitedInstructions(pointer) + 1;
end

% Task 2
% There is no use of changing an operator that has not been visited.
% Thus, narrow it from 636 arguments down to 197. Of these 197 we're only
% interested of the 'jmp' and 'nop' operators.
changeIndex = find(logical(visitedInstructions) & ~contains(operators, 'acc'));

% From above we only have 87 index to look through.
% Change only one each run until the program terminates.
operator2Change = operators{changeIndex(1)};
newOperators = operators;

if strcmp(operator2Change, 'jmp')
  newOperators{changeIndex(1)} = 'nop';
else
  newOperators{changeIndex(1)} = 'jmp';
end

% Initialize
accumulator2 = 0;
i = 1;
pointer = 1;
visitedInstructions = zeros(nOperators, 1);
visitedInstructions(pointer) = 1;

while pointer <= nOperators
  
  % Reset and pick a new pointer
  if any(visitedInstructions == 2)
    accumulator2 = 0;
    i = i + 1;
    pointer = 1;
    visitedInstructions = zeros(nOperators, 1);
    visitedInstructions(pointer) = 1;
    
    operator2Change = operators{changeIndex(i)};
    newOperators = operators;

    if strcmp(operator2Change, 'jmp')
      newOperators{changeIndex(i)} = 'nop';
    else
      newOperators{changeIndex(i)} = 'jmp';
    end
    
  end
  
  switch newOperators{pointer}
    case 'acc'
      accumulator2 = accumulator2 + arguments(pointer);
      pointer = pointer + 1;
    case 'jmp'
      pointer = pointer + arguments(pointer);
    case 'nop'
      pointer = pointer + 1;
    otherwise
      fprintf('Something weird happened at pointer %f', pointer);
  end
  
  if pointer <= nOperators
    visitedInstructions(pointer) = visitedInstructions(pointer) + 1;
  end
end

fprintf(['Task 1: Accumulator value after a single run: %d\n',...
  'Task 2: Accumulator value after the code fix: %d\n'], accumulator1, accumulator2)
