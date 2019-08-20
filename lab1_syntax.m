%Matrix Defination
A = [1 2 3; 4 5 6; 7 8 9;];
B = A ^ -1;

[row, columns] = size(A);
for i = 1:rows
    for j = 1:columns
        B(j,i) = A(i, j);
    end
end
