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
	if (isempty(arguments))
		text = regexp(filetext,expr,'split');
	else
		text = argapply(regexp(filetext,expr,'split'), arguments, filepath);
	end
else
	text = regexp(filetext,expr,'split');
end

end