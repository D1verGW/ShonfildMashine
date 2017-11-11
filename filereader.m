function text = filereader(filepath)
    filetext = fileread(char(filepath));
    expr = '\n';
    text = regexp(filetext,expr,'split');
end