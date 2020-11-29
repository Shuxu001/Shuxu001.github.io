tic
i=1:.5:60;

beta1=pi/2+pi/18*i;
rho1=0.1*beta1;
x1=rho1.*cos(beta1);
y1=rho1.*sin(beta1);

beta2=-(pi/2+pi/18*i);
rho2=0.1*beta2;
x2=rho2.*cos(beta2);
y2=-rho2.*sin(beta2);

plot(x1,y1,'b.');
hold on;
plot(x2,y2,'r+');
hold on;

xy=[x1',y1';x2',y2'];
l1=size(x1);
l=l1(2);
Index=[ones(l,1);-ones(l,1)];

C=1;sigma2=0.04;

%%%%%%%%%%%%%%%%%%%%%
%上界与下界
lb=zeros(2*l,1);ub=C*ones(2*l,1);

beq=0;Aeq=Index';
for i=1:2*l
    for j=1:2*l
        K(i,j)=kernel((xy(i,:))',(xy(j,:))',sigma2);
    end
end
f=-ones(2*l,1);

t=diag(Index);
H=t'*K*t;
% 
x0=0.1*ones(2*l,1);
options=optimset('LargeScale','off','MaxIter',inf);
[alpha,fval,exitflag,output]=quadprog(H,f,[],[],Aeq,beq,lb,ub,x0,options);
% for i=1:2*l
%     if(abs(alpha(i))<0.000001)
%         alpha(i)=0;
%     end
% end
B=1./Index-K*alpha.*Index;
b=mean(B);



[xx,yy]=meshgrid(-1.5:.05:1.5,-1.5:.05:1.5);
x=xx(1,:);y=yy(:,1);
for i=1:length(x)
    for j=1:length(y)
        z=[x(i);y(j)];
        temp=0;
        for k=1:2*l
            temp=temp+Index(k)*alpha(k)*kernel(z,(xy(k,:))',sigma2);
        end
        Z(j,i)=temp+b;
    end
end
v=[0,0];
cs=contour(xx,yy,Z,v,'b');

toc