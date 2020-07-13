for i=1:1
clear;
clc;
load NEWDATA2

%%
AM=20000;

%��ʼ������
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


%��ʼ���˵��ٶ� [2.5,3.5]
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

%��ʼ��ÿ�����ʱ��
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
%ģ��

delta(5).time=[3.85];
delta(3).time=[10.28,10.08];
delta(4).time=[8.94,2.11,1.36,2.53,0.02,0,0];
delta(2).time=[0.08,2.08,7.04,3.84,0.33,4.83,0,5.38,5.74];
delta(1).time=[25.35,28.05,16.66,8.31,14.29,15.68];

maxvis(5).m=[200]+26;
maxvis(4).m=[457,274,914,548,1096,548,365]+26;
maxvis(2).m=[1200,1372,515,686,2058,858,2058,686,1372]+26;
maxvis(3).m=[2216,1385]+26;
maxvis(1).m=[3462,3462,3462,2693,3462,3462]+350;

tra(1).trans=[];
tra(2).trans=[1];
tra(3).trans=[2 1];
tra(4).trans=[1];
tra(5).trans=[4 1];

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
                
                if choices(u,v,w)==Inf
                    continue
                end
                TT(x,y,z)=temp;
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
                if choices(u,v)==Inf
                    continue
                end
                TT(x,y,z)=temp;
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
for z=[2 1]
    for x=1:a
        for y=1:b
            if P(z).jud(x,y,1)
                choices=zeros( num(z) );
                for i=1:num(z)
                    choices(i)=T(z).mit(x,y,i);
                end
                mc=min(choices);
                [u]=find(choices==mc(1));
                if choices(u)==Inf
                    continue
                end
                TT(x,y,z)=temp;
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


end