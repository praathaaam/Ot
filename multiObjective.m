C1 = [2 3; 3 5];
r = size(C1, 1);
c = size(C1, 2);
% 
C = [];
W = 1/r;
val = [];
% 
for i = 1:c
    val = C1(:,i).*W;
    C(:,i) = sum(val);
end
% 
C = [C 0 0 0];
%C = [2 3 0 0 0];

A = [2 2 1 0 30; -1 -2 0 1 -10];

bv = [3 4];
zjcj = C(bv)*A - C;

RUN = true;

while RUN
    if any(A(:,size(A,2)) < 0)
        disp('current BFS is not feasible');

        [leaving_value, pivot_row] = min(A(:,size(A,2)));

        for i = 1:size(A,2) - 1
            if A(pivot_row, i) < 0
                m(i) = abs(zjcj(i)/A(pivot_row,i));
            else 
                m(i) = inf;
            end
        end
       
        [entering_value, pivot_column] = min(m);

        A(pivot_row, :) = A(pivot_row,:) / A(pivot_row,pivot_column);

        for i = 1:size(A,1)
            if i ~= pivot_row
                A(i,:) = A(i,:) - A(i,pivot_column).*A(pivot_row,:);
            end
        end
        
        bv(pivot_row) = pivot_column;
        zjcj = zjcj - zjcj(pivot_column).*A(pivot_row, :);
        ZCj = [zjcj ; A] 
        table = array2table(ZCj);
        table.Properties.VariableNames(1: size(ZCj,2)) = {'x_1','x_2','s_1','s_2','sol'};
    else
        disp('current BFS is feasible and optimal');
        RUN = false;
    end
end