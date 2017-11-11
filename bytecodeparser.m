function command = bytecodeparser (command)
    switch command
        case 'INC'
            command = '0';
        case 'DEC'
            command = '1';
    end
end