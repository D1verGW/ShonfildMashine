function app
% ����� ����� � ����������

addpath('./macros');
addpath('./program');
addpath('./data');

global input
%% --------------------------
% �������������� ���� ���������� � �������� ����������
form = figure(...
	'Name','Shonfild Mashine IDE',...
	'NumberTitle','off',...
	'Resize','off',...
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
bytecode = uitable(...
	'RowName',[],...
	'position',[330,100,300,400],...
	'ColumnEditable',false,...
	'data',zeros(30,3),...
	'ColumnWidth',{94 94 93});
runMashine = uicontrol(...
	'style', 'pushbutton',...
	'position', [330,60,50,30],...
	'string', 'Run',...
	'Callback',@controller);
stopMashine = uicontrol(...
	'style', 'pushbutton',...
	'position', [390,60,50,30],...
	'string', 'Stop',...
	'Callback',@controller);
pauseMashine = uicontrol(...
	'style', 'pushbutton',...
	'position', [450,60,50,30],...
	'string', 'Pause',...
	'Callback',@controller);
fasterMashine = uicontrol(...
	'style', 'pushbutton',...
	'position', [510,60,55,30],...
	'string', 'Faster',...
	'Callback',@controller);
slowerMashine = uicontrol(...
	'style', 'pushbutton',...
	'position', [575,60,55,30],...
	'string', 'Slower',...
	'Callback',@controller);

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

%% --------------------------
% �������������� ������ ������� ���� ���������� input
% � ������ jObject
jEditbox = findjobj(input);
jEditbox = handle(jEditbox.getViewport.getView, 'CallbackProperties');

% ��������� ����������� ������� �� jObject[jEditbox]
set(jEditbox, 'FocusLostCallback', @getDataOnFocusLost);
set(jEditbox, 'FocusGainedCallback', @setText);

% �������������� ��������� ������ ��� ������� �������
% � ������ � ���������� ��� ���������� �������
caretPos = 0;
inputText = '';

% ������� � ������� ������� �� ���������� macros
getMacrosBox;

%% --------------------------
% ���������� ���������� ������� ��� ������ �
% ���������� ���������� �����������

    function start_function (~,~)
		[list, macros_list] = commandlist_creator(stringify(inputText));
		listarr = mdpi(list, macros_list);
		setProgramData(listarr);
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

	function setProgramData (programData)
		set(bytecode, 'data', zeros(size(programData, 1), 3));
		set(bytecode, 'data', programData);
	end

%% --------------------------
% ����������, �������� �� ����������
% ��������� ������ ظ������
% TODO: ������� � ��������� ����, ����� ���������
% � ��������� ������ ���������� ����������
	function controller_batch (action)
		switch action
			case 'run'
				string = action
			case 'stop'
				string = action
			case 'pause'
				string = action
			case 'faster'
				string = action
			case 'slower'
				string = action
		end
	end

	function controller (hObject, eventdata)
		action = hObject.get('string');
		job = batch('controller_batch', 0, {'action'});
	end
	


end
