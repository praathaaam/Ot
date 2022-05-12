clear all
clc
%%%%%%Conversion to required format for dual Simplex%%%%%%%
n_input = 2
m_input = 3
A_input = [3 1;4 3;1 2]
b_input = [3 6 4]
c_input = [-4 -1]
sign = [0 -1 1]
A = []
b = []
c = c_input
row_add = 0
for i = 1:m_input
 if sign(i) == 0
 A = [A;A_input(i,:)]
 b = [b b_input(i)]
 A = [A;-A_input(i,:)]
 b = [b -b_input(i)]
 row_add = row_add + 1
 else if sign(i) < 0
 A = [A;-A_input(i,:)]
 b = [b -b_input(i)]
 else
 A = [A;A_input(i,:)]
 b = [b b_input(i)]
 end
 end
end
m = m_input + row_add
n = n_input + m
S = eye(m)
A = [A S]
c = [c zeros(1,m)]
%%%%%%Staring solution for all slack variables%%%%%%%
index = []
for i = 1:m
 index = [index n_input+i]
end
B = []
Cb = []
for i = 1:m
    B = [B A(:,index(i))];
 Cb = [Cb c(index(i))];
end
X = zeros(n,1);
Xb = inv(B)*b';
X(index) = Xb;
y = inv(B)*A;
Net_eval = Cb*y - c
%%%%%%%%%%%%%%Computation for dual simplex%%%%%%%%%%%%%%%%
for s = 1:100
 if Net_eval >= -10^(-10) %Checking if the solution is optimal
 if Xb >= 0 %Checking if the solution is feasible
 disp("Solution is feasible")
 break
 else
 [x_min,LV] = min(Xb) %Most negative of Xb is leaving variable
 
 for j = 1:n
 if y(LV,j) < 0
 ratio(j) = abs(Net_eval(j)/y(LV,j))
 else
 ratio(j) = inf
 end
 end
 [r_min,EV] = min(ratio) %Gives the entering variable
 if r_min == inf %This is if all y_ij >= 0 in the leaving
 row
 disp("Solution is infeasible")
 break
 end
 index(LV) = EV
 B = []
 Cb = []
 for i = 1:m
 B = [B A(:,index(i))];
 Cb = [Cb c(index(i))];
 end
X = zeros(n,1);
Xb = inv(B)*b';
X(index) = Xb;
y = inv(B)*A;
Net_eval = Cb*y - c
 end
 else
 disp("Solution is not optimal")
 break
 end
end
disp(X)
c*X