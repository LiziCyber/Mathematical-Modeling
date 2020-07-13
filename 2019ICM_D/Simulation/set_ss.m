function Answer=set_ss(ss,bw)
global a;
global b;
for i=1:a
    for j=1:b
        if bw(i,j)
            ss(i,j)=rand();
        end
    end
end
Answer=ss;