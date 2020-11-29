% 求交并比,bz=[x y w h]
function result=qjbb(bz1,bz2)
    bz1 = bz1+[1 1 0 0];
    bz2 = bz2+[1 1 0 0];
    max_j = max(bz1(1)+bz1(3),bz2(1)+bz2(3));
    max_i = max(bz1(2)+bz1(4),bz2(2)+bz2(4));
    z=zeros(max_i,max_j);
    for i =[bz1(2):(bz1(2)+bz1(4)-1)]
        for j = [bz1(1):(bz1(1)+bz1(3)-1)]
            z(i,j) = z(i,j)+1;
        end
    end
    for i =[bz2(2):(bz2(2)+bz2(4)-1)]
        for j = [bz2(1):(bz2(1)+bz2(3)-1)]
            z(i,j) = z(i,j)+1;
        end
    end
    jiao = sum(sum(double(z>1)))
    bing = sum(sum(double(z>0)))
    result=jiao/bing;
end

% 整合txt
% q=zeros(200,4);
% for i =[1:200]
%     fname=sprintf('./bzbz/%d.txt',i);
%     data=importdata(fname);
%     q(i,:)=data;
% end
