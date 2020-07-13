global A;
load data2.mat;
%%
%预处理
global TOP;
global N;
N=sum(A(:,2));1;
TOP=24*60;
B=zeros(N,1);
k=1;
for i=1:size(A,1)
    for j=1:A(i,2)
        B(k)=A(i,1);
        k=k+1;
    end
end
global w;
w=100;
C=zeros(N,w);
%产生初始种群
for i=1:w
    C(:,i)=B(randperm(size(B,1)));
end
%%
%遗传实现
for k=1:100000
    D=value(C);
    [D,R]=sort(D');
    C=C(:,R);
    %P=R./sum(R);
    C=C(:,1:50);
    
    for j=1:25
        %randi(25,2,1);
        C(:,51:100)=C(:,1:50);
    end
    for j=1:w
        if(rand()>0.5)
            cc=randi(N);
            C(cc:N,j)=flipud(C(cc:N,j));
        end
        if(rand()>0.3)
            cc=randi(N,2,1);
            z=C(cc(1),j);
            C(cc(1),j)=C(cc(2),j);
            C(cc(2),j)=z;
        end
    end
end
D=value(C);