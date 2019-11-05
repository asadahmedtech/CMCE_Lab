Qf=5/3600;
K=0.643;
rho=1000;
Cp=4184;
M=rho*Qf;
mu=0.001;
Pr=Cp*mu/K;
T_lmtd=40/(log(70/30));
Qh=M*Cp*40;

Re = 5000:1000:50000;
n = length(Re);
for i = 1:n
    Re_value = Re(i);
    
    Di = M/(Re_value*mu*(3.14/4));
    Hi = (0.23*(Re_value^0.8)*(Pr^0.33)*K)/Di;
    A = Qh/(Hi*T_lmtd);
    L = A/(3.14*Di);
    u = Qf/(0.25*3.14*Di^2);
    fun = @(f)((1/sqrt(f))+2*log10(2.51/(Re_value*f^0.5)));
    fun0 = 0.05;
    sol = fzero(fun,fun0);
    dP = (sol*L*u^2)/(Di*2*9.8);
    F(i) = 3.14*Di*L+Qf*dP;
    
end
plot(Re, F);
hold on


    
    
    
    