function outArray = argapply(macros, arguments, filepath)
% Функция, применяющая аргументы макроса к его содержимому
% Входные данные: 
%	содержимое макроса в виде cell-table
%	аргументы макроса в виде cell-table
% Выходные данные:
%	содержимое макроса в виде cell-table

argWord = parser(macros{1});

cleanMacros = {};
for i=1:length(macros)
    if (macros{i}(1) ~= '[' && macros{i}(1) ~= '%')% && macros{i}(1) ~= ' ' && macros{i}(1) ~= '\n')
        cleanMacros{end + 1} = macros{i};
    end
end
macros = cleanMacros;

outArray = {};
outArrayNum = 1;
if (length(argWord) == length(arguments))
	for j = 1 : length(macros)
		command = parser(macros{j});
		if (length(command) > 1)
			for i = 2 : length(command)
				for q = 1 : length(argWord)
					if(ismember(command(i), argWord(q)))
						command(i) = arguments(q);
					end
				end
			end
			outArray(outArrayNum) = {cell2mat({char(command(1)),' '})};
			for z = 2 : length(command)
				if (z ~= length(command))
					outcell = {cell2mat(outArray(outArrayNum)),cell2mat(command(z)),','};
				else 
					outcell = {cell2mat(outArray(outArrayNum)),cell2mat(command(z))};
				end
				outArray(outArrayNum) = {cell2mat(outcell)};
			end
			outArrayNum = outArrayNum + 1;	
		end
	end
else
	buffer = parser(filepath);
	macrosName = cell2mat(buffer(length(buffer) - 1));
	spacer = [char(13) '--------------------------' char(13)];
	argWords = '';
	for i=1:length(argWord)
		argWords = [argWords cell2mat(argWord(i)) ','];
	end
	if (isempty(arguments))
		args = '';
	else
		args = char(arguments(1:end));
	end
	Err = [spacer 'Wrong params in macros: ' macrosName char(13)...
				  'Macros needs arguments: ' argWords(1:end - 1) char(13)...
				  'Macros has arguments: ' args spacer];
	error(Err);
end

end

