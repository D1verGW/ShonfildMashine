function table = parser(command)
    % задали регулярные выражения для
    % поиска пробелов, символов и запятых
    spaceExpr = '\s';
    charExpr = '[A-Z]';
	notNumExpr = '[^0-9]';
    commaExpr = '\,';
    
    % перевели символы в верхний регистр для 
    % правильной работы регулярного выражения
    command = upper(command);
    exp = regexp(command, charExpr);
    
    % обрезали лишние пробелы/небуквенные символы
    % в начале команды 
    % [можно нумеровать команды, ништяк]
    command = char(command);
    command = command(exp(1):end);
    
    % обрезали команду первым пробелом
    % команды не должны содержать в себе пробелы
	% параметры следуют сразу за первым пробелом и до конца строки
    space = regexp(command, spaceExpr);
    command = char(command);
    
    % определили название команды и ее параметры
	if (~(isempty(space)))
		arguments = command(space(1): end);
		command = string(command(1:space(1) - 1));
	else
		arguments = [];
	end
	
    % убрали все пробелы
    command = strrep (command, ' ', '');
    arguments = strrep (arguments, ' ', '');
    arguments = char(arguments);
    
    % разделили аргументы по запятым
    argMass = regexp(arguments,commaExpr,'split'); 
    table{1} = command;
    for i=1:length(argMass)
         table{i+1} = cell2mat(regexprep(argMass(i), notNumExpr, ''));
    end
end