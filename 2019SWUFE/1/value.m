function [ B ] = value( Ind )
global w;
global N;
global TOP;
global A;
B=zeros(1,w);
for i=1:w
    sumS=0;
    ANS=0;
    for j=1:N
        if(sumS+A(Ind(j,i)+1,3)<TOP)
            sumS=sumS+A(Ind(j,i)+1,3);
        else
           ANS=ANS+1;
           sumS=A(Ind(j,i)+1,3);
        end
    end
    if(sumS>0)ANS=ANS+1;
    B(1,i)=ANS;
end
end
