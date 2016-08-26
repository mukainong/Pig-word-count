lines = LOAD './in' AS (line:chararray);
strings = FOREACH lines GENERATE REPLACE(line,'([^a-zA-Z\\s]+)','') as (string:chararray);
words = FOREACH strings GENERATE FLATTEN(TOKENIZE(LOWER(string))) as (word:chararray);
arrays = FOREACH words GENERATE REPLACE(word,'(?<!^)(.)',',$1') as (array:chararray);
chars = FOREACH arrays GENERATE FLATTEN(TOKENIZE(array)) as char;
vowels = FILTER chars BY (char == 'a') OR (char == 'e') OR (char == 'i') OR (char == 'o') OR (char == 'u');
grouped = GROUP vowels BY char;
charcount = FOREACH grouped GENERATE group, COUNT(vowels);
store charcount into './charcount';
