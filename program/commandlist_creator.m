function [out, macrosList] = commandlist_creator (in)
% Функция, создающая байт-код машины Шёнфилда
% Входные данные:
%	код программы машины Шёнфилда в виде cell-table
% Выходные данные:
%	байт-код машины шенфилда, шириной в 3 столбца, в виде double-array
%	лист макросов, использующихся в машине, в виде double-array

% очистим память от мусора
clearvars -except in;
% ------------------------------------------------------------------------
% инициализируем память
% ------------------------------------------------------------------------

global counter global_list local_list macros_list;
local_list = {};
macros_list = [];
global_list = {};
counter = 1;
local_list = in;

% ------------------------------------------------------------------------
% запишем данные в память
% ------------------------------------------------------------------------

recGlobalBuilder; % запись данных в память осуществляется в этой ф-и

% ------------------------------------------------------------------------
% обработаем данные в памяти и запишем их в return variables
% ------------------------------------------------------------------------

% составим нормальный байткод в 3 столбца
out = [zeros(size(global_list,1),(size(global_list,2)))];
for i=1:size(global_list,1)
	for q=1:size(global_list,2)
		charval = cell2mat(global_list(i,q));
		if (isempty(charval))
			charval = '0';
		end
		out(i,q) =  str2double(charval);
	end
end

% составим дерево вложенности макросов путем редактирования оригинального
% списка макросов

% добавим всю программу как глобальный макрос в макрос-лист
macrosList = [1, size(global_list,1); macros_list];
for i=2:length(macrosList)
	for z=i + 1:length(macrosList)
		if(any(macrosList(z,1) == (macrosList(i,1) : macrosList(i,1) + macrosList(i,2) - 1)))
			macrosList(i,2) = macrosList(i,2) + macrosList(z,2) - 1;
		end
	end
end

% добавим в дерево вложенности макросов строку, значение которой указывает
% на адрес родительского макроса
macrosList = [macrosList, zeros(size(macrosList,1), 1)];
for i=1:size(macrosList,1)
	for d=i + 1:size(macrosList,1)
		if any(macrosList(d,1) == (macrosList(i,1) : macrosList(i,1) + macrosList(i,2) - 1))
			macrosList(d,3) = i;
		end
	end
end

% ------------------------------------------------------------------------
% Раздел функций
% ------------------------------------------------------------------------
	function recGlobalBuilder
		% достаем (парсим) команду с вершины очереди команд
		buffer = upper(parser(char(local_list{1})))
		switch buffer{1}
			case {'INC' , 'DEC'}
				buffer{1} = bytecodeparser(buffer{1});
				% добавляем в числовой список команд код команды и
				% ее аргументы
				for j=1:length(buffer)
					global_list(counter, j) = buffer(j);
				end
				% увеличиваем номер команды
				counter = counter + 1;
				% вырезаем команду из очереди
				local_list = local_list(2 : end);
			otherwise
				% составляем путь к макросу в виде строки
				path = ['../macros/' , buffer{1} , '.macros'];
				% проверяем, есть ли по этому пути файл с таким
				% названием
				ext = exist(path, 'file');
				% если файл с названием макроса есть:
				if (ext ~= 0)
					% создаем cell массив из содержимого файла макроса
					arguments = {buffer{2:end}};
					% если макрос - подразумеваются аргументы,
					% если аргументов нет - ошибка
					newlist = filereader(path, arguments);
					% вырезаем название макроса из очереди
					local_list = local_list(2 : end);
					if (size(newlist,2) == 1)
						newlist = newlist';
					end
					if (size(local_list,2) == 1)
						local_list = local_list';
					end
					% добавляем в стек содержимое макроса
					local_list = [newlist local_list];
					% добавляем в лист макросов номер начальной строки
					% макроса и его длину
					macros_list(end + 1,:) = [counter, size(newlist,2)];
				else
					% если такого файла нет, выбрасываем ошибку
					% TODO: проверить, выбрасывает ли из программы
					% после такого рода ошибки
					spacer = [char(13) '--------------------------' char(13)];
					Err = [spacer 'File ' path ' not found!' spacer];
					error(Err);
				end
		end
		if (isempty(local_list))
			% если очередь команд пустая выходим из функции
			return
		else
			% если нет - вызываем функцию еще раз
			recGlobalBuilder;
		end
	end
% ------------------------------------------------------------------------
% Конец раздела функций
% ------------------------------------------------------------------------
end