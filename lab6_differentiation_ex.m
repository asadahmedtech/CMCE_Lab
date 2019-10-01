function out = lab6_differentiation_ex()
    global t_init t_final h n  
    t_init = 0; %Initial Value of range in t
    t_final = 10; %Final Value of range in t
    h = 0.5; %Step size for the range
    n = (t_final - t_init)/h; %Number of points in the range
    %f_diff = 3;
    
    % Defining arrays of t and y for plotting in the given range
    t(1) = 0; %Initial Value of t range
    y(1) = 2; %Initial Value of y
    
    y = FDM(t, y);
    fprintf('Finite Difference Method : %d \n', y(length(y)));
    y = exact_solution(t, y);
    fprintf('Exact Solution Method : %d \n', y(length(y)));
    y = inbuilt_ode(t, y);
    fprintf('Inbuild ODE Method : %d \n', y(length(y)));
end

function diff = f_d_diff(t, y)
    diff = -y;
end

function diff = f_diff(t, y)
    diff = -2*sin(t) + 3*cos(t);
end
function y = f(t)
    y = 2*cos(t) + 3*sin(t);
end

function y = FDM(t, y)
    global h n 
    for i = 1:n
        y(i+1) = y(i) + h*f_diff(t(i), y(i)) +(h*h)*f_d_diff(t(i), y(i))/2;
        t(i+1) = t(i) + h;
    end
    plot(t, y, '--sb')
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