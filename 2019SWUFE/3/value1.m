function [ ANS ] = value1( Ind )
%�������� ���ڵ�����
global A;
global B;
ANS=0;
for i=1:20
    if(i<=17)
        ANS=ANS+A(i,Ind(i));
    else
        ANS=ANS+B(Ind(i));
    end
end
end

