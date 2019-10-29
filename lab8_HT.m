function out = lab8_HT()
    %Initial Data
    global rho k mu T_in T_out T_s
    rho = 1000;
    k = 0.643;
    mu = 0.001;
    
    T_in = 30;
    T_out = 70;
    T_s = 100;
    
    Re = [1, 4, 10, 100, 1000];
    Cd = [24, 9, 4, 1, 0.44];
    
    [a,b] = linear_regression(Cd, Re);
    dt = 0.01;
    t_final = 0.1;
    t_init = 0;
    n = (t_final - t_init)/dt + 1;
    
    t(1) = t_init;
    v(1) = v0;
    y(1) = h;
    
    [y, v] = FDM(t, y, v);
end

function d = calc_D(Re)
    global rho Qh mu
    d = rho*Qh/(0.25*pi*mu*Re);
end

function Nu = calc_Nu(Re, d, L)
    global Pr
    if(Re < 2100)
        Nu = 0.023*Re^(0.8)*Pr^(0.33);
    else
        Nu = 3.66 + (0.668*(d/L)*Re*Pr)/(1+0.04*((d/L)*Re*Pr)^(0.66));
    end
end

function Cd = calc_Cd(v)
    global rho mu d a b
    Re = rho*v*d/mu;
    if(Re <= 1)
        Cd = 24/Re;
    elseif(Re >= 1000)
        Cd = 0.44;
    else
        Cd = 10^(a + b*log10(Re));
    end
end

function out = calc()
    global k Qh Qf
    
    Re = [5000:1000:50000];
    n = length(Re);
    L = 1;
    for i = 1:n
        Re_value = Re(i);
        d = calc_D(Re_value);
        Nu = calc_Nu(Re_value, d, L);
        hi = Nu*k/d;
        
        A = Qh/(hi*dT_lmtd);
        L = A/(pi*d);
        
        V = Qf/(0.25*pi*d^2);
        
        f = fzero(@)
        
        
    end
end
function y_diff = dvdt(v)
    global g rho_p rho d
    Cd = calc_Cd(v);
    y_diff = g - rho*g/rho_p - ((Cd*3*rho*(v^2))/(4*d*rho_p));
end

function [y, v] = FDM(t, y, v)
    global dt n
    for i = 1:n
        v(i+1) = v(i) + dt*dvdt(v(i));
        y(i+1) = y(i) - dt*v(i);
        t(i+1) = t(i) + dt;
        
        if(y(i+1) < 0)
            fprintf('Time take : %d\n',t(i));
            break
        end
    end
    figure
    plot(t, y, '-b');
    xlabel('t');
    ylabel('y');
    
    figure
    plot(t, v, '-r');
    xlabel('t');
    ylabel('v');
end

function [y, v] = inbuilt_ode(t, y, v)
    global t_init t_final
    [t, y] = ode45(@f_diff, [t_init, t_final], y(1));
    plot(t, y, '--g');
    hold on
end 