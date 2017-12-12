function text = filereader(filepath, arguments)
% Функция, считывающая файл макроса по его пути
% Входные данные:
%	адрес макроса в виде char-array
%	аргументы макроса в виде cell-table
% Выходные данные:
%	содержимое макроса в виде cell-table
filetext = fileread(char(filepath));
expr = '\n';
if (exist('arguments', 'var'))
	if (isempty(arguments))
		text = regexp(filetext,expr,'split');
	else
		text = argapply(regexp(filetext,expr,'split'), arguments, filepath);
	end
else
	text = regexp(filetext,expr,'split');
end

end