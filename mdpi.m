% mdpi = macros_dec_param_increase
function out_bytecode = mdpi (in_bytecode, macros_list)
out_bytecode = in_bytecode;
% условие выхода из цикла
param = 0;

% инициализируем хранилище обработанных строк
remappedCommandAddr = [];

% пока условие не изменено
while (param == 0)
	% если в макрос-листе есть не обработанные листья
	if (~(all(macros_list(:,3) == -1)))
		% обход циклом всех макросов
		for i=1:size(macros_list,1)
			% если i-й макрос в древе макросов - лист
			isParentForAny = any(macros_list(:,3) == i);

			if (~isParentForAny && macros_list(i,3) ~= -1) % i-я строка - лист дерева
				if (macros_list(i,3) == 0)
					macros_list(i,3) = -1;
					break;
				end

				% запишем во вспомогательные переменные
				% текущий макрос, его начало, длину и конец
				CurrentMacros = macros_list(i,:);
				CMstart = CurrentMacros(1);
				CMlength = CurrentMacros(2);
				CMend = CMstart + CMlength - 1;
				
				% изменим все dec в текущем макросе
				% по алгоритму: 
				% если мы еще не обрабатывали dec в текущем макросе
				% (могли обработать в листе)
				% dec [i, new] = dec [i, old] + CurrentMacrosStart 
				for j=CMstart:CMend
					if ~any(j == remappedCommandAddr)
						if (out_bytecode(j, 1) == 1)
							out_bytecode(j, 3) = out_bytecode(j, 3) + CMstart - 1;
						end
					end
				end
				
				% Исключим обработанный макрос из обработки
				macros_list(i,3) = -1;
				
				% Исключим обработанные строки из дальнейшей обработки
				remappedCommandAddr = [remappedCommandAddr, CMstart:CMend];
				
				% запишем во вспомогательные переменные
				% родителя текущего макроса, его начало, длину и конец
				
				ParentMacros = macros_list(CurrentMacros(3), :);
				PMstart = ParentMacros(1);
				PMlength = ParentMacros(2);
				PMend = PMstart + PMlength - 1;
				
				% изменим все dec в родительском к текущему макросе
				% по алгоритму:
				% если dec не в составе обработанных строк
				% если адрес dec больше, чем начало текущего макроса,
				% то dec [i, new] = dec [i, old] + CurrentMacrosLength
				for j=PMstart:PMend
					if ~any(j == remappedCommandAddr)
						if (out_bytecode(j, 1) == 1)
							if (out_bytecode(j, 3) > CMstart)
								out_bytecode(j, 3) = out_bytecode(j, 3) + CMlength - 1;
							end
						end
					end
				end
				
				
			end
		end
	else
		% если в макрос-листе нет необработанных деревьев, завершим
		% выполнение программы
		param = 1;
	end
end

end