function out = lab7_ODE()
    global BCa BCb x_init x_final n t_init_guess t_final_guess
    BCa = 1; %Boundary Conditions
    BCb = 0; %Boundary Conditions
    x_init = 0; %Initial Value of range in x
    x_final = 1; %Final Value of range in x
    h = 0.1; %Step size for the range
    n = (x_final - x_init)/h; %Number of points in the range
    t_init_guess = 0; %Initial Value of range in T
    t_final_guess = 1; %Final Value of range in T
    
    y_matlab = solve_matlab();
    y_analytical = solve_analytical();
    legend('Matlab', 'Analytical')
    
end

function dtdx = odefun(x, f)
    f
    dtdx = [f(2); 0];
end

function res = bcfun(ta, tb)
    global BCa BCb
    
    res = [ta(1) - BCa; tb(1) - BCb];
end

function T = solve_matlab()
    global x_init x_final n t_init_guess t_final_guess
    solinit = bvpinit(linspace(x_init, x_final, n), [t_init_guess t_final_guess]);
    sol = bvp4c(@odefun, @bcfun, solinit);
    
    x = linspace(x_init, x_final, n);
    y = deval(sol, x);
    
    T = y(1, :);
    plot(x, T, 'o');
    xlabel('x');
    ylabel('T');
    hold on
end

function T = solve_analytical()
    global x_init x_final n

    x = linspace(x_init, x_final, n);
    T = 1 - x;
    
    plot(x, T, 'b');
    hold on
end