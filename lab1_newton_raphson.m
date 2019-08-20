function out = lab1_newton_raphson()   
    %Global Equation ax^2 + bx + c
    global a b c;
    % a = 1;
    % b = 0;
    % c = -1;
    a = input('Enter A in Ax^2 + Bx + C');
    b = input('Enter B in Ax^2 + Bx + C');
    c = input('Enter C in Ax^2 + Bx + C');
    out = solve_quadratic(-10,0.01);
end

function y = f(x)
    %Equation
    % syms x; System Toolbox unavailable
    global a b c;
    y = a * x^2 + b * x + c;
end

function y = f_diff(x)
    %Differentiated equation
    global a b;
    y = 2*a*x + b;
    % y = diff(f(x)); With the availablity of SYMS this will work 
end

function x_new = newton_raphson(x_old)
    %Newton Raphson
    x_new = x_old - (f(x_old) / f_diff(x_old));
end

function roots = solve_quadratic(x_init, threshold)
    %iterative solution of Newton Raphson
    figure
    hold on
    
    x_old = newton_raphson(x_init);
    diff = abs((x_old - x_init)/x_old);
    while diff > threshold
        x_new = newton_raphson(x_old);
        diff = abs((x_new - x_old)/x_new);
        
        x_old = x_new;
        
        plot_points(x_new);
        hold on
    end
    roots = x_new;
end

function out = plot_points(newton_x)
    %plotting equation and solution
    global a b c;
    temp_x = [-1:0.1:5];
    temp_y = a * temp_x.^2 + b * temp_x + c;
    
    slope = f_diff(newton_x);
    diff_x = [-1:0.1:5];
    c_tangent = f(newton_x) - slope*newton_x;
    diff_y = slope * diff_x + c_tangent;
    plot(temp_x, temp_y, 'r', diff_x, diff_y , 'k--')
end
