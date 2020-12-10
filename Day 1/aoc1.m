% Advent of Code
% Day 1
% Date: 2020/12/01
% Auth: Foad Alhayek

clear variables; close all; clc;

fid = fopen('aoc1_input.txt', 'r');
data = fscanf(fid, '%f');
fclose(fid);

% First part
finished = false;

for i = 1:(size(data, 1)-1)
  for j = (i+1):size(data, 1)
    sumData = data(i) + data(j);
    
    if sumData == 2020
      sol = data(i)*data(j);
      fprintf("At i:%d, j:%d -> %d * %d = %d\n", ...
        i, j, data(i), data(j), sol);
      finished = true;
      break;
    end
  end
  
  if finished
    break;
  end
end


% Second part
finished = false;

for i = 1:(size(data, 1)-2)
  for j = (i+1):(size(data, 1)-1)
    for k = (j+1):size(data, 1)
      sumData = data(i) + data(j) + data(k);

      if sumData == 2020
        sol = data(i)*data(j)*data(k);
        fprintf("At i:%d, j:%d, k:%d -> %d * %d * %d = %d\n", ...
          i, j, k, data(i), data(j), data(k), sol);
        finished = true;
        break;
      end
    end
    
    if finished
      break;
    end
  end
  
  if finished
    break;
  end
end

