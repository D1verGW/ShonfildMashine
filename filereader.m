function text = filereader(filepath)
	% функция чтения файла по его адресу
    filetext = fileread(char(filepath));
    expr = '\n';
    text = regexp(filetext,expr,'split');
end