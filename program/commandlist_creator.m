function [out, macrosList] = commandlist_creator (in)
% �������, ��������� ����-��� ������ ظ������
% ������� ������:
%	��� ��������� ������ ظ������ � ���� cell-table
% �������� ������:
%	����-��� ������ ��������, ������� � 3 �������, � ���� double-array
%	���� ��������, �������������� � ������, � ���� double-array

% ������� ������ �� ������
clearvars -except in;
% ------------------------------------------------------------------------
% �������������� ������
% ------------------------------------------------------------------------

global counter global_list local_list macros_list;
local_list = {};
macros_list = [];
global_list = {};
counter = 1;
local_list = in;

% ------------------------------------------------------------------------
% ������� ������ � ������
% ------------------------------------------------------------------------

recGlobalBuilder; % ������ ������ � ������ �������������� � ���� �-�

% ------------------------------------------------------------------------
% ���������� ������ � ������ � ������� �� � return variables
% ------------------------------------------------------------------------

% �������� ���������� ������� � 3 �������
out = [zeros(size(global_list,1),(size(global_list,2)))];
for i=1:size(global_list,1)
	for q=1:size(global_list,2)
		charval = cell2mat(global_list(i,q));
		if (isempty(charval))
			charval = '0';
		end
		out(i,q) =  str2double(charval);
	end
end

% �������� ������ ����������� �������� ����� �������������� �������������
% ������ ��������

% ������� ��� ��������� ��� ���������� ������ � ������-����
macrosList = [1, size(global_list,1); macros_list];
for i=2:length(macrosList)
	for z=i + 1:length(macrosList)
		if(any(macrosList(z,1) == (macrosList(i,1) : macrosList(i,1) + macrosList(i,2) - 1)))
			macrosList(i,2) = macrosList(i,2) + macrosList(z,2) - 1;
		end
	end
end

% ������� � ������ ����������� �������� ������, �������� ������� ���������
% �� ����� ������������� �������
macrosList = [macrosList, zeros(size(macrosList,1), 1)];
for i=1:size(macrosList,1)
	for d=i + 1:size(macrosList,1)
		if any(macrosList(d,1) == (macrosList(i,1) : macrosList(i,1) + macrosList(i,2) - 1))
			macrosList(d,3) = i;
		end
	end
end

% ------------------------------------------------------------------------
% ������ �������
% ------------------------------------------------------------------------
	function recGlobalBuilder
		% ������� (������) ������� � ������� ������� ������
		buffer = upper(parser(char(local_list{1})))
		switch buffer{1}
			case {'INC' , 'DEC'}
				buffer{1} = bytecodeparser(buffer{1});
				% ��������� � �������� ������ ������ ��� ������� �
				% �� ���������
				for j=1:length(buffer)
					global_list(counter, j) = buffer(j);
				end
				% ����������� ����� �������
				counter = counter + 1;
				% �������� ������� �� �������
				local_list = local_list(2 : end);
			otherwise
				% ���������� ���� � ������� � ���� ������
				path = ['../macros/' , buffer{1} , '.macros'];
				% ���������, ���� �� �� ����� ���� ���� � �����
				% ���������
				ext = exist(path, 'file');
				% ���� ���� � ��������� ������� ����:
				if (ext ~= 0)
					% ������� cell ������ �� ����������� ����� �������
					arguments = {buffer{2:end}};
					% ���� ������ - ��������������� ���������,
					% ���� ���������� ��� - ������
					newlist = filereader(path, arguments);
					% �������� �������� ������� �� �������
					local_list = local_list(2 : end);
					if (size(newlist,2) == 1)
						newlist = newlist';
					end
					if (size(local_list,2) == 1)
						local_list = local_list';
					end
					% ��������� � ���� ���������� �������
					local_list = [newlist local_list];
					% ��������� � ���� �������� ����� ��������� ������
					% ������� � ��� �����
					macros_list(end + 1,:) = [counter, size(newlist,2)];
				else
					% ���� ������ ����� ���, ����������� ������
					% TODO: ���������, ����������� �� �� ���������
					% ����� ������ ���� ������
					spacer = [char(13) '--------------------------' char(13)];
					Err = [spacer 'File ' path ' not found!' spacer];
					error(Err);
				end
		end
		if (isempty(local_list))
			% ���� ������� ������ ������ ������� �� �������
			return
		else
			% ���� ��� - �������� ������� ��� ���
			recGlobalBuilder;
		end
	end
% ------------------------------------------------------------------------
% ����� ������� �������
% ------------------------------------------------------------------------
end