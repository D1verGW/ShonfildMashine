function out_bytecode = mdpi (in_bytecode, macros_list)
% �������, ������������� ��������� ����������� ����-���� ������ ظ������
% � ������������ � �� �������� ����������
% ������� ������:
%	����-��� ������ ظ������ � ���� double-array
%	����-��� ������ �������� � ���� double-array
% �������� ������:
%	����-��� ������ ظ������ � ���� double-array

% mdpi = macros_dec_param_increase
out_bytecode = in_bytecode;
% ������� ������ �� �����
param = 0;

% �������������� ��������� ������������ �����
remappedCommandAddr = [];

% ���� ������� �� ��������
while (param == 0)
	% ���� � ������-����� ���� �� ������������ ������
	if (~(all(macros_list(:,3) == -1)))
		% ����� ������ ���� ��������
		for i=1:size(macros_list,1)
			% ���� i-� ������ � ����� �������� - ����
			isParentForAny = any(macros_list(:,3) == i);

			if (~isParentForAny && macros_list(i,3) ~= -1) % i-� ������ - ���� ������
				if (macros_list(i,3) == 0)
					macros_list(i,3) = -1;
					break;
				end

				% ������� �� ��������������� ����������
				% ������� ������, ��� ������, ����� � �����
				CurrentMacros = macros_list(i,:);
				CMstart = CurrentMacros(1);
				CMlength = CurrentMacros(2);
				CMend = CMstart + CMlength - 1;
				
				% ������� ��� dec � ������� �������
				% �� ���������: 
				% ���� �� ��� �� ������������ dec � ������� �������
				% (����� ���������� � �����)
				% dec [i, new] = dec [i, old] + CurrentMacrosStart 
				for j=CMstart:CMend
					if ~any(j == remappedCommandAddr)
						if (out_bytecode(j, 1) == 1)
							out_bytecode(j, 3) = out_bytecode(j, 3) + CMstart - 1;
						end
					end
				end
				
				% �������� ������������ ������ �� ���������
				macros_list(i,3) = -1;
				
				% �������� ������������ ������ �� ���������� ���������
				remappedCommandAddr = [remappedCommandAddr, CMstart:CMend];
				
				% ������� �� ��������������� ����������
				% �������� �������� �������, ��� ������, ����� � �����
				
				ParentMacros = macros_list(CurrentMacros(3), :);
				PMstart = ParentMacros(1);
				PMlength = ParentMacros(2);
				PMend = PMstart + PMlength - 1;
				
				% ������� ��� dec � ������������ � �������� �������
				% �� ���������:
				% ���� dec �� � ������� ������������ �����
				% ���� ����� dec ������, ��� ������ �������� �������,
				% �� dec [i, new] = dec [i, old] + CurrentMacrosLength
				for j=PMstart:PMend
					if ~any(j == remappedCommandAddr)
						if (out_bytecode(j, 1) == 1)
							if (out_bytecode(j, 3) > CMstart)
								out_bytecode(j, 3) = out_bytecode(j, 3) + CMlength - 1;
							end
						end
					end
				end
				
				
			end
		end
	else
		% ���� � ������-����� ��� �������������� ��������, ��������
		% ���������� ���������
		param = 1;
	end
end

end