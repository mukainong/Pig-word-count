lines = LOAD './in' AS (line:chararray);
strings = FOREACH lines GENERATE REPLACE(line,'([^a-zA-Z\\s]+)','') as (string:chararray);
words = FOREACH strings GENERATE FLATTEN(TOKENIZE(LOWER(string))) as (word:chararray);
arrays = FOREACH words GENERATE REPLACE(word,'(?<!^)(.)',',$1') as (array:chararray);
chars = FOREACH arrays GENERATE FLATTEN(TOKENIZE(array)) as char;
grouped = GROUP chars BY char;
charcount = FOREACH grouped GENERATE group, COUNT(chars);
store charcount into './charcount';
