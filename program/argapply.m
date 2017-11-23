function out = argapply(macros, arguments)
% ‘ункци€, примен€юща€ аргументы макроса к его содержимому
% ¬ходные данные: 
%	содержимое макроса в виде cell-table
%	аргументы макроса в виде cell-table
% ¬ыходные данные:
%	содержимое макроса в виде cell-table

% «начитс€ :
%	≈сли длина списка аргументов в первой строке макроса равна
%	длине переданного списка аргументов
%		 ороче полна€ проверка всей чуши. Ќадо составить.
argWord = parser(macros{1});
macros = {macros{2:end}};
for i = 1 : length(arguments)
	for j = 1 : length(macros)
		command = parser(macros{j});
		if (length(command) > 1)
			commandArgs = {command{2:end}};
		end
	end
end

end

