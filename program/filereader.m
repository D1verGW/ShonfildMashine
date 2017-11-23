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
	text = argapply(regexp(filetext,expr,'split'), arguments);
else
	text = regexp(filetext,expr,'split');
end
end