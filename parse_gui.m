function varargout = parse_gui(varargin)
% PARSE_GUI MATLAB code for parse_gui.fig
%      PARSE_GUI, by itself, creates a new PARSE_GUI or raises the existing
%      singleton*.
%
%      H = PARSE_GUI returns the handle to a new PARSE_GUI or the handle to
%      the existing singleton*.
%
%      PARSE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARSE_GUI.M with the given input arguments.
%
%      PARSE_GUI('Property','Value',...) creates a new PARSE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before parse_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to parse_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help parse_gui

% Last Modified by GUIDE v2.5 24-Mar-2017 08:41:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @parse_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @parse_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before parse_gui is made visible.
function parse_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to parse_gui (see VARARGIN)

% Choose default command line output for parse_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes parse_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = parse_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in list.
function list_Callback(hObject, eventdata, handles)
% hObject    handle to list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global innerHTML
global img
global artist_name
global count_of_page
global cycle_string
index = get(hObject,'value');
string = innerHTML(index);
string = char(string);
artist_name = string;
for i=1:length(string)
    if (string(i) == ' ')
        string(i) = '+';
    end
end
string = strrep (string,'&','+');
string = strrep (string,'"','+');
string = strrep (string,'?','+');
string = strrep (string,'З','+');
string = strrep (string,'*','');
cycle_string = string;

url = strcat('http://www.zimbio.com/photos/',string,'/browse');
options = weboptions('Timeout',20);
data = webread(url,options);
data_custom = data;

string_data_find = '>[Last]';
data_find = strfind(data_custom,string_data_find)-2;
if data_find ~= 0
    data_custom = data_custom(1,1:data_find(1,1));
    string_data_find = '=';
    data_find = strfind(data_custom,string_data_find)+1;
    n = data_find(end);
    data_custom = data_custom(1,n:length(data_custom));
    count_of_page = str2num(data_custom);
else count_of_page = 1;
end



string_data_find = '<ul class="thumbnail-strip"';
data_string_data_find = strfind(data,string_data_find)+4;
data = data(1,data_string_data_find(1,1):length(data));
string_data_find = '</ul>';
data_string_data_find = strfind(data,string_data_find)-1;
data = data(1,1:data_string_data_find(1,1));

%»щем в нЄм все img src   
string_img_src_find = 'src="';
string_img_src_find_end = '.jpg';
data_string_img_src_find = strfind(data,string_img_src_find)+5;
data_string_img_src_find_end = strfind(data,string_img_src_find_end)+3;

img = cell(1,length(data_string_img_src_find));
for i=1:length(data_string_img_src_find)
    a = data_string_img_src_find(1,i);
    b = data_string_img_src_find_end(1,i);
    c = data(1,a:b);
    img{1,i} = c;
end
first_image = imread(img{1,1});
image(first_image);




% Hints: contents = cellstr(get(hObject,'String')) returns list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list


% --- Executes during object creation, after setting all properties.
function list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in menu.
function menu_Callback(hObject, eventdata, handles)
global innerHTML
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
url = ('http://www.zimbio.com/pictures/people/');
index = get(hObject, 'value');
string = get(hObject, 'string');
litera = string{index};
url = strcat(url,litera);
options = weboptions('Timeout',20);
data = webread(url,options);
%ќбрезаем массив data
string_data_find = '<div class="browseColumn">';
data_string_data_find = strfind(data,string_data_find)+26;
data = data(1,data_string_data_find(1,1):length(data));
string_data_find = '</div>';
data_string_data_find = strfind(data,string_data_find)-1;
data = data(1,1:data_string_data_find(1,3));


%»щем в нЄм все innerHTML   
string_data_find_i = strcat('">',litera);
string_end_data_find_i = '</a><br/>';
data_string_data_find_i = strfind(data,string_data_find_i)+2;
data_string_end_data_find_i = strfind(data,string_end_data_find_i)-1;

innerHTML = cell(1,length(data_string_data_find_i));
for i=1:length(data_string_data_find_i)
    a = data_string_data_find_i(1,i);
    b = data_string_end_data_find_i(1,i);
    c = data(1,a:b);
    c = strrep (c,'&#39;','''');
    c = strrep (c,'&amp;','&');
    c = strrep (c,'&quot;','"');
    innerHTML{1,i} = c;
end


set(handles.list,'string',innerHTML);



% Hints: contents = cellstr(get(hObject,'String')) returns menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menu



% --- Executes during object creation, after setting all properties.
function menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in parse.
function parse_Callback(hObject, eventdata, handles)
% hObject    handle to parse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global artist_name
global count_of_page
global cycle_string
artist_name = strrep (artist_name,'+','_');
artist_name = strrep (artist_name,' ','_');
eval(['!mkdir ' artist_name]);

img_array = cell(1,1);
iterator = 0;
for j=1:count_of_page
    url = strcat('http://www.zimbio.com/photos/',cycle_string,'/browse?Page=',num2str(j));
    options = weboptions('Timeout',20);
    data = webread(url,options);
    
    string_data_find = '<ul class="thumbnail-strip"';
    data_string_data_find = strfind(data,string_data_find)+4;
    data = data(1,data_string_data_find(1,1):length(data));
    string_data_find = '</ul>';
    data_string_data_find = strfind(data,string_data_find)-1;
    data = data(1,1:data_string_data_find(1,1));

    %»щем в нЄм все img src   
    string_img_src_find = 'src="';
    string_img_src_find_end = '.jpg';
    data_string_img_src_find = strfind(data,string_img_src_find)+5;
    data_string_img_src_find_end = strfind(data,string_img_src_find_end)+3;

    
    for i=1:length(data_string_img_src_find)
        a = data_string_img_src_find(1,i);
        b = data_string_img_src_find_end(1,i);
        c = data(1,a:b);
        img_array{1,i} = c;
    end
    for i=1:length(img_array)
        iterator = iterator + 1;
        image = imread(img_array{1,i});
        zeros_number = '/00000';
            if iterator >= 10
                zeros_number = '/0000';
            end
            if iterator >= 100
                zeros_number = '/000';
            end
            if iterator >= 1000
                zeros_number = '/00';
            end
            if iterator >= 10000
                zeros_number = '/0';
            end
            if iterator >= 100000
                zeros_number = '/';
            end
        name = [artist_name zeros_number num2str(iterator) '.jpg'];
        imwrite(image, name);
    end
end


% --- Executes on button press in cim.
function cim_Callback(hObject, eventdata, handles)
% hObject    handle to cim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global selected_image
x_count = str2num(get(handles.xcount,'String'));
y_count = str2num(get(handles.ycount,'String'));
width = size(selected_image, 2);
height = size(selected_image, 1);
a = mod(width, x_count) + 1;
b = mod(height, y_count) + 1;
if a ~= 1
    selected_image = selected_image(:,1:end - a,:);
    width = size(selected_image, 2);
end
if b ~= 1
    selected_image = selected_image(1:end - b,:,:);
    height = size(selected_image, 1);
end

part_width = floor((width / x_count));
part_height = floor((height / y_count));

image_cell_array = cell(1,1);
% ls *.jpg;
list = ls('*.jpg');
for i=1:size(list)
    image_cell_array{1,i} = imread(deblank(list(i,:)));
    thumb_width = size(image_cell_array{1,i}, 2);
    thumb_height = size(image_cell_array{1,i}, 1);
    a = thumb_width/thumb_height;
    b = part_width/part_height;
    w = image_cell_array{1,i};
    if a < b
        w = imresize(w ,[NaN part_width]);
        z = (size(w, 1) - part_height) / 2;
        z = floor(z + 1);
        w = w(z:z + part_height - 1,:,:);
    else
        w = imresize(w ,[part_height NaN]);
        z = (size(w, 2) - part_width) / 2;
        z = floor(z + 1);
        w = w(:,z:(size(w,2) - z + 1),:);
    end
    if (size(w,3) < 3)
        w = repmat(w,[1 1 3]);
    end
    image_cell_array{1,i} = w;
    
    t_m_r(i) = int32(median(median(w(:,:,1))));
    t_m_g(i) = int32(median(median(w(:,:,2))));
    t_m_b(i) = int32(median(median(w(:,:,3))));
end


for x=1:x_count
    for y=1:y_count
        index_x = floor((x - 1) * (width / x_count) + 1);
        index_y = floor((y - 1) * (height / y_count) + 1);
        m_r = int32(median(median(selected_image(index_y:index_y + part_height - 1, index_x:index_x + part_width - 1, 1))));
        m_g = int32(median(median(selected_image(index_y:index_y + part_height - 1, index_x:index_x + part_width - 1, 2))));
        m_b = int32(median(median(selected_image(index_y:index_y + part_height - 1, index_x:index_x + part_width - 1, 3))));
        find_thumbnail = (m_r - t_m_r).^2 + (m_g - t_m_g).^2 + (m_b - t_m_b).^2;
        [sort_thumbnail,i]=sort(find_thumbnail);
        n = randi(20,1);
        n = 1;
        index_thumbnail = i(n);
        selected_image(index_y:index_y + part_height - 1, index_x:index_x + part_width - 1,:) = imresize(image_cell_array{1,index_thumbnail},[part_height part_width]);
        image(selected_image);
        drawnow;
    end
end

function xcount_Callback(hObject, eventdata, handles)
% hObject    handle to xcount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xcount as text
%        str2double(get(hObject,'String')) returns contents of xcount as a double


% --- Executes during object creation, after setting all properties.
function xcount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xcount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ycount_Callback(hObject, eventdata, handles)
% hObject    handle to ycount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ycount as text
%        str2double(get(hObject,'String')) returns contents of ycount as a double


% --- Executes during object creation, after setting all properties.
function ycount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ycount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sim.
function sim_Callback(hObject, eventdata, handles)
% hObject    handle to sim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global selected_image
[FileName,PathName] = uigetfile('*.jpg','Select .jpg image');
if FileName ~= 0
    selected_image = imread([PathName '\' FileName ]);
    image(selected_image);
end


