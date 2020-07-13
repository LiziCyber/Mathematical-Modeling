for i=1:1
clear;
clc;
load NEWDATA

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
% 模拟
% 2层->k=3
% 1口
w3=[];
p3=[];
for i=1:a
    for j=1:b
        if P(3).jud(i,j,1)&&H(i,j,3).ways(1)==1
            w3=[w3,T(3).mit(i,j,1)];
            p3=[p3;i,j];
        end
    end
end
m3=min(min(w3));
s3=0;
feg3=0;
for i=1:size(p3,1)
    if w3(i)<=m3+20&&w3(i)>=m3+10
        s3=s3+ss(p3(i,1),p3(i,2),3);
        feg3=feg3+1;
    end
end
fid=fopen('ans2_1.txt','a');
fprintf(fid,'%d %d\r\n',s3,feg3);
fclose(fid);
%2口
w3=[];
p3=[];
for i=1:a
    for j=1:b
        if P(3).jud(i,j,1)&&H(i,j,3).ways(1)==2
            w3=[w3,T(3).mit(i,j,1)];
            p3=[p3;i,j];
        end
    end
end
m3=min(min(w3));
s3=0;
feg3=0;
for i=1:size(p3,1)
    if w3(i)<=m3+20&&w3(i)>=m3+10
        s3=s3+ss(p3(i,1),p3(i,2),3);
        feg3=feg3+1;
    end
end

fid=fopen('ans2_2.txt','a');
fprintf(fid,'%d %d\r\n',s3,feg3);
fclose(fid);
%-2层
w3=[];
p3=[];
for i=1:a
    for j=1:b
        if P(5).jud(i,j,1)&&H(i,j,5).ways(1)==1
            w3=[w3,T(5).mit(i,j,1)];
            p3=[p3;i,j];
        end
    end
end
m3=min(min(w3));
s3=0;
feg3=0;
for i=1:size(p3,1)
    if w3(i)<=m3+20&&w3(i)>=m3+10
        s3=s3+ss(p3(i,1),p3(i,2),5);
        feg3=feg3+1;
    end
end

fid=fopen('ans-2.txt','a');
fprintf(fid,'%d %d\r\n',s3,feg3);
fclose(fid);

end
