r_lmd=[
    6.824660625
    6.623547438
    15.17250638
    ]./1.5;                   %����ʱ�μ��ڵĵ�λʱ������
c_lmd=32.7302/60;   %����ʱ��ľ�ֵ
m=1;
n=5;                %ÿ�γ���
tj=27.93;           %minutes
srA=66.53;          %A����
tk=30.38;           %����ƽ��ʱ��
dk=25.61;           %����ƽ������
prB=[0.31310944773139754;
    0.55067976718861;
    0.589972048788535];             %profitB

flag=zeros(3,1);
time=zeros(3,1);
while(sum(sum(flag~=0))~=3)
    s=mod(m,n);
    r=(m-s)/n;
    t=zeros(r+1,1);
    for k=1:3
        for l=1:1
            if(flag(k,l)~=0)
                continue;
            end
            avg=0;
            for i=1:100
                t(1:r)=gamrnd(n,1/r_lmd(k,l),[r 1]);
                t(r+1)=gamrnd(s,1/r_lmd(k,l));
                T=cumsum(t);
                
                qc=exprnd(c_lmd,[r+1,1]);
                qc=flip(cumsum(qc));
                
                if(s==0)
                    op=max(qc(1:r)+T(1:r));
                else
                    op=max(qc+T);
                end
                dlt=abs(avg-(avg*(i-1)+op)/i);
                avg=(avg*(i-1)+op)/i;
            end
            if((avg+tj-tk)*prB(k)>srA)
                flag(k,l)=m;
                time(k,l)=avg;
            end
        end
    end
    m=m+1
end
