function [output] = stringify(input)
% ������� �������� �������������� ������, ���������
% ������������� ������ ������ � ������ cell-�����,
% � ������� ���� ������ ������������� ����� ������
% ������� ������:
%	������ � ���� char-array
% �������� ������:
%	������ � ���� cell-table

text = input;
stringsForParse = {};
j = 0;
q = 1;
for i=1:length(text)
	if (text(i) == char(13))
		j = j + 1;
		stringsForParse(j, 1) = {text(q:i - 1)};
		q = i + 1;
	end
	if (i == length(text))
		stringsForParse(j + 1, 1) = {text(q:i)};
	end
end

output = stringsForParse;
end

