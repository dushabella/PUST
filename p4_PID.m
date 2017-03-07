clear all;
close all;

Upp=1.1;
Ypp=2.5;
du_max=0.1;
u_max=1.6;
u_min=0.6;
Ts=0.5;
E=0;
K=3.95*0.5; Ti=17.5; Td=5;
 
r2 = K*Td/Ts;
r1 = K*(Ts/(2*Ti)-2*Td/Ts - 1);
r0 = K*(1+Ts/(2*Ti) + Td/Ts);
 
n=2500; %okres symulacji
U(1:n)=Upp;
Y(1:14)=Ypp;
Y_zad(1:14)=Ypp;
Y_zad(15:400)=2.7;
Y_zad(401:1000)=2.1;
Y_zad(1000:1500)=2.2;
Y_zad(1500:2000)=2.9;
Y_zad(2000:2500)=2.8;
u=U-Upp;
y_zad=Y_zad-Ypp;
y(1:n)=0;
e(1:n)=0;
u_max=1.6-Upp;
u_min=0.6-Upp;
 
for k=15:n
    Y(k)=symulacja_obiektu6Y(U(k-10), U(k-11), Y(k-1), Y(k-2)); 
    y(k)=Y(k)-Ypp;
    e(k)=y_zad(k)-y(k); %uchyb
    du=r2*e(k-2)+r1*e(k-1)+r0*e(k); %regulator PID
    if du>du_max
        du=du_max;
    end
    if du<-du_max
        du=-du_max;
    end
    u(k)=u(k-1)+du;
    if u(k)>u_max
        u(k)=u_max;
    end
    if u(k)<u_min
        u(k)=u_min;
    end
    U(k)=u(k)+Upp;
end
 
E=(norm(e))^2;

subplot(2,1,1)
stairs(U);
title('u(k)');
xlabel('k');
ylabel('u');
subplot(2,1,2)
stairs(Y);
hold on;
stairs(Y_zad);
xlabel('k');
legend('y','y_z_a_d');