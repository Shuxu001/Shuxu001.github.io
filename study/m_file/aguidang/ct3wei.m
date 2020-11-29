function ct3wei
geshi={'*.dcm','Dicom image (*.dcm)';...
    '*.bmp','Bitmap image (*.bmp)';...
	'*.jpg','JPEG image (*.jpg)';...
	'*.*','All Files (*.*)'};
[FileName FilePath]=uigetfile(geshi,'导入外部图片','*.dcm','MultiSelect','on');
if ~isequal([FileName,FilePath],[0,0])
    FileFullName=strcat(FilePath,FileName);
    if ~ischar(FileFullName)
        FileFullName=FileFullName([2:end 1])';
    end
else
    return;
end
D=[];
n=length(FileFullName);
for i=1:n
    I=dicomread(FileFullName{i});
    %I=rgb2gray(I);
    D(:,:,i)=I;
end
Ds = smooth3(D);
figure
hiso = patch(isosurface(Ds,5),...
'FaceColor',[1,.75,.65],...
'EdgeColor','none');
hcap = patch(isocaps(D,5),...
'FaceColor','interp',...
'EdgeColor','none');
colormap copper
view(45,30) 
axis tight 
daspect([1,1,.8])
lightangle(45,30); 
set(gcf,'Renderer','zbuffer'); lighting phong
isonormals(Ds,hiso)
set(hcap,'AmbientStrength',.6)
set(hiso,'SpecularColorReflectance',0,'SpecularExponent',50)