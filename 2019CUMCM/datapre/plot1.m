%plot 0.1380 0.4004 0.4602
load airportdata.mat
[~,q]=sort(time);
number=number(q);
bar(number)
s=zeros(24,1);
for i=1:24
    s(i)=sum(number((time>=(i-1)*60*60)&(time<i*60*60)));
end
bar(s)
xlabel('时间');
ylabel('到港乘客数');
set(gca,'xtick',[0:24]);
sum(number(time<28800))/sum(number)
sum(number(time>28800&time<28800*2))/sum(number)
sum(number(time>28800*2))/sum(number)