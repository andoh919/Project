function writeStructToCSV(inputStruct,filename,delimiter,reportProgress)

% delimiter = ',';
% filename = 'CSV_output.csv';
mFile = fopen(filename,'w');
inputStructFields = fieldnames(inputStruct);
mString = '';
% Write the fieldnames
for l = 1:length(inputStructFields)-1
    mString = [mString inputStructFields{l} delimiter];
end
mString = [mString inputStructFields{l+1} '\n'];
fprintf(mFile,mString);
% Write the values
for k = 1:length(inputStruct)
    if reportProgress
        if mod(k,reportProgress) == 0
            display(sprintf(['Writing line ' num2str(k) ' of ' num2str(length(inputStruct)) '\n']));
        end
    end
    mString = '';
    for l = 1:length(inputStructFields)-1
        mString = [mString num2str(inputStruct(k).(inputStructFields{l})) delimiter];
    end
    mString = [mString num2str(inputStruct(k).(inputStructFields{l+1})) '\n'];
    fprintf(mFile,mString);
end
fclose(mFile);