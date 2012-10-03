%close all;
%clear all;
%clc;

stg1gain_range = 10:15;
stg1NF_range = 2:6;
stg1IIP3_range = 8:9;
stg2gain_range = 13:15;
stg2NF_range = 2:3;
stg2IIP3_range = 13:16;
stg3gain_range = 12:15;
stg3NF_range = 2:3;
stg3IIP3_range = 13:15;

% stg1gain_range = 10:15;
% stg1NF_range = 2:6;
% stg1IIP3_range = 8:9;
% stg2gain_range = 15:15;
% stg2NF_range = 3:3;
% stg2IIP3_range = 16:16;
% stg3gain_range = 15:15;
% stg3NF_range = 3:3;
% stg3IIP3_range = 15:15;

% Probably time for some Perl to generate these loops automatically, might
% be possible to use recursive functions calls instead but that could
% potentially create way too much overhead. Hmm, maybe one could actually
% skip Perl and use matlab to write a new .m-file which it then runs (and
% possibly deletes again upon finishing)?
% It might be better to write the output file as we go in order to along
% keeping a large struct in memory.
nbrOfIterations = length(stg1gain_range)*length(stg1NF_range)*length(stg1IIP3_range)*length(stg2gain_range)*length(stg2NF_range)*length(stg2IIP3_range)*length(stg3gain_range)*length(stg3NF_range)*length(stg3IIP3_range);
k = 1;
results = struct;
reportProgress = 1000;
for stg1gain = stg1gain_range
for stg1NF = stg1NF_range
for stg1IIP3 = stg1IIP3_range
for stg2gain = stg2gain_range
for stg2NF = stg2NF_range
for stg2IIP3 = stg2IIP3_range
for stg3gain = stg3gain_range
for stg3NF = stg3NF_range
for stg3IIP3 = stg3IIP3_range
    results(k).stg1gain = stg1gain;
    results(k).stg1NF = stg1NF;
    results(k).stg1IIP3 = stg1IIP3;
    results(k).stg2gain = stg2gain;
    results(k).stg2NF = stg2NF;
    results(k).stg2IIP3 = stg2IIP3;
    results(k).stg3gain = stg3gain;
    results(k).stg3NF = stg3NF;
    results(k).stg3IIP3 = stg3IIP3;
    results(k).NFtot = cascadedNF({{stg1gain,stg1NF},{stg2gain,stg2NF},{stg3gain,stg3NF}});
    results(k).IIP3tot = cascadedIIP3({{stg1gain,stg1IIP3},{stg2gain,stg2IIP3},{stg3gain,stg3IIP3}});
    k = k+1;
    if mod(k,reportProgress) == 0
        display(sprintf(['Starting iteration ' num2str(k) ' of ' num2str(nbrOfIterations) '\n']));
    end
end
end
end
end
end
end
end
end
end

writeStructToCSV(results,'CSV_results.csv',',',reportProgress);
