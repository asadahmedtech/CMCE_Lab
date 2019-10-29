function out = lab8_fluidmech()
    %Initial Data
    global g rho rho_p mu d h v0 a b n dt t_init t_final
    g = 9.8;
    rho = 800;
    rho_p = 1200;
    mu = 0.02;
    
    d = 0.002;
    h = 1;
    v0 = 10^-6;
    
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

function [a, b] = linear_regression(Cd, Re)
    Re = log10(Re);
    Cd = log10(Cd);
    
    Re = Re(:);
    Cd = Cd(:);
    n = length(Re);
    sRe = sum(Re);
    sCd = sum(Cd);
    sRe2 = sum (Re.*Re);
    sReCd = sum(Re.*Cd);
    b = (n*sReCd -sRe*sCd)/(n*sRe2 - sRe^2);
    a = sCd/n-b*sRe/n;
    
    figure
    plot(Re, Cd, 'o');
    hold on
    plot(Re, b*Re + a, 'r');
    hold on
    
    xlabel('log10(Re)');
    ylabel('log10(Cd)');
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