function varargout = u1(varargin)
% U1 M-file for u1.fig
%      U1, by itself, creates a new U1 or raises the existing
%      singleton*.
%
%      H = U1 returns the handle to a new U1 or the handle to
%      the existing singleton*.
%
%      U1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in U1.M with the given input arguments.
%
%      U1('Property','Value',...) creates a new U1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before u1_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to u1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help u1

% Last Modified by GUIDE v2.5 10-Nov-2018 14:22:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @u1_OpeningFcn, ...
                   'gui_OutputFcn',  @u1_OutputFcn, ...
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


% --- Executes just before u1 is made visible.
function u1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to u1 (see VARARGIN)

% Choose default command line output for u1
set(handles.shizi,'string','');
set(handles.jieguo,'string','');

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes u1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = u1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function shizi_Callback(hObject, eventdata, handles)
% hObject    handle to shizi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of shizi as text
%        str2double(get(hObject,'String')) returns contents of shizi as a double


% --- Executes during object creation, after setting all properties.
function shizi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shizi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function jieguo_Callback(hObject, eventdata, handles)
% hObject    handle to jieguo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of jieguo as text
%        str2double(get(hObject,'String')) returns contents of jieguo as a double


% --- Executes during object creation, after setting all properties.
function jieguo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jieguo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
aaa = get(handles.shizi,'String');
aaa = strcat(aaa,'1');
set(handles.shizi,'String',aaa);
guidata(hObject, handles);
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
aaa = get(handles.shizi,'String');
aaa = strcat(aaa,'2');
set(handles.shizi,'String',aaa);
guidata(hObject, handles);
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
aaa = get(handles.shizi,'String');
aaa = strcat(aaa,'3');
set(handles.shizi,'String',aaa);
guidata(hObject, handles);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
aaa = get(handles.shizi,'String');
aaa = strcat(aaa,'4');
set(handles.shizi,'String',aaa);
guidata(hObject, handles);
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
aaa = get(handles.shizi,'String');
aaa = strcat(aaa,'5');
set(handles.shizi,'String',aaa);
guidata(hObject, handles);
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
aaa = get(handles.shizi,'String');
aaa = strcat(aaa,'6');
set(handles.shizi,'String',aaa);
guidata(hObject, handles);
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
aaa = get(handles.shizi,'String');
aaa = strcat(aaa,'7');
set(handles.shizi,'String',aaa);
guidata(hObject, handles);
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
aaa = get(handles.shizi,'String');
aaa = strcat(aaa,'8');
set(handles.shizi,'String',aaa);
guidata(hObject, handles);
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
aaa = get(handles.shizi,'String');
aaa = strcat(aaa,'9');
set(handles.shizi,'String',aaa);
guidata(hObject, handles);
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
aaa = get(handles.shizi,'String');
aaa = strcat(aaa,'0');
set(handles.shizi,'String',aaa);
guidata(hObject, handles);
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
aaa = get(handles.shizi,'String');
aaa = strcat(aaa,'.');
set(handles.shizi,'String',aaa);
guidata(hObject, handles);
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
aaa=get(handles.shizi,'String');
as=char(aaa);
n=length(aaa);
aaa=as(1:n-1);
set(handles.shizi,'String',aaa);
guidata(hObject, handles);
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
aaa = get(handles.shizi,'String');
aaa = strcat(aaa,'+');
set(handles.shizi,'String',aaa);
guidata(hObject, handles);
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
aaa = get(handles.shizi,'String');
aaa = strcat(aaa,'-');
set(handles.shizi,'String',aaa);
guidata(hObject, handles);
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
aaa = get(handles.shizi,'String');
aaa = strcat(aaa,'*');
set(handles.shizi,'String',aaa);
guidata(hObject, handles);
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
set(handles.shizi,'String','');
set(handles.jieguo,'String','');
guidata(hObject, handles);
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
aaa = get(handles.shizi,'String');
aaa = strcat(aaa,'/');
set(handles.shizi,'String',aaa);
guidata(hObject, handles);
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
aaa = get(handles.shizi,'String');
set(handles.shizi,'String','');
value = eval(aaa);
set(handles.jieguo,'String',value);
guidata(hObject, handles);
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
bbb = get(handles.jieguo,'String');
aaa = get(handles.shizi,'String');
aaa = strcat(aaa,bbb);
set(handles.shizi,'String',aaa);
guidata(hObject, handles);
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


