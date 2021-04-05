%% Initialization and model definition

init05; % Helicopter model params

% Discrete time system model. x = [lambda r p p_dot e e_dot]'
delta_t	= 0.25; % sampling time
A1 = [
    1 delta_t 0 0 0 0
    0 1 -K_2*delta_t 0 0 0
    0 0 1 delta_t 0 0
    0 0 -K_1*K_pp*delta_t 1-K_1*K_pd*delta_t 0 0
    0 0 0 0 1 delta_t
    0 0 0 0 -K_3*K_ep*delta_t 1-K_3*K_ed*delta_t];
B1 = [
    0 0
    0 0
    0 0
    K_1*K_pp*delta_t 0
    0 0
    0 K_3*K_ep*delta_t      
];

% Number of states and inputs
mx = size(A1,2); % Number of states (number of columns in A)
mu = size(B1,2); % Number of inputs(number of columns in B)

% Initial values
x1_0 = pi;                              % Lambda
x2_0 = 0;                               % r 
x3_0 = 0;                               % p
x4_0 = 0;                               % p_dot
x5_0 = 0;                               % e
x6_0 = 0;                               % e_dot 
x0 = [x1_0 x2_0 x3_0 x4_0 x5_0 x6_0]';  % Initial values

% Time horizon and initialization
N  = 40;                                        % Time horizon for states
M  = N;                                         % Time horizon for inputs
z  = zeros(N*mx+M*mu,1);                        % Initialize z for the whole horizon

z0 = [x0; zeros(N*mx+M*mu-size(x0,1), 1)];      % Initial value for optimization

% Bounds
alpha = 0.2;
beta = 20;
lambda_t = 2*pi/3;
ul 	    = [-30*pi/180; -Inf];           % Lower bound on control
uu 	    = [30*pi/180; Inf];             % Upper bound on control

xl      = -Inf*ones(mx,1);              % Lower bound on states (no bound)
xu      = Inf*ones(mx,1);               % Upper bound on states (no bound)
xl(3)   = ul(1);                        % Lower bound on state x3
xu(3)   = uu(1);                        % Upper bound on state x3

% Generate constraints on measurements and inputs
[vlb,vub]       = gen_constraints(N,M,xl,xu,ul,uu); % Generate constraints
vlb(N*mx+M*mu)  = 0;                                % We want the last input to be zero
vub(N*mx+M*mu)  = 0;                                % We want the last input to be zero

% Generate the matrix Q and the vector c (objective function weights in the QP problem) 
Q1 = zeros(mx,mx);
Q1(1,1) = 1;                            % Weight on state x1
Q1(2,2) = 0;                            % Weight on state x2
Q1(3,3) = 0;                            % Weight on state x3
Q1(4,4) = 0;                            % Weight on state x4
Q1(5,5) = 0;
Q1(6,6) = 0;

P1 = [1 0;
      0 1];                % Weight on input
Q = 2*gen_q(Q1,P1,N,M);    % Generate Q
c = zeros(size(Q,2),1);    % Generate c, this is the linear constant term in the QP

%% Generate system matrixes for linear model

Aeq = gen_aeq(A1,B1,N,mx,mu);   % Generate A
beq = zeros(size(Aeq, 1),1);    % Generate b
beq(1:6) = A1*x0;               % Set initial state

%% Find K (optimal gain) matrix

Q_lqr = diag([20, 5, 1, 1, 20, 5]);
R_lqr = diag([0.5, 0.5]) ;

K = dlqr(A1, B1, Q_lqr, R_lqr, []);


%% Solve QP problem for linear model with nonlinear constraints using SQP

tic
options = optimoptions(@fmincon, 'Algorithm','sqp');
f = @(z) 1/2*z'*Q*z;
[z,lambda] = fmincon(f,z0,[],[],Aeq, beq, vlb, vub,@nonlcon, options); % Solve QP problem 
t1=toc;

% Calculate objective value
phi1 = 0.0;
PhiOut = zeros(N*mx+M*mu,1);
for i=1:N*mx+M*mu
  phi1=phi1+Q(i,i)*z(i)*z(i);
  
  PhiOut(i) = phi1;
end

%% Extract control inputs and states

u1  = [z(N*mx+1:2:N*mx+M*mu);z(N*mx+M*mu-1)]; % Control input from solution
u2  = [z(N*mx+2:2:N*mx+M*mu);z(N*mx+M*mu)]; % Control input from solution


x1 = [x0(1);z(1:mx:N*mx)];              % State x1 from solution
x2 = [x0(2);z(2:mx:N*mx)];              % State x2 from solution
x3 = [x0(3);z(3:mx:N*mx)];              % State x3 from solution
x4 = [x0(4);z(4:mx:N*mx)];              % State x4 from solution
x5 = [x0(5);z(5:mx:N*mx)];              % State x4 from solution
x6 = [x0(6);z(6:mx:N*mx)];              % State x4 from solution


% Add zero padding
num_variables = 5/delta_t;
zero_padding = zeros(num_variables,1);
unit_padding  = ones(num_variables,1);

u1   = [zero_padding; u1; zero_padding];
u2   = [zero_padding; u2; zero_padding];
x1  = [pi*unit_padding; x1; zero_padding];
x2  = [zero_padding; x2; zero_padding];
x3  = [zero_padding; x3; zero_padding];
x4  = [zero_padding; x4; zero_padding];
x5  = [zero_padding; x5; zero_padding];
x6  = [zero_padding; x6; zero_padding];

%% Create timeseries to be used in Simulink model

t = 0:delta_t:delta_t*(length(u1)-1);
t2 =0:delta_t:delta_t*(length(u2)-1); 
x = [x1, x2, x3, x4, x5, x6];
u_opt1 = timeseries(u1, t);
u_opt2 = timeseries(u2, t2);
t_x = 0:delta_t:delta_t*(length(x1)-1);
x_opt = timeseries(x, t_x);

%% Calculate the nonlinear constraints

function [c,ceq] = nonlcon(x)
    N = 40;
    mx = 6;
    alpha = 0.2;
    beta = 20;
    lambda_t = 2*pi/3;
    c = alpha*exp(-beta*(x(1:mx:N*mx)-lambda_t).^2)-x(5:mx:N*mx);
    ceq = [];
end
    
