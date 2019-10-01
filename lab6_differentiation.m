function out = lab6_differentiation()
    global t_init t_final h n 
    t_init = 0; %Initial Value of range in t
    t_final = 3; %Final Value of range in t
    h = 0.2; %Step size for the range
    n = (t_final - t_init)/h; %Number of points in the range
    
    % Defining arrays of t and y for plotting in the given range
    t(1) = 0; %Initial Value of t range
    y(1) = 1; %Initial Value of y
    
    y = FDM(t, y);
    fprintf('Finite Difference Method : %d \n', y(length(y)));
    y = RungeKutta4(t, y);
    fprintf('Runge Kutta Method : %d \n', y(length(y)));
    y = exact_solution(t, y);
    fprintf('Exact Solution Method : %d \n', y(length(y)));
    y = inbuilt_ode(t, y);
    fprintf('Inbuild ODE Method : %d \n', y(length(y)));
end

function diff = f_diff(t, y)
    diff = -y;
end

function y = f(t)
    y = exp(-t);
end

function y = FDM(t, y)
    global h n
    for i = 1:n
        y(i+1) = y(i) + h*f_diff(t(i), y(i));
        t(i+1) = t(i) + h;
    end
    plot(t, y, '--sb')
    hold on
end

function y = RungeKutta4(t, y)
    global h n
    for i = 1:n
        K1 = f_diff(t(i), y(i));
        K2 = f_diff(t(i) + 0.5 * h, y(i) + 0.5*K1*h);
        K3 = f_diff(t(i) + 0.5 * h, y(i) + 0.5*K2*h);
        K4 = f_diff(t(i) + h, y(i) + K3*h);
        
        y(i+1) = y(i) + h*(K1 + 2*K2 + 2*K3 + K4)/6;
        t(i+1) = t(i) + h;
    end
    plot(t, y, '--*r')
    hold on
end

function y = exact_solution(t, y)
    global h n
    for i = 1:n
        y(i) = f(t(i));
        t(i+1) = t(i) + h;
    end
    plot(t, y, '-ok')
    hold on
end

function y = inbuilt_ode(t, y)
    global t_init t_final
    [t, y] = ode45(@f_diff, [t_init, t_final], y(1));
    plot(t, y, '--+g')
    hold on
end