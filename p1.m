for i=1:1:300
    U(i)=1.1;
    Y(i)=0;
end
for k=12:1:300
Y(k)=symulacja_obiektu6Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
end