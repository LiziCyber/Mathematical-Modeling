for i=1:150
clear;
clc;
load NEWDATA2

%%
%随机分布人
%初始化权值
%a0对应1楼 a1对应0楼
AM=20000;
[b0(:,1),b0(:,2)]=find(a0==1);
[b1(:,1),b1(:,2)]=find(a1==1);
dis_a0=zeros(a,b,2);
dis_a1=zeros(a,b,1);
for i=1:a
    for j=1:b
        if P(2).jud(i,j,1)
            dis_a0(i,j,1)=sqrt((i-b0(1,1))^2+(j-b0(1,2))^2)+0.01;
            dis_a0(i,j,2)=sqrt((i-b0(2,1))^2+(j-b0(2,2))^2)+0.01;
        else
            dis_a0(i,j,1)=NaN;
            dis_a0(i,j,2)=NaN;
        end
    end
end
for i=1:a
    for j=1:b
        if P(1).jud(i,j,1)
            dis_a1(i,j,1)=sqrt((i-b1(1,1))^2+(j-b1(1,2))^2)+0.01;
        else
            dis_a1(i,j,1)=NaN;
        end
    end
end
dis_a0(:,:,1)=f( dis_a0(:,:,1) );
dis_a0(:,:,1)=f( dis_a0(:,:,2) );
dis_a1(:,:,1)=f( dis_a1(:,:,1) );
d(:,:,1)=dis_a1(:,:,1);
d(:,:,2)=(dis_a0(:,:,1)+dis_a0(:,:,1))./2;
d(:,:,3)=zeros(a,b);
d(:,:,4)=zeros(a,b);
d(:,:,5)=zeros(a,b);
for k=3:c
    for i=1:a
        for j=1:b
           if P(k).jud(i,j,1)
                d(i,j,k)=1;
           end
        end
    end
end

ssum=zeros(c,1);
d(isnan(d)==1)=0;
for i=1:c
    ssum(i)=sum(sum(d(:,:,i)));
end
%初始化人数
dir=[0.25,0.36,0.18,0.2,0.01];
ss=zeros(a,b,c);
for k=1:c
    for i=1:a
        for j=1:b
           if P(k).jud(i,j,1)
                ss(i,j,k)=rand();
           end
        end
    end
    cur=sum( sum(ss(:,:,k)) );
    ss(:,:,k)=round(ss(:,:,k)./cur.*AM.*dir(k));
end

N=0;
for i=1:c
    N=N+sum(sum(ss(:,:,i)));
end

% while N>0
%     x=randi(52);
%     y=randi(74);
%     if P(1).jud(x,y,1)
%         continue;
%     else
%         ss(x,y,1)=ss(x,y,1)+1;
%     end
%     N=N-1;
% end

%初始化人的速度 [2.75,3]
v=zeros(a,b,5); 
for i=1:a
	for j=1:b
        for k=1:c
            if P(k).jud(i,j,1)
                v(i,j,k)=9/(2.5+rand());
            end
        end
	end
end

%初始化每层最短时间
T=struct('mit',[]);
for i=1:a
    for j=1:b
        for k=1:c
            cur=num(k);
            for l=1:cur
                T(k).mit(i,j,l)=D(k).mid(i,j,l).*v(i,j,k);
            end
        end
    end
end

%%
%初始化每个人的决策
H=struct('ways',[]);
for k=1:5
    for i=1:a
        for j=1:b
            if k==5                     
                H(i,j,k).ways=[unidrnd(1),unidrnd(7),unidrnd(6)];
            elseif k==4
                H(i,j,k).ways=[unidrnd(7),unidrnd(6)];
            elseif k==3
                H(i,j,k).ways=[unidrnd(2),unidrnd(9),unidrnd(6)];
            elseif k==2
                H(i,j,k).ways=[unidrnd(9),unidrnd(6)];
            elseif k==1
                H(i,j,k).ways=[unidrnd(6)];
            end
        end
    end
end
%%
%模拟
delta(5).time=[3.85];
delta(3).time=[10.28,10.08];
delta(4).time=[8.94,2.11,1.36,2.53,0.02,0,0];
delta(2).time=[0.08,2.08,7.04,3.84,0.33,4.83,0,5.38,5.74];
delta(1).time=[25.35,28.05,16.66,8.31,14.29,15.68];
%2 -> 0
for i=1:a
    for j=1:b
        if P(3).jud(i,j,1)
            temp1=H(i,j,3).ways(1);
            temp2=H(i,j,3).ways(2);
            temp3=H(i,j,3).ways(3);
            t1=T(3).mit(i,j,temp1);
            t2=T(2).mit(...
                pos(3).x(temp1),...
                pos(3).y(temp1),...
                temp2);
            t3=T(1).mit(...
                pos(2).x(temp2),...
                pos(2).y(temp2),...
                temp3);
            Tt(3).t(i,j)=t1+t2+t3+delta(3).time(temp1)+delta(2).time(temp2)+delta(1).time(temp3);
        else
            Tt(3).t(i,j)=NaN;
        end
    end
end
%1 -> 0
for i=1:a
    for j=1:b
        if P(2).jud(i,j,1)
            temp1=H(i,j,2).ways(1);
            temp2=H(i,j,2).ways(2);
            t1=T(2).mit(i,j,temp1);
            t2=T(2).mit(...
                pos(2).x(temp1),...
                pos(2).y(temp1),...
                temp2);
                Tt(2).t(i,j)=t1+t2+delta(2).time(temp1)+delta(1).time(temp2);
        else
            Tt(2).t(i,j)=NaN;
        end
    end
end
%0 -> 0
for i=1:a
    for j=1:b
        temp1=H(i,j,1).ways(1);
        Tt(1).t(i,j)=T(1).mit(i,j,temp1)+delta(1).time(temp1);
    end
end

%-2 -> 0
for i=1:a
    for j=1:b
        if P(5).jud(i,j,1)
            temp1=H(i,j,5).ways(1);
            temp2=H(i,j,5).ways(2);
            temp3=H(i,j,5).ways(3);
            t1=T(5).mit(i,j,temp1);
            t2=T(4).mit(...
                pos(5).x(temp1),...
                pos(5).y(temp1),...
                temp2);
            t3=T(1).mit(...
                pos(4).x(temp2),...
                pos(4).y(temp2),...
                temp3);
            Tt(5).t(i,j)=t1+t2+t3+delta(5).time(temp1)+delta(4).time(temp2)+delta(1).time(temp3);
        else
            Tt(5).t(i,j)=NaN;
        end
    end
end
%-1 -> 0
for i=1:a
    for j=1:b
        if P(2).jud(i,j,1)
            temp1=H(i,j,4).ways(1);
            temp2=H(i,j,4).ways(2);
            t1=T(4).mit(i,j,temp1);
            t2=T(1).mit(...
                pos(4).x(temp1),...
                pos(4).y(temp1),...
                temp2);
            Tt(4).t(i,j)=t1+t2+delta(4).time(temp1)+delta(1).time(temp2);
        else
            Tt(4).t(i,j)=NaN;
        end
    end
end
ST=[Tt(1:5).t];
ST(ST==Inf)=NaN;
fid=fopen('ordmax.txt','a');
fprintf(fid,'%d',max(max(ST)));
fprintf(fid,'\r\n');
fclose(fid);
% 
% m0=min(min([Tt(1:5).t]));
% for i=1:c
%     [Tp(i).x,Tp(i).y]=find((Tt(i).t>=m0+30)&(Tt(i).t<=10+150));
% end
% 
% sumH=zeros(1,num(1));
% sumB=zeros(1,num(1));
% for i=1:num(1)  %i个口
%     for j=1:c %每层从i出的人
%         for k=1:size(Tp(j).x)
%             if H(Tp(j).x(k),Tp(j).y(k),j).ways(end)==i
%                 sumH(i)=sumH(i)+ss(Tp(j).x(k),Tp(j).y(k),j);
%             	sumB(i)=sumB(i)+1;
%             end
%         end
%     end
% end

end