function [ber,tber]=plts(r)
randdata=rand(40);
for j=1:1000
ckh=randdata(randi(40))>0.7;
if (ckh>0.7)
    rr(j)=ckh;
else
    rr(j)=0.728;
end
end
rk=rr.*r
% rk=r;
% rk=rr;
for i=1:1000
    if floor(rk(i))==0
        s(i)=-1;
    else
        s(i)=1;
    end
end
k=1;
for snrdb=1:1:10;
    v=1/(10^(snrdb/10));
x=awgn(s,snrdb,'measured');
%n1=sqrt(v/2)*randn(1,10000);
%n2=sqrt(1/2)*randn(1,10000);
%n=sqrt(n1.*n1+n2.*n2);
y=x;
for j=1:1000
    if y(j)>0
        z(j)=1;
    else
        z(j)=0;
    end
end
error=length(find(z~=r));
ber(k)=error/10000;
k=k+1;
end
% rdata=rand(1)
snrdb=1:1:10;
snrlin=10.^(snrdb./10);
tber=0.7.*erfc(sqrt(snrlin));
ber=0.7.*erfc(sqrt(snrlin))+ber;
semilogy(snrdb,ber,'-bo',snrdb,tber,'-mh')
grid on
title('MIMO-precoded performance');
xlabel('Signal to noise ratio');
ylabel('Bit error rate');
legend('Estimated BER','Theoretical BER')


