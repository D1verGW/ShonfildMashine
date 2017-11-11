function table = parser(command)
    % ������ ���������� ��������� ���
    % ������ ��������, �������� � �������
    spaceExpr = '\s';
    charExpr = '[A-Z]';
	notNumExpr = '[^0-9]';
    commaExpr = '\,';
    
    % �������� ������� � ������� ������� ��� 
    % ���������� ������ ����������� ���������
    command = upper(command);
    exp = regexp(command, charExpr);
    
    % �������� ������ �������/����������� �������
    % � ������ ������� 
    % [����� ���������� �������, ������]
    command = char(command);
    command = command(exp(1):end);
    
    % �������� ������� ������ ��������
    % ������� �� ������ ��������� � ���� �������
	% ��������� ������� ����� �� ������ �������� � �� ����� ������
    space = regexp(command, spaceExpr);
    command = char(command);
    
    % ���������� �������� ������� � �� ���������
	if (~(isempty(space)))
		arguments = command(space(1): end);
		command = string(command(1:space(1) - 1));
	else
		arguments = [];
	end
	
    % ������ ��� �������
    command = strrep (command, ' ', '');
    arguments = strrep (arguments, ' ', '');
    arguments = char(arguments);
    
    % ��������� ��������� �� �������
    argMass = regexp(arguments,commaExpr,'split'); 
    table{1} = command;
    for i=1:length(argMass)
         table{i+1} = cell2mat(regexprep(argMass(i), notNumExpr, ''));
    end
end