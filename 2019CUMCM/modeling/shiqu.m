load shiqu.mat
%lb=0.208333333;
%ub=0.958333333;
%yj=time<lb|time>ub;
%rj=time>=lb&time<=ub;
d03=dis>0&dis<=3;
d30=dis>3;
cost=zeros(size(time,1),size(time,2));
cost(d03)=11;
cost(d30)=11+(dis(d30)-3).*2.1;