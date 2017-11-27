function out = argapply(macros, arguments)
% Функция, применяющая аргументы макроса к его содержимому
% Входные данные: 
%	содержимое макроса в виде cell-table
%	аргументы макроса в виде cell-table
% Выходные данные:
%	содержимое макроса в виде cell-table

argWord = parser(macros{1});
macros = {macros{2:end}};
out = macros;
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
			out(j) = {cell2mat({char(command(1)),' '})};
			for z = 2 : length(command)
				if (z ~= length(command))
					outcell = {cell2mat(out(j)),cell2mat(command(z)),','};
				else 
					outcell = {cell2mat(out(j)),cell2mat(command(z))};
				end
				out(j) = {cell2mat(outcell)};
			end
		end
	end
end

end

