% Advent of Code
% Day 3
% Date: 2020/12/03
% Auth: Foad Alhayek

clear variables; close all; clc;

fid = fopen('aoc3_input.txt', 'r');
right = [1; 3; 5; 7; 1];
down = [1; 1; 1; 1; 2];
nCases = size(right, 1);
nTrees = zeros(nCases, 1);

for i = 1:nCases
  % Reset and initialize
  frewind(fid);
  pos = 1;
  
  readline = fgetl(fid);
  [~, colS] = size(readline);
  while ~feof(fid)
    % Walk right
    pos = mod(pos + right(i), colS);

    % Periodic
    if pos == 0
      pos = colS;
    end

    % Walk down
    for tmp = 1:down(i)
      readline = fgetl(fid);
    end
    
    if readline(1, pos) == '#'
      nTrees(i) = nTrees(i) + 1;
    end

  end
  
end

fclose(fid);
sol = prod(nTrees);
fprintf('The product is: %d\n', sol)
