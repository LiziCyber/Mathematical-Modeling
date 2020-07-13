clear
r_lmd=4.466258125/1.5;%单位时间人数
c=32.7302/60;       %服务时间的均值
m=1;
tj=27.93;           %minutes
srA=66.53;          %A收入
tk=30.38;           %空载平均时长
dk=25.61;           %空载平均距离
prB=0.55067976718861;
M=0;
Qbar=0;

Qm=zeros(50,1);
Qt=zeros(50,1);
Q=zeros(50,1);
%%
for n=1:30
    c_lmd=5/(log(n+1)*c);
    r=r_lmd/(n*c_lmd);
    s=0;
    for k=0:n-1
        s=s+(r_lmd/c_lmd)^k/factorial(k);
    end
    s=s+(r_lmd/c_lmd)^n/factorial(n)/(1+r);
    P0=1/s;
    Q(n)=(1-P0)/c_lmd;

%%
    %确定M
    M=0;
    c_lmd=5/(log(n+1)*c);
    m=1;
    while(M==0)
        s=mod(m,n);
        r=(m-s)/n;
        t=zeros(r+1,1);
        avg=0;
        for i=1:100
            t(1:r)=gamrnd(n,1/r_lmd,[r 1]);
            t(r+1)=gamrnd(s,1/r_lmd);
            T=cumsum(t);
            
            qc=exprnd(c_lmd,[r+1,1]);
            qc=flip(cumsum(qc));
            
            if(s==0)
                op=max(qc(1:r)+T(1:r));
            else
                op=max(qc+T);
            end
            avg=(avg*(i-1)+op)/i;
        end
        if((avg+tj-tk)*prB>srA)
            M=m;
        end
        m=m+1;
    end
    
    %计算M对应的每一个Q
    sumq=0;
    for m=2:M
        s=mod(m,n);
        r=(m-s)/n;
        t=zeros(r+1,1);
        avg=0;
        for i=1:100
            t(1:r)=gamrnd(n,1/r_lmd,[r 1]);
            t(r+1)=gamrnd(s,1/r_lmd);
            T=cumsum(t);
            
            qc=exprnd(c_lmd,[r+1,1]);
            qc=flip(cumsum(qc));
            
            if(s==0)
                op=max(qc(1:r)+T(1:r));
            else
                op=max(qc+T);
            end
            avg=(avg*(i-1)+op)/i;
        end
        sumq=sumq+(m+1)/avg*poisscdf(2*c_lmd,m);
    end
    Qm(n)=sumq/(M-1);
    
%%
    v_lmd=137/2219*48614/24/60;
    
    c_lmd=5/(log(n+1)*c);
    r=v_lmd/(n*c_lmd);
    s=0;
    for k=0:n-1
        s=s+(v_lmd/c_lmd)^k/factorial(k);
    end
    s=s+(v_lmd/c_lmd)^n/factorial(n)/(1-r);
    P0=1/s;
    Qt(n)=(1-P0)/c_lmd;
end