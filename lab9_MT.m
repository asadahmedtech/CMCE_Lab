dx=0.001;
D = 10e-9;
x=0:dx:0.01;
n= length(x);
C1=zeros(1, n);
dt=1;
time=0;
time_out = [0, 100, 500, 2000, 10000];
for t=1:dt:10001
    C2(1) = 0.5;
    for i =2:n-1
        C2(i) = C1(i) + (C1(i+1)-2*C1(i)+C1(i-1))*D*dt/dx^2 ;
    end
    C2(n)=0;
  
    if(ismember(time, time_out))
        plot(x,C2);
        hold on
    end
    
    time=time+dt;
    C1=C2;
end
legend('0s', '100s', '500s', '2000s', '10000s');
xlabel('x');
ylabel('C');