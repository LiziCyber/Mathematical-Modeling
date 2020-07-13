function [w] = calculate(c,a)
    u=2./3;
    p=a./(c.*u);
    s=0;
    for k=0:c-1
        s=s+(1./factorial(k)).*(a./u).^k;
    end
    s=s+(1./factorial(c)).*(1./(1-p)).*(a./u).^c;
    P0=1./s;
    L0=P0.*(c.*p).^c.*p./(factorial(c).*(1-p).^2);
    Lq=0.5.*L0.*(1+(1-p).*(c-1).*((4+5.*c).^0.5-2)./16.*c.*p);
    w=Lq./a;
    w(isnan(w)|w<0)=0;
end

