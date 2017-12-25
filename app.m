function app
% ����� ����� � ����������

addpath('./macros');
addpath('./program');

global input

% �������������� ���� ���������� � �������� ����������
form = figure(...
	'units','pixels',...
	'position',[50,50,1000,600],...
	'menubar','none');
input = uicontrol(...
	'style','edit',...
	'position',[20,100,300,470],...
	'max',2,...
	'FontSize',15,...
	'HorizontalAlignment', 'left');
start = uicontrol(...
	'style', 'pushbutton',...
	'position', [20,60,300,30],...
	'string', 'Enter',...
	'Callback',@start_function);
out = uitable(...
	'RowName',[],...
	'position',[330,510,650,60],...
	'ColumnEditable',true,...
	'data',zeros(1,100));
macrosBox = uicontrol('Style','Listbox',...
	'String',{},...
 	'Position',[830,160,150,340],...
	'Callback',@paste_macros);
macrosInfo = uicontrol(...
	'style','edit',...
	'position',[830,60,150,90],...
	'max',2,...
	'FontSize',8,...
	'HorizontalAlignment', 'left',...
	'Enable', 'inactive');

% �������������� ������ ������� ���� ���������� input
% � ������ jObject
jEditbox = findjobj(input);
jEditbox = handle(jEditbox.getViewport.getView, 'CallbackProperties');

% ��������� ����������� ������� �� jObject[jEditbox]
set(jEditbox, 'FocusLostCallback', @getDataOnFocusLost);
set(jEditbox, 'FocusGainedCallback', @setText);

% �������������� ��������� ������ ��� ������� �������
% � ������ � ���������� ��� ���������� ������� inputText
caretPos = 0;
inputText = '';




%--------------------------
% ���������� ���������� ������� ��� ������ �
% ���������� ���������� �����������
%--------------------------


    function start_function (~,~)
		[list, macros_list] = commandlist_creator(stringify(inputText));
		listarr = mdpi(list, macros_list)
	end
	
	function paste_macros (~,~)
		% ������� ��� ������� �� ��� ������ �� ����������
		strings = get(macrosBox,'string');
		value = get(macrosBox,'value');
		
		macrosName = strings(value);
		
		% ������� ��� ������� � ���������� ��� ���������� ������ inputText
		inputText = [inputText(1:caretPos) cell2mat(macrosName) inputText(caretPos + 1:end)];
		
		
		% ������� �������� ���� ������� �� ����������� ��� ���������� ������� inputText
        setText;
		% ������ ����� � ��������� ����
        uicontrol(input);
		% ��������� ���������� ��� ���������� ������ caretPos �� ��������� ����� �������
        caretPos = caretPos + length(cell2mat(macrosName)) + 1;
		if(caretPos > length(inputText))
			caretPos = length(inputText);
		end
		% ������� ������� ������� � ������ �� ����������� ��� ���������� ������� caretPos
        setCaretPosition;
		
		% ��������� ���������� � ������� � ���� ��������
        set(macrosInfo, 'String', getMacrosComment(macrosName));
    end

    function getCaretPosition (~,~)
        caretPos = get(jEditbox,'CaretPosition');
    end

    function setCaretPosition (~,~)
        set(jEditbox, 'CaretPosition', caretPos);
    end

    function getText (~,~)
        inputText = get(jEditbox,'Text');
    end

    function setText (~,~)
        set(jEditbox,'Text', inputText);
    end

    function getDataOnFocusLost (~,~)
        getText;
        getCaretPosition;
	end

	function getMacrosBox (~,~)
		% ������� � ������� ������ �������� �� ���������� macros
		files = dir('./macros');
		filenames = {};
		for i=3:(size(files,1))
			buffer = parser(files(i).name);
			filenames(i - 2) = buffer(1);
		end
		set(macrosBox, 'String', filenames);
	end
end
