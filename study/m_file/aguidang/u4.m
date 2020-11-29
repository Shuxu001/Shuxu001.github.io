function varargout = u4(varargin)
% U4 M-file for u4.fig
%      U4, by itself, creates a new U4 or raises the existing
%      singleton*.
%
%      H = U4 returns the handle to a new U4 or the handle to
%      the existing singleton*.
%
%      U4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in U4.M with the given input arguments.
%
%      U4('Property','Value',...) creates a new U4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before u4_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to u4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help u4

% Last Modified by GUIDE v2.5 23-Dec-2018 21:22:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @u4_OpeningFcn, ...
                   'gui_OutputFcn',  @u4_OutputFcn, ...
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


% --- Executes just before u4 is made visible.
function u4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to u4 (see VARARGIN)

% Choose default command line output for u4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes u4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = u4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)   
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in der1.
function der1_Callback(hObject, eventdata, handles)
a=get(handles.edit1,'String');
b=str2num(a);
c=polyder(b);
d=poly2str(c,'x');
set(handles.text1,'String',d);

% hObject    handle to der1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in der2.
function der2_Callback(hObject, eventdata, handles)
a=get(handles.edit2,'String');
b=str2num(a);
c=polyder(b);
d=poly2str(c,'x');
set(handles.text1,'String',d);
% hObject    handle to der2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in gen1.
function gen1_Callback(hObject, eventdata, handles)
a=get(handles.edit1,'String');
b=str2num(a);
c=roots(b)';
d=num2str(c);
set(handles.text1,'String',d);
% hObject    handle to gen1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in gen2.
function gen2_Callback(hObject, eventdata, handles)
a=get(handles.edit2,'String');
b=str2num(a);
c=roots(b)';
d=num2str(c);
set(handles.text1,'String',d);
% hObject    handle to gen2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in zhi1.
function zhi1_Callback(hObject, eventdata, handles)
a=get(handles.edit1,'String');
aa=get(handles.edit3,'String');
b=str2num(a);
bb=str2num(aa);
vi=polyval(b,bb);
d=num2str(vi);
set(handles.text1,'String',d);
% hObject    handle to zhi1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in zhi2.
function zhi2_Callback(hObject, eventdata, handles)
a=get(handles.edit2,'String');
aa=get(handles.edit3,'String');
b=str2num(a);
bb=str2num(aa);
vi=polyval(b,bb);
d=num2str(vi);
set(handles.text1,'String',d);
% hObject    handle to zhi2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in shi1.
function shi1_Callback(hObject, eventdata, handles)
a1=get(handles.edit1,'String');
a2=get(handles.edit2,'String');
b1=str2num(a1);
b2=str2num(a2);
l1=length(b1);
l2=length(b2);
if l1>l2
    dl=l1-l2;
    b3(1:dl)=0;
    b3(dl+1:l1)=b2;
    b4=b1+b3;
end
if l1<l2
    dl=l2-l1;
    b3(1:dl)=0;
    b3(dl+1:l2)=b1;
    b4=b2+b3;
end
if l1==l2
    b4=b1+b2;
end
c=poly2str(b4,'x');
set(handles.text1,'String',c);
% hObject    handle to shi1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in shi2.
function shi2_Callback(hObject, eventdata, handles)
a1=get(handles.edit1,'String');
a2=get(handles.edit2,'String');
b1=str2num(a1);
b2=str2num(a2);
l1=length(b1);
l2=length(b2);
if l1>l2
    dl=l1-l2;
    b3(1:dl)=0;
    b3(dl+1:l1)=b2;
    b4=b1-b3;
end
if l1<l2
    dl=l2-l1;
    b3(1:dl)=0;
    b3(dl+1:l2)=b1;
    b4=b3-b2;
end
if l1==l2
    b4=b1-b2;
end
c=poly2str(b4,'x');
set(handles.text1,'String',c);
% hObject    handle to shi2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in shi3.
function shi3_Callback(hObject, eventdata, handles)
a1=get(handles.edit1,'String');
a2=get(handles.edit2,'String');
b1=str2num(a1);
b2=str2num(a2);
c=conv(b1,b2);
d=poly2str(c,'x');
set(handles.text1,'String',d);
% hObject    handle to shi3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in shi4.
function shi4_Callback(hObject, eventdata, handles)
a1=get(handles.edit1,'String');
a2=get(handles.edit2,'String');
b1=str2num(a1);
b2=str2num(a2);
[C c]=deconv(b1,b2);
D=poly2str(C,'x');
d=poly2str(c,'x');
e=[D '  ...' d];
set(handles.text1,'String',e);
% hObject    handle to shi4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in ca1.
function ca1_Callback(hObject, eventdata, handles)
set(handles.edit1,'String','');
% hObject    handle to ca1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ca2.
function ca2_Callback(hObject, eventdata, handles)
set(handles.edit2,'String','');
% hObject    handle to ca2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in jie1.
function jie1_Callback(hObject, eventdata, handles)
a=get(handles.text1,'String');
set(handles.text4,'String',a);
% hObject    handle to jie1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

