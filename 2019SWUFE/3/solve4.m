global A;global B;
global N;global TOP;
load dataNo4_2.mat
TOP=60*24;
%%
%������ʼ��Ⱥ
N=size(B,2);
global w;
w=100;
for i=1:w
    C(:,i)=randperm(size(B,2));
end
%%
%�Ŵ�ʵ��
for k=1:10000
    for i=1:w
        D(i)=value1(C(:,i));
    end
    [D,R]=sort(D');
    C=C(:,R);
    %P=R./sum(R);
    C=C(:,1:65);%ɱ����35��
    for j=1:65
        C(:,66:100)=C(:,1:35);
    end
    for j=1:65
        if(rand()>0.5)
            cc=randi(20);
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
for i=1:w
    D(i)=value1(C(:,i));
end
[p,q]=min(D);
FinalANS=tran(C(:,q))';
