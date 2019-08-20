function out = lab2_quadratic_roots()   
    %Global Equation ax^2 + bx + c
    global a b c;
    % a = 1;
    % b = 0;
    % c = -1;
    a = input('Enter A in Ax^2 + Bx + C ');
    b = input('Enter B in Ax^2 + Bx + C ');
    c = input('Enter C in Ax^2 + Bx + C ');
    
    discrinmate = solve_disc();
    
    if(discrinmate > 0)
        [root1, root2] = solve_quadratic(discrinmate);
        fprintf('Real Roots and values are \n Root 1 : %i \n Root 2 : %i \n', root1, root2);
    elseif(discrinmate == 0)
        [root, ] = solve_quadratic(discrinmate);
        fprintf('Real Roots and equal is \n Root  : %i \n', root);
    else
        fprintf('Imaginary Roots present \n');
    end
end

function d = solve_disc()
    global a b c;
    d = sqrt(b*b - 4*a*c);
end

function [root1, root2] = solve_quadratic(discrinmate)
    global a b;
    root1 = (-b + discrinmate)/(2*a);
    root2 = (-b - discrinmate)/(2*a);
end