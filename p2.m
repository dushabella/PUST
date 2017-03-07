clear all;
n=300;
U(1:n)=1.1;
Y(1:11)=2.5;
Y(12:n)=0;

Ustat(1:101)=0;
Ystat(1:101)=0;

%sprawdzenie poprawnoœci Upp, Ypp;
for k=12:1:n
    Y(k)=symulacja_obiektu6Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
end

%%wyznaczenie ró¿nych odpowiedzi skokowych
% for i=1:1:5
%     dU=i*0.1;
%     U(15:n)=1.1+dU;
%     for k = 12:n
%         Y(k) = symulacja_obiektu6Y(U(k-10), U(k-11), Y(k-1), Y(k-2));
%     end
% 
%     subplot(2,1,1);
%     stairs(U);
%     xlabel('k');
%     ylabel('U');
%     hold on;
%     subplot(2,1,2);
%     stairs(Y);
%     ylabel('Y');
%     hold on;
% end
% legend({'U=1,2','U=1,3','U=1,4','U=1,6','U=1,6'})

%charakterystyka statyczna
for i=1:101
    dU=(i-1)*0.005;
    U(15:n)=1.1+dU;
    for k=12:n
        Y(k)=symulacja_obiektu6Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
    end
    Ustat(i)=U(n);
    Ystat(i)=Y(n);
end
figure;
plot(Ustat, Ystat);
xlabel('u');
ylabel('y');
title('Charakterystyka statyczna y(u)');

%%wzmocnienie statyczne
K=(Ystat(101)-Ystat(1))/(Ustat(101)-Ustat(1))
angle=atan(K)
radtodeg(angle)