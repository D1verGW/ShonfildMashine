function command = bytecodeparser (command)
% �������, ������������� ������� � ����-���
% ������� ������:
%	������� � ���� char-array
% �������� ������:
%	����-��� ������� � ���� double-var
    switch command
        case 'INC'
            command = '0';
        case 'DEC'
            command = '1';
    end
end