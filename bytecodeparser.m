function command = bytecodeparser (command)
	% парсер команды машине в машинный код
    switch command
        case 'INC'
            command = '0';
        case 'DEC'
            command = '1';
    end
end