function varargout = untitled(varargin)
%clean console
clc
%get dirctory to add
directory= [pwd '\Data']
%add direcotory
addpath(directory)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 28-Jan-2022 01:00:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in openFileBtn.
function openFileBtn_Callback(hObject, eventdata, handles)
% hObject    handle to openFileBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% os = get(get(handles.uiAxes,'SelectedObject'), 'String');
% sensor = get(get(handles.uiSensor,'SelectedObject'), 'String');

%opening file, getting filename, data and path
[fileName, path] = uigetfile('*.txt*');

handles.fileName = fileName;
handles.path = path;
handles.data = openFile(fileName);
guidata(hObject, handles)



% --- Executes on button press in accelerometer.
function accelerometer_Callback(hObject, eventdata, handles)
% hObject    handle to accelerometer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of accelerometer


% --- Executes on button press in showData.
function showData_Callback(hObject, eventdata, handles)
% hObject    handle to showData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% assign data to variable
data=handles.data;

% get and convert settings data
windowLength=str2num(get(handles.windowLengthEditTxt,'String'));
windowOverlap=str2num(get(handles.windowOverlapEditTxt,'String'));
hiddenLayersSize=str2num(get(handles.hiddenLayersSizeEditTxt,'String'));
groups=str2num(get(handles.groupsEditTxt,'String'));

%get sensor name 
sensorName = get(get(handles.sensorGroup,'SelectedObject'), 'String');
% get data from choosen sensor
[sensorData, timeStamps]= getSensor(sensorName2SensorID(sensorName), data);
%get labeles hiddne in data
[labels, timeSeriesVect]=getLabels(data, timeStamps);
%interpolate signal
[vq]=interpolate(sensorData, timeSeriesVect);
% make features with given data
[labelsOut, featuresSensor] = makeFeatures(vq,labels,windowLength,windowOverlap);
%make permutations
[randFeaturesSensor, randLabels] = getPermutations(labelsOut, featuresSensor);
%corss validation
buffIndexes = getBuffIndexes(randFeaturesSensor,groups);
accuracy= corssValidation(buffIndexes, randFeaturesSensor, randLabels, groups,hiddenLayersSize);
% mean accuracy
meanAccuracy = getMeanAccuracy(accuracy);

% get data from x, y, z axis
[x, y, z] = getDataToChart(vq);
%set tick on Y axes
handles.axes1Tick=1:1:max([max(x) max(y) max(z) max(labels)]);
%plot x, y, z charts
 plot(handles.axes1, timeSeriesVect, x,'b', timeSeriesVect, y, 'g', timeSeriesVect ,z,'c');
 hold on
 %plot labels
 stem(timeSeriesVect(1:50:end), labels(1:50:end), 'r');
 hold off
 %display legend
legend('x', 'y', 'z', 'determination of movement')
%display mean accuracy
set(handles.meanAccuracyTxt, 'String', ['Mean Accuracy: '  num2str(meanAccuracy)]);



function windowLengthEditTxt_Callback(hObject, eventdata, handles)
% hObject    handle to windowLengthEditTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of windowLengthEditTxt as text
%        str2double(get(hObject,'String')) returns contents of windowLengthEditTxt as a double


% --- Executes during object creation, after setting all properties.
function windowLengthEditTxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to windowLengthEditTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function windowOverlapEditTxt_Callback(hObject, eventdata, handles)
% hObject    handle to windowOverlapEditTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of windowOverlapEditTxt as text
%        str2double(get(hObject,'String')) returns contents of windowOverlapEditTxt as a double


% --- Executes during object creation, after setting all properties.
function windowOverlapEditTxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to windowOverlapEditTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function groupsEditTxt_Callback(hObject, eventdata, handles)
% hObject    handle to groupsEditTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of groupsEditTxt as text
%        str2double(get(hObject,'String')) returns contents of groupsEditTxt as a double


% --- Executes during object creation, after setting all properties.
function groupsEditTxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to groupsEditTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hiddenLayersSizeEditTxt_Callback(hObject, eventdata, handles)
% hObject    handle to hiddenLayersSizeEditTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hiddenLayersSizeEditTxt as text
%        str2double(get(hObject,'String')) returns contents of hiddenLayersSizeEditTxt as a double


% --- Executes during object creation, after setting all properties.
function hiddenLayersSizeEditTxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hiddenLayersSizeEditTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
