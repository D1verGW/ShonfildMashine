function out = argapply(macros, arguments)
% �������, ����������� ��������� ������� � ��� �����������
% ������� ������: 
%	���������� ������� � ���� cell-table
%	��������� ������� � ���� cell-table
% �������� ������:
%	���������� ������� � ���� cell-table

% �������� :
%	���� ����� ������ ���������� � ������ ������ ������� �����
%	����� ����������� ������ ����������
%		������ ������ �������� ���� ����. ���� ���������.
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

