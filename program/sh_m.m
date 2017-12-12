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
	'String',{},...
 	'Position',[830,60,150,440],...
	'Callback',@paste_macros);

set(input,'max',2);
set(input,'FontSize',15);
set(input,'HorizontalAlignment', 'left');

set(out,'data',zeros(1,100));
jEditbox = findjobj(input);
jEditbox = handle(jEditbox.getViewport.getView, 'CallbackProperties');
set(jEditbox, 'FocusLostCallback', @getDataOnFocusLost);
set(jEditbox, 'FocusGainedCallback', @setText);
caretPos = 0;
inputText = '';

files = dir('../macros');
filenames = {};
for i=3:(size(files,1))
	buffer = parser(files(i).name);
	filenames(i - 2) = buffer(1);
end
set(macrosBox, 'String', filenames);

    function start_function (~,~)
		text = inputText;
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
		[list, macros_list] = commandlist_creator(stringsForParse);
		listarr = mdpi(list, macros_list)
	end
	
	function paste_macros (~,~)
		strings = get(macrosBox,'string');
		value = get(macrosBox,'value');
		macrosName = strings(value);
		
		if(caretPos == 0)
			enterSymbol = '';
		else
			enterSymbol = char(13);
		end
		inputText = [inputText(1:caretPos) enterSymbol cell2mat(macrosName) inputText(caretPos + 1:end)];
		caretPos = caretPos + length(cell2mat(macrosName)) + 1;
		if(caretPos > length(inputText))
			caretPos = length(inputText);
		end
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
