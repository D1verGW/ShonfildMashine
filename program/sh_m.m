function sh_m
global input
form = figure(...
	'units','pixels',...
	'position',[50,50,1000,600],...
	'menubar','none');
input = uicontrol(...
	'style','edit',...
	'position',[20,100,300,470]);
start = uicontrol(...
	'style', 'pushbutton',...
	'position', [20,60,300,30],...
	'string', 'Enter',...
	'Callback',@start_function);
out = uitable(...
	'RowName',[],...
	'position',[330,510,650,60],...
	'ColumnEditable',true);
macrosBox = uicontrol('Style','Listbox',...
	'String',{'Red';'Green';'Blue'},...
 	'Position',[830,60,150,440],...
	'Callback',@paste_macros);

set(input,'max',2);
set(input,'FontSize',30);
set(input,'HorizontalAlignment', 'left');

set(out,'data',zeros(1,100));
jEditbox = findjobj(input);
jEditbox = handle(jEditbox.getViewport.getView, 'CallbackProperties');
set(jEditbox, 'FocusLostCallback', @getDataOnFocusLost);
set(jEditbox, 'FocusGainedCallback', @setText);
caretPos = 0;
inputText = '';

files = dir('../macros');
for i=3:(size(files,1))
	filenames(i - 2) = files(i).name;
end

    function start_function (~,~)
		clearvars -except input macrosBox;
		cmb = get(input, 'String');
		[list, macros_list] = commandlist_creator(cellstr(cmb));
		listarr = mdpi(list, macros_list)
	end
	
	function paste_macros (~,~)
		strings = get(macrosBox,'string');
		value = get(macrosBox,'value');
		macrosName = strings(value);
		inputText = [inputText(1:caretPos) char(13) cell2mat(macrosName) inputText(caretPos + 1:end)];
		caretPos = caretPos + length(cell2mat(macrosName)) + 1;
        setText;
    end

    function getCaretPosition (~,~)
        caretPos = get(jEditbox,'CaretPosition');
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
end
