function out = lab5_integration()
%     X = [0 5 10 15 20 25 30 35 40];
%     Y = [0 6.67 17.33 42.67 37.33 30.1 29.31 28.74 27.12];
    
    [X, Y] = generate_points(0, 3, 0.1);
    area = solve_trapazoidal(X, Y);
    
    fprintf('The area of the points is %d using Trapazoidal Rule \n', area);
    plot_trapazoidal(X, Y);
    
    area = solve_simpson13(X, Y);
    fprintf('The area of the points is %d using Simpson 1/3 Rule \n', area);
    
    area = solve_simpson38(X, Y);
    fprintf('The area of the points is %d using Simpson 3/8 Rule \n', area);
    
end

function y = f(x)
    y = sin(x);
end

function [X, Y] = generate_points(a, b, h)
    X = [];
    Y = [];
    count = 1;
    for i=a:h:b
        X(count) = i;
        Y(count) = f(i);
        count = count + 1;
    end
end

function area = solve_trapazoidal(X, Y)
    area = 0;
    for i=1:length(X)-1
       area = area + 0.5*(X(i+1)-X(i))*(Y(i+1)+Y(i)); 
    end
end

function area = solve_simpson13(X, Y)
    area = 0;
    h = X(2) - X(1);
    
    for i=1:length(X)
        if(i==1 || i==length(X))
            area = area + Y(i);
        elseif(mod(i,2) == 0)
            area = area + 2*Y(i);
        else
            area = area + 4*Y(i);
        end
    end
    
    area = area*(h/3);
end

function area = solve_simpson38(X, Y)
    area = 0;
    h = X(2) - X(1);
    
    for i=1:length(X)
        if(i==1 || i==length(X))
            area = area + Y(i);
        elseif(mod(i,3) == 0)
            area = area + 2*Y(i);
        else
            area = area + 3*Y(i);
        end
    end
    
    area = area*((3*h)/8);
end

function out = plot_trapazoidal(X, Y)
    plot(X, Y, 'linewidth', 1);
    hold on
    stem(X, Y,'filled','r', 'linewidth', 1);
    for i=1:length(X)-1
        ar = area([X(i) X(i+1)], [Y(i) Y(i+1)], 'facecolor', 'R');
    end
    for i=1:length(X)-2
        ar = area([X(i) X(i+1)], [Y(i) Y(i+1)], 'facecolor', 'y');
        drawnow;
    end
end