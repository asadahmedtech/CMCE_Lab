function out = lab8_HT_egg()
    global a b
    a = 0.07853;
    b = 23.79756;
    
    t = 0:5:100;
    
    [t, T] = ode45(@dTdt, t, 373);
    T = T - 273;
    figure;
    plot(t, T, 'r');
    hold on
    
    T_FDM(1) = 373;
    T_FDM = FDM(t, T_FDM);
    T_FDM = T_FDM - 273;
    plot(t, T_FDM, 'b');
    hold on
    
    xlabel('Time (t)');
    ylabel('Temperature (T)');
    legend('ODE45', 'FDM');
    
    t_exp = 0:5:50;
    T_exp = [100 87.5 77.2 68.8 61.9 56.2 51.5 47.7 44.5 41.9 39.8];
    T_exp = T_exp + 273;
    
    none = maam(t_exp, T_exp);
    [a, b] = linear_regression(t_exp, log(T_exp-303));
    
    figure;
    T_exp = log(T_exp - 303);
    plot(t_exp, T_exp, 'o');
    hold on
    plot(t_exp, a*t_exp+b, 'b');
    hold on
    xlabel('Time (t)');
    ylabel('Log(T - T0)');
    legend('Exp', 'Line');
    
    h = -a*6366.19777;
    fprintf('Heat transfer coefficent (h) : %f \n',h);
    
    
end

function diff = dTdt(t, T)
    global a b
    diff = -a*T + b;
end

function T = FDM(t, T)
    h = t(2) - t(1);
    for i=1:length(t)-1
        T(i+1) = T(i)+ dTdt(t(i), T(i))*h;
    end
end

function [a, b] = linear_regression(t, T)
    sT = sum(T);
    st = sum(t);
    sTt = sum(T.*t);
    st2 = sum(t.*t);
    n = length(t);
    
    a = (n*sTt -sT*st)/(n*st2 - st^2);
    b = (sT-a*st)/n;
end

function none = maam(t, T)
    for i=1:length(T)-1
        dTdt_values(i) = (T(i+1) - T(i))/5;
    end
    T(end) = [];
    [a1, b1] = linear_regression(T, dTdt_values);
    h = -a1*6366.19777;
    a1
    b1
    fprintf('Heat transfer coefficent (h) 1: %f \n',h);
    none = 0;
end
        
