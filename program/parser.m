function table = parser(command)
% ������� �������� ����������, ���������� ����������� ��� ���������� ���������
% ����� ���������� - �������� ����������, ��������� ����������
% ������� ������:
%	������ � ����������� ��� ������ ظ������ � ���� char-array
% �������� ������:
%	���������� ��� ������ ظ������ � ���� cell-table

table = regexp(command, '\w*', 'match');
end