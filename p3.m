clear all;
n=3000;
Upp=1.1;
Ypp=2.5;
U(1:n)=Upp;
Y(1:11)=Ypp;

Y(12:n)=0;
s(1:n)=0;

%Opowiedzi skokowe dla DMC
U(15:n)=1.6;
for k=12:n
    Y(k)=symulacja_obiektu6Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
end
subplot(2,1,1);
stairs(U);
xlabel('k');
ylabel('U');
title('Sterowanie')
hold on;
subplot(2,1,2);
stairs(Y);
xlabel('k');
ylabel('Y');
title('Odpowiedz skokowa')
hold on;

%dla 207 kroku nastêpowa³a ostatnia zmiana wartoœci odpowiedzi(dok³adnoœæ
%0,001)
for k=16:n
    s(k-15)=(Y(k)-Ypp)/0.5;
end