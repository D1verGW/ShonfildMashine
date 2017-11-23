function command = bytecodeparser (command)
% Функция, преобразующая команду в байт-код
% Входные данные:
%	команда в виде char-array
% Выходные данные:
%	байт-код команды в виде double-var
    switch command
        case 'INC'
            command = '0';
        case 'DEC'
            command = '1';
    end
end