r_lmd=[
    4.60186875	5.09608125	5.5743375	5.36058125
    4.466258125	4.945906875	5.410069583	5.202612431
    10.23082125	11.32954875	12.3928025	11.91758208
    ]./1.5;                   %各个时段季节的单位时间人数
c_lmd=32.7302/60;   %服务时间的均值
m=1;
n=5;                %每次车数
tj=27.93;           %minutes
srA=66.53;          %A收入
tk=30.38;           %空载平均时长
dk=25.61;           %空载平均距离
prB=[0.31310944773139754;
    0.55067976718861;
    0.589972048788535];             %profitB

flag=zeros(3,4);
time=zeros(3,4);
while(sum(sum(flag~=0))~=12)
    s=mod(m,n);
    r=(m-s)/n;
    t=zeros(r+1,1);
    for k=1:3
        for l=1:4
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
    m=m+1;
end

