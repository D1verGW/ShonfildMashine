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
        'position',[330,510,650,60]);
    
    % ������������� ����� � input
    set(input,'max',2);
    % ��������� ������ �� ����� (�������������)
    set(out,'data',zeros(1,100));
    out.ColumnEditable = true;
    
    % command memory box
    
    
    
    function start_function (~,~)
		clearvars -except input;
        cmb = get(input, 'String');
        [list, macros_list] = commandlist_creator(cellstr(cmb));
		
		listarr = mdpi(list, macros_list);
        end
end

