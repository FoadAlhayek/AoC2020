% Advent of Code
% Day: 4
% Date: 2020/12/04
% Auth: Foad Alhayek

clear variables; close all; clc;

fid = fopen('aoc3_input.txt', 'r');

% Ignore CID - allow it
keys = 'byr:|iyr:|eyr:|hgt:|hcl:|ecl:|pid:';
nValid1 = 0;
nValid2 = 0;
nKeys1 = 0;
nKeys2 = 0;

% Validation rules
byrPattern = '^byr:([1][9][2-9][0-9]|[2][0][0][0-2])$';
iyrPattern = '^iyr:([2][0][1][0-9]|[2][0][2][0])$';
eyrPattern = '^eyr:([2][0][2][0-9]|[2][0][3][0])$';
hgtPattern = '^hgt:(([1][5-8][0-9]|[1][9][0-3])cm$|([5][9]|[6][0-9]|[7][0-6])in$)$';
hclPattern = '^hcl:#[0-9a-f]{6}$';
eclPattern = '^ecl:(amb|blu|brn|gry|grn|hzl|oth)$';
pidPattern = '^pid:[0-9]{9}$';

allPatterns = [byrPattern '|' iyrPattern '|' eyrPattern '|' hgtPattern ...
  '|' hclPattern '|' eclPattern '|' pidPattern];


while ~feof(fid)
  readline = fgetl(fid);
  
  % New passport, reset count
  if isempty(readline)
    nKeys1 = 0;
    nKeys2 = 0;
  else
    % Task 1
    nKeys1 = nKeys1 + length(regexp(readline, keys));
    
    % Task 2
    fields = split(readline);
    validFields = regexp(fields, allPatterns);
    
    for i = 1:size(validFields, 1)
      if ~isempty(validFields{i})
        nKeys2 = nKeys2 + 1;
      end
    end
    
  end
  
  % Valid passports and reset count
  if nKeys1 > 6
    nValid1 = nValid1 + 1;
    nKeys1 = 0;
  end
  
  if nKeys2 > 6
    nValid2 = nValid2 + 1;
    nKeys2 = 0;
  end
  
end

fclose(fid);
fprintf('Task 1, valid passports: %d\nTask 2, valid passports: %d\n', ...
  nValid1, nValid2);

