clear;
clc;
% x = quadprog(H,f,A,b,Aeq,beq,lb,ub,x0) 

lambda_0 = pi;
lambda_f = 0;
x_0 = [lambda_0; 0; 0; 0];
x_f = [lambda_f; 0; 0; 0];
p_k = (60*pi)/360;




