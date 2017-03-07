D=192;
N=D;
Nu=D;
lambda=25;

du_max=0.1;
u_max=1.6;
u_min=0.6;

M=zeros(N,Nu);
for i=1:Nu
    M(i:N,i)=s(1:N-i+1);
end

Mp=zeros(N,D-1)
for i=1:(D-1)
    Mp(1:N,i)=s(i+1:N+i)-s(i);
end

I=eye(Nu);
K=((M'*M+lambda*I)^(-1))*M';

dUp=zeros(D-1,1);
Y0=zeros(N,1);
dU=zeros(Nu,1);

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
E=0;

Y_zad_dmc=zeros(N,1)
Y_dmc=zeros(N,1)
for k=15:n
    Y(k)=symulacja_obiektu6Y(U(k-10), U(k-11), Y(k-1), Y(k-2)); 
    y(k)=Y(k)-Ypp;
    e(k)=y_zad(k)-y(k); %uchyb
    
    Y_dmc(1:N,1)=y(k);
    Y_zad_dmc(1:N,1)=y_zad(k);
    
    Y0=Y_dmc+Mp*dUp;
    dU=K*(Y_zad_dmc-Y0);
    du=dU(1);
    
    %du-zmiana sterowania w danej chwili
    if du>du_max
        du=du_max;
    end
    if du<-du_max
        du=-du_max;
    end
    
    for n=D-1:-1:2;
      dUp(n)=dUp(n-1);
    end
    dUp(1)=du;
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

subplot(2,1,1);
stairs(U);
title('u(k)');
xlabel('k');
ylabel('u');
subplot(2,1,2);
stairs(Y);
hold on;
stairs(Y_zad);
xlabel('k');
legend('y','y_z_a_d','Location','southeast');