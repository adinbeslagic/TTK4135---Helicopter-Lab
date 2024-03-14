% TTK4135 - Helicopter lab
% Hints/template for problem 2.
% Updated spring 2018, Andreas L. Flåten

clear;
clc;

%% Initialization and model definition
init03; % Change this to the init file corresponding to your helicopter

global alpha beta lambda_t mx N
alpha = 0.2;
beta = 20;
lambda_t = (2/3)*pi;

% Discrete time system model. x = [lambda r p p_dot]'
delta_t	= 0.25; % sampling time
K1 = (K_f*l_h)/J_p;
K2 = (K_p*l_a)/J_t;
K3 = (l_a*K_f)/J_e;
A1 = ([0 1 0 0 0 0; ...
       0 0 -K2 0 0 0; ...
       0 0 0 1 0 0; ...
       0 0 -K1*K_pp -K1*K_pd 0 0; ...
       0 0 0 0 0 1; ...
       0 0 0 0 -K3*K_ep -K3*K_ed] * delta_t) + eye(6);
B1 = [0 0; 0 0; 0 0; K1*K_pp 0; 0 0; 0 K3*K_ep] * delta_t;

% Number of states and inputs
mx = size(A1,2); % Number of states (number of columns in A)
mu = size(B1,2); % Number of inputs(number of columns in B)

% Initial values
x1_0 = pi;                                  % Lambda
x2_0 = 0;                                   % r
x3_0 = 0;                                   % p
x4_0 = 0;                                   % p_dot
x5_0 = 0;                                   % e
x6_0 = 0;                                   % e_dot
x0 = [x1_0 x2_0 x3_0 x4_0 x5_0 x6_0]';      % Initial values

% Time horizon and initialization
N  = 40;                                % Time horizon for states
M  = N;                                 % Time horizon for inputs
z  = zeros(N*mx+M*mu,1);                % Initialize z for the whole horizon
z0 = z;                                 % Initial value for optimization

% Bounds
ul 	    = -(60*pi)/360;                  % Lower bound on control
uu 	    = (60*pi)/360;                   % Upper bound on control

xl      = -Inf*ones(mx,1);              % Lower bound on states (no bound)
xu      = Inf*ones(mx,1);               % Upper bound on states (no bound)
xl(3)   = ul;                           % Lower bound on state x3
xu(3)   = uu;                           % Upper bound on state x3

% Generate constraints on measurements and inputs
[vlb,vub]       = gen_constraints(N, M, xl, xu, ul, uu); % hint: gen_constraints
vlb(N*mx+M*mu)  = 0;                    % We want the last input to be zero
vub(N*mx+M*mu)  = 0;                    % We want the last input to be zero

% Generate the matrix Q and the vector c (objecitve function weights in the QP problem) 
Q1 = zeros(mx,mx);
Q1(1,1) = 1;                           % Weight on state x1
Q1(2,2) = 0;                           % Weight on state x2
Q1(3,3) = 0;                           % Weight on state x3
Q1(4,4) = 0;                           % Weight on state x4
Q1(5,5) = 0;                           % Weight on state x5
Q1(6,6) = 0;                           % Weight on state x6
P1 = diag([1 1]);                      % Weight on input
Q = gen_q(Q1, P1, N, M);               % Generate Q, hint: gen_q
c = zeros(size(Q,1), 1);               % Generate c, this is the linear constant term in the QP

%% Generate system matrixes for linear model
Aeq = gen_aeq(A1, B1, N, mx, mu);             % Generate A, hint: gen_aeq
beq = zeros(size(Aeq, 1), 1);                 % Generate b
beq(1:mx) = A1*x0;
%% Solve QP problem with linear model
fun =  @(z) 0.5*z'*Q*z;
nonlcon = @ineqcon;

opt = optimoptions('fmincon', 'Algorithm', 'sqp', 'MaxIter', 80000);

tic
[z, ~] = fmincon(fun, z0, [], [], Aeq, beq, vlb, vub, nonlcon, opt);
t1=toc;

% Calculate objective value
phi1 = 0.0;
PhiOut = zeros(N*mx+M*mu,1);
for i=1:N*mx+M*mu
  phi1=phi1+Q(i,i)*z(i)*z(i);
  PhiOut(i) = phi1;
end

%% Extract control inputs and states
u1  = [0; z(N*mx+1:2:N*mx+M*mu)];       % Control inputs from solution
u2  = [0; z(N*mx+2:2:N*mx+M*mu)];

x1 = [x0(1);z(1:mx:N*mx)];              % State x1 from solution
x2 = [x0(2);z(2:mx:N*mx)];              % State x2 from solution
x3 = [x0(3);z(3:mx:N*mx)];              % State x3 from solution
x4 = [x0(4);z(4:mx:N*mx)];              % State x4 from solution
x5 = [x0(5);z(5:mx:N*mx)];              % State x5 from solution
x6 = [x0(6);z(6:mx:N*mx)];              % State x6 from solution

num_variables = 5/delta_t;
zero_padding = zeros(num_variables,1);
unit_padding  = ones(num_variables,1);

u1  = [zero_padding; u1; zero_padding];
u2  = [zero_padding; u2; zero_padding];
u   = [u1 u2];
x1  = [pi*unit_padding; x1; zero_padding];
x2  = [zero_padding; x2; zero_padding];
x3  = [zero_padding; x3; zero_padding];
x4  = [zero_padding; x4; zero_padding];
x5  = [zero_padding; x5; zero_padding];
x6  = [zero_padding; x6; zero_padding];

Q_fb = diag([1 1 1 1 1 1]);
R_fb = diag([1 1]);
[K, P, e] = dlqr(A1, B1, Q_fb, R_fb);

t = 0:delta_t:delta_t*(length(u)-1);
u_ts = timeseries(u, t);
x_ts = timeseries([x1 x2 x3 x4 x5 x6], t);

%% Plotting

figure(2)
subplot(421)
stairs(t,u),grid
ylabel('u')
subplot(422)
plot(t,x1,'m',t,x1,'mo'),grid
ylabel('lambda')
subplot(423)
plot(t,x2,'m',t,x2','mo'),grid
ylabel('r')
subplot(424)
plot(t,x3,'m',t,x3,'mo'),grid
ylabel('p')
subplot(425)
plot(t,x4,'m',t,x4','mo'),grid
xlabel('tid (s)'),ylabel('pdot')
subplot(426)
plot(t,x5,'m',t,x5','mo'),grid
xlabel('tid (s)'),ylabel('e')
subplot(427)
plot(t,x5,'m',t,x5','mo'),grid
xlabel('tid (s)'),ylabel('e')
