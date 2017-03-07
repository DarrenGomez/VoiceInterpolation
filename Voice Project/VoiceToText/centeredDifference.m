function [A] = centeredDifference(n, g)
sWidth = n-2; %width of the solvable matrix
size = (n-2)^2; %size of the solvable matrix
M = diag(4 .* ones(1,n));
A = zeros(n, n); %solvable matrix
deltaX = 1/(n-1); %delta x
for(j = 2:n-1)
    for (i = 2: n-1)
        A(i,j) = sWidth * (i-2) + (j-1); 
    end
end
v = zeros(1,size);
counter = 1;
b = zeros(1,size); %Ax = b
for i=2:n-1 
    for j=2:n-1 %iterating through every value of A      
        if((A(i,j+1)) ~= 0)
        v(A(i,j+1)) = v(A(i,j+1)) - 1;
        else
            b(A(i,j)) = b(A(i,j)) + g(i,j+1);
        end
        if((A(i,j-1)) ~= 0)
            v(A(i,j-1)) = v(A(i,j-1)) - 1;
        else
            b(A(i,j)) = b(A(i,j)) + g(i,j-1);
        end
        if((A(i+1,j)) ~= 0)
            v(A(i+1,j)) = v(A(i+1,j)) - 1;
        else
            b(A(i,j)) = b(A(i,j)) + g(i+1,j);   
        end
        if((A(i-1,j)) ~= 0)
            v(A(i-1,j)) = v(A(i-1,j)) - 1;
        else
            b(A(i,j)) = b(A(i,j)) + g(i-1,j);
        end
        v(sWidth * (i-2) + (j-1)) = 4;
        M(counter,1:size) = v;
        counter = counter + 1;
        v = zeros(1,size);
   end
end
%display(M)
b = b*4*deltaX;
u = b/M;
for i=2:n-1 %display the values of u into the entire scheme
    for j=2:n-1
        A(i,j) = u(sWidth * (i-2) + (j-1));
    end
end
A=A+g;
%surface(A+g)
view(3)