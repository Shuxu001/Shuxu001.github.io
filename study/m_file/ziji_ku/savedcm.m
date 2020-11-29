% 保存成一系列的dcm,输入4维图
function y=savedcm(img4d)
y=0;
    n=size(img4d);n=n(4);
    m=ceil(log10(n));
    s=struct();
    s.SeriesInstanceUID='1';
    s.StudyInstanceUID='1';
    s.PatientName.FamilyName='aaa';
    for i = 1:n
        pi=int16(gyh(img4d(:,:,:,i))*32767);
        ii=num2str(i+10^m);
        dicomwrite(pi,['./dcms/',ii(2:m+1),'.dcm'],s);
    end
    y=1;
end
