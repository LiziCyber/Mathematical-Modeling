load data3
fid=fopen('data.txt','w');
fprintf(fid,'%d %d %d\r\n',a,b,num(1));

for i=1:a
    for j=1:b
        if P(1).jud(i,j,1)
            for k=1:num(1)
                if k~=4
                    fprintf(fid,'%d ',D(1).mid(i,j,k));
                end
            end
            fprintf(fid,'\r\n');
        end
    end
end


fclose(fid);