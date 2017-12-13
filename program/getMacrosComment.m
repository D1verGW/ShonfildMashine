function comments = getMacrosComment(macrosname)
% �������, ����������� ���� ������� �� ��� ����
% ������� ������:
%	��� ������� � ���� char-array
% �������� ������:
%	����������� ������� � ���� cell-table
filepath = ['../macros/' macrosname{1} '.macros'];
filetext = fileread(char(filepath));
expr = '\n';
text = regexp(filetext,expr,'split');
comments = {};
for i=1:length(text)
    if (text{i}(1) == '[' || text{i}(1) == '%')
        comments{end + 1} = text{i};
    end
end
end

