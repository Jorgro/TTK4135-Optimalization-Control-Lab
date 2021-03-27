%% Load data

states_1 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q1/States41.mat').ans;
pitch_control_1 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q1/Pitch_control41.mat').ans;
elevation_control_1 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q1/Elevation_control41.mat').ans;

states_2 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q2/States42.mat').ans;
pitch_control_2 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q2/Pitch_control42.mat').ans;
elevation_control_2 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q2/Elevation_control42.mat').ans;

u_opt1_1 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q1/u_opt_1_1.mat').u_opt1;
u_opt2_1 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q1/u_opt_2_1.mat').u_opt2;

u_opt1_2 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q2/u_opt_1_2.mat').u_opt1;
u_opt2_2 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q2/u_opt_2_2.mat').u_opt2;

x1_1 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q1/x1_1.mat').x1;
x2_1 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q1/x2_1.mat').x2;
x3_1 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q1/x3_1.mat').x3;
x4_1 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q1/x4_1.mat').x4;
x5_1 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q1/x5_1.mat').x5;
x6_1 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q1/x6_1.mat').x6;

x1_2 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q2/x1_2.mat').x1;
x2_2 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q2/x2_2.mat').x2;
x3_2 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q2/x3_2.mat').x3;
x4_2 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q2/x4_2.mat').x4;
x5_2 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q2/x5_2.mat').x5;
x6_2 = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/dataday4Q2/x6_2.mat').x6;

t = load('/Users/jorgenr/Lab/LAB/LAB/Day 4/t.mat').t;

time_states_1 = states_1(1,:);
travel_1 = states_1(2,:);
travel_rate_1 = states_1(3,:);
pitch_1 = states_1(4,:);
pitch_rate_1 = states_1(5,:);
elevation_1 = states_1(6,:);
elevation_rate_1 = states_1(7,:);

time_states_2 = states_2(1,:);
travel_2 = states_2(2,:);
travel_rate_2 = states_2(3,:);
pitch_2 = states_2(4,:);
pitch_rate_2 = states_2(5,:);
elevation_2 = states_2(6,:);
elevation_rate_2 = states_2(7,:);

%% Plot control
figure(1)
% Plot optimal (open-loop) control pitch
stairs(u_opt1_1.Time, u_opt1_1.Data)
title('Optimal pitch control for different weights on input', 'interpreter', 'latex')
hold on
plot(pitch_control_1(1,:), pitch_control_1(2,:))

stairs(u_opt1_2.Time, u_opt1_2.Data)
plot(pitch_control_2(1,:), pitch_control_2(2,:))
hold off
grid
ylim([-1 1])
xlim([0 20])
ylabel('Pitch reference [rad]')
xlabel('Time [s]')
legend('$p_c^*, p_1 = p_2 = 1$','$p_c, p_1 = p_2 = 1$','$p_c^*, p_1 = p_2 = 2$','$p_c, p_1 = p_2 = 2$', 'interpreter', 'latex')

% Plot optimal (open-loop) control elevation
figure(2)
stairs(u_opt2_1.Time, u_opt2_1.Data)
title('Optimal elevation control for different weights on input', 'interpreter', 'latex')
hold on
plot(elevation_control_1(1,:), elevation_control_1(2,:))

stairs(u_opt2_2.Time, u_opt2_2.Data)
plot(elevation_control_2(1,:), elevation_control_2(2,:))
hold off
grid
ylim([-1 1])
xlim([0 20])
ylabel('Elevation reference [rad]')
xlabel('Time [s]')
legend('$e_c^*, p_1 = p_2 = 1$','$e_c, p_1 = p_2 = 1$','$e_c^*, p_1 = p_2 = 2$','$e_c, p_1 = p_2 = 2$', 'interpreter', 'latex')

%% Plot travel and travel rate model vs. reality
figure(3)

% Travel
plot(t,x1_1,'--',time_states_1,travel_1)
title('Travel for different input weights', 'interpreter', 'latex')
grid
hold on
plot(t,x1_2,'--',time_states_2,travel_2)
xlim([0 20])
legend('$\lambda^*, p_1 = p_2 = 1$','$\lambda, p_1 = p_2 = 1$','$\lambda^*, p_1 = p_2 = 2$','$\lambda, p_1 = p_2 = 2$','interpreter', 'latex')
ylabel('Travel [rad]', 'interpreter', 'latex');
xlabel('Time [s]')

% Travel rate
figure(4)
plot(t,x2_1,'--',time_states_1,travel_rate_1)
title('Travel rate for different input weights', 'interpreter', 'latex')
grid
hold on
plot(t,x2_2,'--',time_states_2,travel_rate_2)
xlim([0 20])
legend('$r^*, p_1 = p_2 = 1$','$r, p_1 = p_2 = 1$', '$r^*, p_1 = p_2 = 2$','$r, p_1 = p_2 = 2$', 'interpreter', 'latex')
ylabel('Travel rate [rad/s]', 'interpreter', 'latex');
xlabel('Time [s]')

%% Plot pitch and pitch rate model vs. reality
figure(5)

% Pitch
plot(t,x3_1,'--',time_states_1,pitch_1)
title('Pitch for different input weights', 'interpreter', 'latex')
grid
hold on
plot(t,x3_2,'--',time_states_2,pitch_2)
legend('$p^*, p_1 = p_2 = 1$','$p, p_1 = p_2 = 1$','$p^*, p_1 = p_2 = 2$','$p, p_1 = p_2 = 2$','interpreter', 'latex')
ylabel('Pitch [rad]', 'interpreter', 'latex');
xlabel('Time [s]')

% Pitch rate
figure(6)
plot(t,x4_1,'--',time_states_1,pitch_rate_1)
title('Pitch rate for different input weights', 'interpreter', 'latex')
grid
hold on
plot(t,x4_2,'--',time_states_2,pitch_rate_2)
xlim([0 20])
legend('$\dot{p}^*, p_1 = p_2 = 1$','$\dot{p}, p_1 = p_2 = 1$', '$\dot{p}^*, p_1 = p_2 = 2$','$\dot{p}, p_1 = p_2 = 2$', 'interpreter', 'latex')
ylabel('Pitch rate [rad/s]', 'interpreter', 'latex');
xlabel('Time [s]')

%% Plot elevation and elevation rate model vs. reality
figure(7)

% Elevation
plot(t,x5_1,'--',time_states_1,elevation_1)
title('Elevation for different input weights', 'interpreter', 'latex')
grid
hold on
plot(t,x5_2,'--',time_states_2,elevation_2)
xlim([0 20])
legend('$e^*, p_1 = p_2 = 1$','$e, p_1 = p_2 = 1$','$e^*, p_1 = p_2 = 2$','$e, p_1 = p_2 = 2$','interpreter', 'latex')
ylabel('Elevation [rad]', 'interpreter', 'latex');
xlabel('Time [s]')

% Elevation rate
figure(8)
plot(t,x6_1,'--',time_states_1,elevation_rate_1)
title('Elevation rate for different input weights', 'interpreter', 'latex')
grid
hold on
plot(t,x6_2,'--',time_states_2,elevation_rate_2)
xlim([0 20])
legend('$\dot{e}^*, p_1 = p_2 = 1$','$\dot{e}, p_1 = p_2 = 1$', '$\dot{e}^*, p_1 = p_2 = 2$','$\dot{e}, p_1 = p_2 = 2$', 'interpreter', 'latex')
ylabel('Elevation rate [rad/s]', 'interpreter', 'latex');
xlabel('Time [s]')