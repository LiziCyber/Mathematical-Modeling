for i=1:100
%%
clear;
clc;
load inputData.mat
%%
AM=22000;
dir=[0.25,0.36,0.18,0.20,0.01];
%初始化人数
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
    ss(:,:,k)=round( ss(:,:,k)./cur.*AM);
    N=sum(sum(ss(:,:,k)));
    if N>AM*dir(k)
        while N>AM*dir(k)
            x=unidrnd(a);
            y=unidrnd(b);
            if P(k).jud(x,y,1)
                ss(x,y,k)=ss(x,y,k)-1;
                N=N-1;
            end
        end
    elseif N<AM*dir(k)
        while N<AM*dir(k)
            x=unidrnd(a);
            y=unidrnd(b);
            if P(k).jud(x,y,1)
                ss(x,y,k)=ss(x,y,k)+1;
                N=N+1;
            end
        end
    end
end

%初始化人的速度 [2.5,3.5]
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
%模拟
U=unidrnd(600);
maxvis(5).m=[200]+U;
maxvis(4).m=[457,274,914,548,1096,548,365]+U;
maxvis(2).m=[1200,1372,515,686,2058,858,2058,686,1372]+U;
maxvis(3).m=[2216,1385]+26+U;
maxvis(1).m=[3462,3462,3462,2693,3462,3462]+U;

H=struct('ways',[]);
sout=struct('o',[]);
for i=1:c
    sout(i).o=zeros(1,num(i));
end
Tn=T;
TT=Inf(a,b,c);
TT=-TT;
H=struct('ch',[]);
%-2&2
for z=[5 3]
    for x=1:a
        for y=1:b
            if P(z).jud(x,y,1)
                choices=zeros(num(z),num(tra(z).trans(1)),num(tra(z).trans(2)));
                for i=1:num(z)
                    for j=1:num(tra(z).trans(1))
                        for k=1:num(tra(z).trans(2))
                            choices(i,j,k)=...
                                T(z).mit(x,y,i)...
                                +T(tra(z).trans(1)).mit(pos(z).x(i),pos(z).y(i),j)...
                                +T(tra(z).trans(2)).mit(pos(tra(z).trans(1)).x(j),pos(tra(z).trans(1)).y(j),k);
                        end
                    end
                end
                
                mc=min(choices(:));
                temp=find(choices==mc);
                [u,v,w]=ind2sub(size(choices),temp);
                H(x,y,z).ch=[u(1) v(1) w(1)];
                if isempty(sout(z).o(u(1)))
                    sout(z).o(u(1))=ss(x,y,z);
                else
                    sout(z).o(u(1))=sout(z).o(u(1))+ss(x,y,z);
                end
                if isempty(sout(tra(z).trans(1)).o(v(1)))
                    sout(tra(z).trans(1)).o(v(1))=ss(x,y,z);
                else
                    sout(tra(z).trans(1)).o(v(1))=sout(tra(z).trans(1)).o(v(1))+ss(x,y,z);
                end
                if isempty(sout(tra(z).trans(2)).o(w(1)))
                    sout(tra(z).trans(2)).o(w(1))=ss(x,y,z);
                else
                    sout(tra(z).trans(2)).o(w(1))=sout(tra(z).trans(2)).o(w(1))+ss(x,y,z);
                end
                
                if sout(z).o(u(1))>=maxvis(z).m(u(1))
                    T(z).mit(:,:,u(1))=Inf;
                end
                if sout(tra(z).trans(1)).o(v(1))>=maxvis(tra(z).trans(1)).m(v(1))
                    T(tra(z).trans(1)).mit(:,:,v(1))=Inf;
                end
                if sout(tra(z).trans(2)).o(w(1))>=maxvis(tra(z).trans(2)).m(w(1))
                    T(tra(z).trans(2)).mit(:,:,w(1))=Inf;
                end
            else
                H(x,y,z).ch=[];
            end
        end
    end
end
%-1%1
for z=[2 4]
    for x=1:a
        for y=1:b
            if P(z).jud(x,y,1)
                choices=zeros(num(z),num(tra(z).trans(1)));
                for i=1:num(z)
                    for j=1:num(tra(z).trans(1))
                        choices(i,j)=...
                            T(z).mit(x,y,i)...
                            +T(tra(z).trans(1)).mit(pos(z).x(i),pos(z).y(i),j);
                    end
                end
                mc=min(min(choices));
                [u,v]=find(choices==mc(1));
                H(x,y,z).ch=[u(1) v(1)];
                if isempty(sout(z).o(u(1)))
                    sout(z).o(u(1))=ss(x,y,z);
                else
                    sout(z).o(u(1))=sout(z).o(u(1))+ss(x,y,z);
                end
                if isempty(sout(tra(z).trans(1)).o(v(1)))
                    sout(tra(z).trans(1)).o(v(1))=ss(x,y,z);
                else
                    sout(tra(z).trans(1)).o(v(1))=sout(tra(z).trans(1)).o(v(1))+ss(x,y,z);
                end
                
                if sout(z).o(u(1))>=maxvis(z).m(u(1))
                    T(z).mit(:,:,u(1))=Inf;
                end
                if sout(tra(z).trans(1)).o(v(1))>=maxvis(tra(z).trans(1)).m(v(1))
                    T(tra(z).trans(1)).mit(:,:,v(1))=Inf;
                end
            else
                H(x,y,z).ch=[];
            end
        end
    end
end
%0
for z=[1]
    for x=1:a
        for y=1:b
            if P(z).jud(x,y,1)
                choices=zeros( num(z) );
                for i=1:num(z)
                    choices(i)=T(z).mit(x,y,i);
                end
                mc=min(choices);
                [u]=find(choices==mc(1));
                H(x,y,z).ch=[u(1)];
                if isempty(sout(z).o(u(1)))
                    sout(z).o(u(1))=ss(x,y,z);
                else
                    sout(z).o(u(1))=sout(z).o(u(1))+ss(x,y,z);
                end
                
                if sout(z).o(u(1))>=maxvis(z).m(u(1))
                    T(z).mit(:,:,u(1))=Inf;
                end
            else
                H(x,y,z).ch=[];
            end
        end
    end
end
W=zeros(a,b,c);
%2 -2
for i=1:a
    for j=1:b
        for k=[3 5]
            if P(k).jud(i,j,1) &&~isempty(H(i,j,k).ch)
                temp1=H(i,j,k).ch(1);
                temp2=H(i,j,k).ch(2);
                temp3=H(i,j,k).ch(3);
                x1=pos(k).x(temp1);
                y1=pos(k).y(temp1);
                x2=pos(tra(k).trans(1)).x(temp2);
                y2=pos(tra(k).trans(1)).y(temp2);
                W(i,j,k)=...
                    Tn(k).mit(i,j,temp1)+...
                    Tn(tra(k).trans(1)).mit(x1,y1,temp2)+...
                    Tn(tra(k).trans(2)).mit(x2,y2,temp3)+...
                    delta(k).time(temp1)+...
                    delta(tra(k).trans(1)).time(temp2)+...
                    delta(tra(k).trans(2)).time(temp3);
            else
                W(i,j,k)=NaN;
            end
        end
    end
end
%1 -1
for i=1:a
    for j=1:b
        for k=[2 4]
            if P(k).jud(i,j,1)
                temp1=H(i,j,k).ch(1);
                temp2=H(i,j,k).ch(2);
                x1=pos(k).x(temp1);
                y1=pos(k).y(temp1);
                W(i,j,k)=Tn(k).mit(i,j,temp1)+...
                    Tn(tra(k).trans(1)).mit(x1,y1,temp2)+...
                    delta(k).time(temp1)+...
                    delta(tra(k).trans(1)).time(temp2);
            else
                W(i,j,k)=NaN;
            end
        end
    end
end
%0
k=1;
for i=1:a
    for j=1:b
        if P(k).jud(i,j,1)&&~isempty(H(i,j,k).ch)
            temp1=H(i,j,k).ch(1);
            W(i,j,k)=Tn(k).mit(i,j,temp1)+...
                delta(k).time(temp1);
        else
            W(i,j,k)=NaN;
        end
    end
end

m5=max(W(:));
fid=fopen('FINALsummer22000.txt','a');
fprintf(fid,'%d %d\r\n',m5,U);
fclose(fid);
end
% 310=U