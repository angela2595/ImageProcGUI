function varargout = ImageEnhance_GUI(varargin)
% IMAGEENHANCE_GUI MATLAB code for ImageEnhance_GUI.fig
%      IMAGEENHANCE_GUI, by itself, creates a new IMAGEENHANCE_GUI or raises the existing
%      singleton*.
%
%      H = IMAGEENHANCE_GUI returns the handle to a new IMAGEENHANCE_GUI or the handle to
%      the existing singleton*.
%
%      IMAGEENHANCE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEENHANCE_GUI.M with the given input arguments.
%
%      IMAGEENHANCE_GUI('Property','Value',...) creates a new IMAGEENHANCE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImageEnhance_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImageEnhance_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImageEnhance_GUI

% Last Modified by GUIDE v2.5 26-Feb-2015 10:57:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageEnhance_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageEnhance_GUI_OutputFcn, ...
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


% --- Executes just before ImageEnhance_GUI is made visible.
function ImageEnhance_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImageEnhance_GUI (see VARARGIN)

% Choose default command line output for ImageEnhance_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

addpath('\\136.159.100.80\tsar\SubProjects\SummerStudent\Angela\Breast Model Project\Alison Image Enhance Code');

% UIWAIT makes ImageEnhance_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImageEnhance_GUI_OutputFcn(hObject, eventdata, handles) 
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
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_file.
function load_file_Callback(hObject, eventdata, handles)
% hObject    handle to load_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

path = uigetdir('Choose Directory');

% Set edit1 to directory path
set(handles.edit1, 'String', path);

files = dir(fullfile(path, '*.dcm'));
fileNames = {files.name};

% Files are not set to .dcm
if isempty(fileNames)
    % Construct a questdlg with three options
        choice = questdlg('No .dcm files found, assume filetype?', ...
            'Warning', ...
            'Yes','Change folder','Exit','Exit');
        % Handle response
        switch choice
            case 'Yes'
                files = dir(fullfile(path));
                temp = {files.name}; 
                if strcmp(temp{1},'.') && strcmp(temp{2},'..')
                    fileNames = {temp{3:end}};
                else
                    fileNames = {files.name};
                end
                
            case 'Change folder'
                path = uigetdir('Choose Directory');
                files = dir(fullfile(path, '*.dcm'));
                fileNames = {files.name}; 

            case 'Exit'
                error('User exited program');
        end
end

if isempty(fileNames)
    error('fileNames still empty after user input');
end

numImages = length(fileNames);
mri_nocontrast = zeros(512,512,1,numImages);

for i = 1:numImages
    mri_nocontrast(:,:,1,i) = dicomread(fullfile(path, fileNames{i}));
end

a = dicominfo(fullfile(path, fileNames{1}));
mrinfo_nocontrast = a;

for i = 2:numImages
    a = dicominfo(fullfile(path,fileNames{i}));
    mrinfo_nocontrast = [mrinfo_nocontrast,a];
end

% mri_nocontrast(:,:,1,1) = dicomread(strcat(path,'\','Image00001.dcm'));
% a = dicominfo(strcat(path,'\','Image00001.dcm'));
% mrinfo_nocontrast = a;
% 
% if numImages < 10
%     for i=2:numImages
%         name = strcat(path,'\','Image0000',num2str(i),'.dcm');
%         mri_nocontrast(:,:,1,i) = dicomread(name);
%         a = dicominfo(name);
%         mrinfo_nocontrast = [mrinfo_nocontrast,a];
%     end
% elseif numImages > 10 && numImages < 100
%     for i=2:9
%         name = strcat(path,'\','Image0000',num2str(i),'.dcm');
%         mri_nocontrast(:,:,1,i) = dicomread(name);
%         a = dicominfo(name);
%         mrinfo_nocontrast = [mrinfo_nocontrast,a];
%     end
%     for i=10:numImages
%         name = strcat(path,'\','Image000',num2str(i),'.dcm');
%         mri_nocontrast(:,:,1,i) = dicomread(name);
%         a = dicominfo(name);
%         mrinfo_nocontrast = [mrinfo_nocontrast,a];
%     end
% elseif numImages > 100 && numImages < 1000
%     for i=2:9
%         name = strcat(path,'\','Image0000',num2str(i),'.dcm');
%         mri_nocontrast(:,:,1,i) = dicomread(name);
%         a = dicominfo(name);
%         mrinfo_nocontrast = [mrinfo_nocontrast,a];
%     end
%     for i=10:99
%         name = strcat(path,'\','Image000',num2str(i),'.dcm');
%         mri_nocontrast(:,:,1,i) = dicomread(name);
%         a = dicominfo(name);
%         c = [c,a];
%     end
%     for i=100:numImages
%         name = strcat(path,'\','Image00',num2str(i),'.dcm');
%         mri_nocontrast(:,:,1,i) = dicomread(name);
%         a = dicominfo(name);
%         mrinfo_nocontrast = [mrinfo_nocontrast,a];
%     end
% end

sz = size(mri_nocontrast);
rdgrd = mri_nocontrast;
handles.sz = sz;
handles.rdgrd = rdgrd;
handles.mrinfo_nocontrast = mrinfo_nocontrast;
guidata(hObject, handles);


% --- Executes on button press in apply_all.
function apply_all_Callback(hObject, eventdata, handles)
% hObject    handle to apply_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% msgbox('Choose folder to save processed files','Note');
path = uigetdir('','Pick Directory');
cd(path)

sz = handles.sz;
rdgrd = handles.rdgrd;
vec = handles.vec;
mrinfo_nocontrast = handles.mrinfo_nocontrast;
hWaitBar = waitbar(0,'Saving Images...');

for i=1:sz(4)
    for j=1:length(vec.x)
        m = rdgrd(:,:,:,i);
        skgrad = squeeze(rdgrd(:,:,1,i));
       
        rdgrd(:,:,:,i) = reducegradient(m,vec.y{j},vec.x{j},skgrad);
      
        gradientbox(i,:,:,:,:)=[i vec.x{j} vec.y{j}];
        rdgrd(:,:,:,i)=reducegradient(m,[gradientbox(i,4) gradientbox(i,5)],[gradientbox(i,2) gradientbox(i,3)],skgrad);
        
        if i<10
            name = ['TestImage0000' num2str(i) '.dcm'];
        else
            name = ['TestImage000' num2str(i) '.dcm'];
        end
        dicomwrite(uint16(rdgrd(:,:,:,i)), name, mrinfo_nocontrast(i));
        waitbar(i/sz(4));
    end
end

close(hWaitBar);


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sliceEditFlag = 1;
sz = handles.sz;
rdgrd = handles.rdgrd;
while(sliceEditFlag)
    i = inputdlg(['Enter slice to modify (Slice must be between 1 and ', num2str(sz(4)),'):'],'Input');
    i = str2double(i{1});
    if ( i > sz(4) || i < 1)
        warndlg('Your input is Invalid','Invalid Input');
        sliceEditFlag = 0;
        break;
    end
    axes(handles.before);
    m = rdgrd(:,:,:,i);
    imshow(m,[]);
    title(['Image Number' ' ' num2str(i)]);
    set(handles.before,'Visible','off');

    % iteratively modify each slice
    editSliceFlag = 1;
    count=1;    
    while(editSliceFlag)
        [x,y] = ginput(2);
        x = [floor(x(1)) ceil(x(2))];
        y = [floor(y(1)) ceil(y(2))];
        handles.vec.x{count}=x;
        handles.vec.y{count}=y;
        guidata(hObject, handles);
        
        skgrad = squeeze(rdgrd(:,:,1,i));
        
        m_0 = m;
        rdgrd(:,:,:,i) = reducegradient(m,y,x,skgrad);
        
        gradientbox(i,:,:,:,:)=[i x y];
        rdgrd(:,:,:,i)=reducegradient(m,[gradientbox(i,4) gradientbox(i,5)],[gradientbox(i,2) gradientbox(i,3)],skgrad);
        
        axes(handles.after);
        imshow(rdgrd(:,:,:,i),[]);
        title(['Image after ',num2str(count), 'iterations']);  
        set(handles.after,'Visible','off');
        
        axes(handles.axes3);
        imshow(m - rdgrd(:,:,:,i),[]);
        title(['Change after ',num2str(count), ' iterations']);  
        set(handles.axes3,'Visible','off');
        
        prompt = 'Is the revised image OK?';
        choice = questdlg(prompt,'Confirm','Yes','No','Yes');
        if ( strcmp(choice,'No') )            
            m = m_0;
        else
            m = rdgrd(:,:,:,i);
            prompt= 'Perform another iteration?';     
            choice = questdlg(prompt,'Confirm','Yes','No','Yes');
            if ( strcmp(choice,'No') )
                editSliceFlag = 0;
                sliceEditFlag = 0;
                msgbox('Click "Apply to All" to apply changes to all images','Note');
            end
            count=count+1;
        end
    end
end
