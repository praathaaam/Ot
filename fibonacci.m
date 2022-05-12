clc;
clear;
f=@(x) x*(x-2);
l=0;
r=1.5;
n=4;
fibo=ones(1,n+1);
for i=3:n+1
    fibo(i)=fibo(i-1)+fibo(i-2);
end

for k=1:n
    ratio=fibo(n-k+1)/fibo(n-k+1+1);%+1 because indexing begins with 1 in matlab
    x2=l+ratio*(r-l);
    x1=l+r-x2;
    fx1=f(x1);
    fx2=f(x2);
    FT(k,:)=[k ratio l r x1 x2 fx1 fx2];
    if fx1>fx2
        l=x1;
    elseif fx1<fx2
            r=x2;
    elseif fx1==fx2
            if min(abs(x1),abs(l))==abs(l)
                r=x2;
            else
                l=x1;
            end
     end
end
 
T = array2table(FT);
T.Properties.VariableNames(1:8)={'k', 'ratio', 'l', 'r', 'x1', 'x2', 'fx1', 'fx2'};
T
optimal=f((l+r)/2)