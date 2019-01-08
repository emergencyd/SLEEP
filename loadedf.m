clear
path = cd;
path_data = [path, '\EDF_FILES'];
dir_data = dir(fullfile(path_data,'*.edf'));
data_Names = {dir_data.name}';
for i = 1: length(data_Names)
    file = [path_data, '\', data_Names{i}];
    [hdr{i},record] = edfread(file);
    name_data = ['record', num2str(i)];
    save(name_data, 'record')
end
