function text = filereader(filepath, arguments)
% �������, ����������� ���� ������� �� ��� ����
% ������� ������:
%	����� ������� � ���� char-array
%	��������� ������� � ���� cell-table
% �������� ������:
%	���������� ������� � ���� cell-table
filetext = fileread(char(filepath));
expr = '\n';
if (exist('arguments', 'var'))
	text = argapply(regexp(filetext,expr,'split'), arguments);
else
	text = regexp(filetext,expr,'split');
end
end