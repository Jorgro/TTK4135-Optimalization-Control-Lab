%% Load data

states_1 = load('/Users/jorgenr/Lab/LAB/LAB/day3/dataday3Optimal/States31.mat').ans;
pitch_control_1 = load('/Users/jorgenr/Lab/LAB/LAB/day3/dataday3Optimal/Pitch_control31.mat').ans;

states_2 = load('/Users/jorgenr/Lab/LAB/LAB/day3/dataday3Test/States32.mat').ans;
pitch_control_2 = load('/Users/jorgenr/Lab/LAB/LAB/day3/dataday3Test/Pitch_control32.mat').ans;

u_opt_1 = load('/Users/jorgenr/Lab/LAB/LAB/day3/dataday3Optimal/u_opt_optimal.mat').u_opt;

u_opt_2 = load('/Users/jorgenr/Lab/LAB/LAB/day3/dataday3Test/u_opt_test.mat').u_opt;

x1_1 = load('/Users/jorgenr/Lab/LAB/LAB/day3/dataday3Optimal/x_1_optimal.mat').x1;
x2_1 = load('/Users/jorgenr/Lab/LAB/LAB/day3/dataday3Optimal/x_2_optimal.mat').x2;
x3_1 = load('/Users/jorgenr/Lab/LAB/LAB/day3/dataday3Optimal/x_3_optimal.mat').x3;
x4_1 = load('/Users/jorgenr/Lab/LAB/LAB/day3/dataday3Optimal/x_4_optimal.mat').x4;

x1_2 = load('/Users/jorgenr/Lab/LAB/LAB/day3/dataday3Test/x_1_test.mat').x1;
x2_2 = load('/Users/jorgenr/Lab/LAB/LAB/day3/dataday3Test/x_2_test.mat').x2;
x3_2 = load('/Users/jorgenr/Lab/LAB/LAB/day3/dataday3Test/x_3_test.mat').x3;
x4_2 = load('/Users/jorgenr/Lab/LAB/LAB/day3/dataday3Test/x_4_test.mat').x4;

t = load('/Users/jorgenr/Lab/LAB/LAB/day3/t3.mat').t;

time_states_1 = states_1(1,:);

travel_1 = states_1(2,:);
travel_rate_1 = states_1(3,:);
pitch_1 = states_1(4,:);
pitch_rate_1 = states_1(5,:);

time_states_2 = states_2(1,:);
travel_2 = states_2(2,:);
travel_rate_2 = states_2(3,:);
pitch_2 = states_2(4,:);
pitch_rate_2 = states_2(5,:);

%% Plot control
figure(1)
% Plot optimal (open-loop) control pitch
stairs(u_opt_1.Time, u_opt_1.Data)
title('Optimal pitch control for different $Q$ and $R$', 'interpreter', 'latex')
hold on
plot(pitch_control_1(1,:), pitch_control_1(2,:))

stairs(u_opt_2.Time, u_opt_2.Data)
plot(pitch_control_2(1,:), pitch_control_2(2,:))
hold off
grid
ylim([-1 1])
xlim([0 20])
ylabel('Pitch reference [rad]')
xlabel('Time [s]')
legend('$p_c^*$, $Q=[80,5,20,1], R=0.5$','$p_c$, $Q=[80,5,20,1], R=0.5$','$p_c^*$, $Q=[1,1,1,1], R=1$','$p_c$, $Q=[1,1,1,1], R=1$', 'interpreter', 'latex')

%% Plot travel and travel rate model vs. reality
figure(2)

% Travel
plot(t,x1_1,'--',time_states_1,travel_1)
title('Travel for different $Q$ and $R$', 'interpreter', 'latex')
grid
hold on
plot(t,x1_2,'--',time_states_2,travel_2)
xlim([0 20])
legend('$\lambda^*$, $Q=[80,5,20,1], R=0.5$','$\lambda$, $Q=[80,5,20,1], R=0.5$','$\lambda^*$, $Q=[1,1,1,1], R=1$','$\lambda$, $Q=[1,1,1,1], R=1$', 'interpreter', 'latex')
ylabel('Travel [rad]', 'interpreter', 'latex');
xlabel('Time [s]')

% Travel rate
figure(3)
plot(t,x2_1,'--',time_states_1,travel_rate_1)
title('Travel rate for different $Q$ and $R$', 'interpreter', 'latex')

grid
hold on
plot(t,x2_2,'--',time_states_2,travel_rate_2)
xlim([0 20])
legend('$r^*$, $Q=[80,5,20,1], R=0.5$','$r$, $Q=[80,5,20,1], R=0.5$','$r^*$, $Q=[1,1,1,1], R=1$','$r$, $Q=[1,1,1,1], R=1$', 'interpreter', 'latex')
ylabel('Travel rate [rad/s]', 'interpreter', 'latex');
xlabel('Time [s]')

%% Plot pitch and pitch rate model vs. reality
figure(4)

% Pitch
plot(t,x3_1,'--',time_states_1,pitch_1)
title('Pitch for different $Q$ and $R$', 'interpreter', 'latex')

grid
hold on
plot(t,x3_2,'--',time_states_2,pitch_2)
xlim([0 20])
legend('$p^*$, $Q=[80,5,20,1], R=0.5$','$p$, $Q=[80,5,20,1], R=0.5$','$p^*$, $Q=[1,1,1,1], R=1$','$p$, $Q=[1,1,1,1], R=1$', 'interpreter', 'latex')
ylabel('Pitch [rad]', 'interpreter', 'latex');
xlabel('Time [s]')

% Pitch rate
figure(5)
plot(t,x4_1,'--',time_states_1,pitch_rate_1)
title('Pitch rate for different $Q$ and $R$', 'interpreter', 'latex')

grid
hold on
plot(t,x4_2,'--',time_states_2,pitch_rate_2)
xlim([0 20])
legend('$\dot{p}^*$, $Q=[80,5,20,1], R=0.5$','$\dot{p}$, $Q=[80,5,20,1], R=0.5$','$\dot{p}^*$, $Q=[1,1,1,1], R=1$','$\dot{p}$, $Q=[1,1,1,1], R=1$', 'interpreter', 'latex')
ylabel('Pitch rate [rad/s]', 'interpreter', 'latex');
xlabel('Time [s]')