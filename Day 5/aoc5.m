% Advent of Code
% Day: 5
% Date: 2020/12/05
% Auth: Foad Alhayek

clear variables; close all; clc;

maxRowNo = 127;
minRowNo = 0;
maxSeatNo = 7;
minSeatNo = 0;
j = 0;

fid = fopen('aoc5_input.txt', 'r');

while ~feof(fid)
  j = j + 1;
  readline = fgetl(fid);
  seatRow = [minRowNo, maxRowNo];
  seatCol = [minSeatNo, maxSeatNo];
  
  for i = 1:length(readline)
    switch readline(i)
      case 'B'
        rowNo = ceil((seatRow(2) - seatRow(1))/2);
        seatRow(1) = seatRow(1) + rowNo;
      case 'F'
        rowNo = ceil((seatRow(2) - seatRow(1))/2);
        seatRow(2) = seatRow(2) - rowNo;
      case 'L'
        colNo = ceil((seatCol(2) - seatCol(1))/2);
        seatCol(2) = seatCol(2) - colNo;
      case 'R'
        colNo = ceil((seatCol(2) - seatCol(1))/2);
        seatCol(1) = seatCol(1) + colNo;
    end
  end
  
  seatID(j) = seatRow(1)*8+seatCol(1);
  
end

% Task 1
maxSeatID = max(seatID);

% Task 2
sortedSeatID = sort(seatID);
seatIndex = find(diff(sortedSeatID) == 2);
mySeatID = sortedSeatID(seatIndex) + 1;

fprintf('Max seat ID is: %d\nMy seat ID is: %d\n', maxSeatID, mySeatID);

