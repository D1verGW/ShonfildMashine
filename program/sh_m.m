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

% многострочный текст в input
set(input,'max',2);
set(input,'FontSize',30);
set(input,'HorizontalAlignment', 'left');
% начальные данные на ленте (инициализация)
set(out,'data',zeros(1,100));

	function start_function (~,~)
		clearvars -except input;
		cmb = get(input, 'String');
		[list, macros_list] = commandlist_creator(cellstr(cmb));
		listarr = mdpi(list, macros_list);
		listarr
	end
	
	% функция определения позиции каретки
	% TODO: написать поле с макросами, привязать
	% функцию к каждому элементу этого поля, дабы ф-я
	% принимала на вход имя элемента(макроса), выполнять по
	% клику на элемент поля
	function paste_macros (~,~)
		jEditbox = findjobj(input);
		caretPos = get(jEditbox,'CaretPosition');
		jEditbox = handle(jEditbox.getViewport.getView, 'CallbackProperties');
		text = char(jEditbox.getText());
		macrosName = ['\n',macrosName,'\n']; 
		text = [text(1:caretPos), macrosName, text(caretPos:end)];
		% вставить текст в определенное место программы - уже не проблема
		jEditbox.setText(text);
	end
end