%% Load data

pitch_1 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q0.1/Pitch_q_01.mat').ans;
pitch_2 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q1/Pitch_q_1.mat').ans;
pitch_3 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q10/Pitch_q_10.mat').ans;

% R2D
pitch_1(3,:) = pi*pitch_1(3,:)/180;
pitch_2(3,:) = pi*pitch_2(3,:)/180;
pitch_3(3,:) = pi*pitch_3(3,:)/180;

travel_1 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q0.1/Travel_q_01.mat').ans;
travel_2 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q1/Travel_q_1.mat').ans;
travel_3 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q10/Travel_q_10.mat').ans;

% R2D
travel_1(2,:) = pi-pi*travel_1(2,:)/180;
travel_2(2,:) = pi-pi*travel_2(2,:)/180;
travel_3(2,:) = pi-pi*travel_3(2,:)/180;

pitch_rate_1 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q0.1/Pitch_rate_q_01.mat').ans;
pitch_rate_2 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q1/Pitch_rate_q_1.mat').ans;
pitch_rate_3 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q10/Pitch_rate_q_10.mat').ans;

% R2D
pitch_rate_1(2,:) = pi*pitch_rate_1(2,:)/180;
pitch_rate_2(2,:) = pi*pitch_rate_2(2,:)/180;
pitch_rate_3(2,:) = pi*pitch_rate_3(2,:)/180;

travel_rate_1 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q0.1/Travel_rate_q_01.mat').ans;
travel_rate_2 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q1/Travel_rate_q_1.mat').ans;
travel_rate_3 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q10/Travel_rate_q_10.mat').ans;

% R2D
travel_rate_1(2,:) = pi*travel_rate_1(2,:)/180;
travel_rate_2(2,:) = pi*travel_rate_2(2,:)/180;
travel_rate_3(2,:) = pi*travel_rate_3(2,:)/180;

u_opt_1 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q0.1/u_opt_1.mat').u;
u_opt_2 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q1/u_opt_2.mat').u;
u_opt_3 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q10/u_opt_3.mat').u;

x1_1 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q0.1/x1_1.mat').x1;
x2_1 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q0.1/x2_1.mat').x2;
x3_1 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q0.1/x3_1.mat').x3;
x4_1 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q0.1/x4_1.mat').x4;

x1_2 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q1/x1_2.mat').x1;
x2_2 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q1/x2_2.mat').x2;
x3_2 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q1/x3_2.mat').x3;
x4_2 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q1/x4_2.mat').x4;

x1_3 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q10/x1_3.mat').x1;
x2_3 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q10/x2_3.mat').x2;
x3_3 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q10/x3_3.mat').x3;
x4_3 = load('/Users/jorgenr/Lab/LAB/LAB/day2/day2data/day2q10/x4_3.mat').x4;


t = load('/Users/jorgenr/Lab/LAB/LAB/day2/t2.mat').t;


%% Plot control
figure(1)
% Plot optimal (open-loop) control pitch
stairs(t, u_opt_1)
title('Optimal pitch control for different $q$', 'interpreter', 'latex')
hold on

stairs(t, u_opt_2)
stairs(t, u_opt_3)
hold off
grid
ylim([-1 1])
xlim([0 20])
ylabel('Pitch reference [rad]')
xlabel('Time [s]')
legend('$p_c^*$, $q = 0.1$','$p_c^*$, $q = 1$','$p_c^*$, $q = 10$', 'interpreter', 'latex')

%% Plot travel and travel rate model vs. reality
figure(2)

% Travel
plot(t,x1_1,'--',travel_1(1,:),travel_1(2,:))
title('Travel for different $q$', 'interpreter', 'latex')
grid
hold on
plot(t,x1_2,'--',travel_2(1,:),travel_2(2,:))
plot(t,x1_3,'--',travel_3(1,:),travel_3(2,:))
xlim([0 20])
legend('$\lambda^*$, $q=0.1$','$\lambda$, $q=0.1$','$\lambda^*$, $q=1$','$\lambda$, $q = 1$', '$\lambda^*$, $q=10$','$\lambda$, $q = 10$', 'interpreter', 'latex')
ylabel('Travel [rad]', 'interpreter', 'latex');
xlabel('Time [s]')

% Travel rate
figure(3)
plot(t,x2_1,'--',travel_rate_1(1,:),travel_rate_1(2,:))
title('Travel rate for different $q$', 'interpreter', 'latex')

grid
hold on
plot(t,x2_2,'--',travel_rate_2(1,:),travel_rate_2(2,:))
plot(t,x2_3,'--',travel_rate_3(1,:),travel_rate_3(2,:))
hold off
xlim([0 20])
legend('$r^*$, $Q=[80,5,20,1], R=0.5$','$r$, $Q=[80,5,20,1], R=0.5$','$r^*$, $Q=[1,1,1,1], R=1$','$r$, $Q=[1,1,1,1], R=1$', 'interpreter', 'latex')
ylabel('Travel rate [rad/s]', 'interpreter', 'latex');
xlabel('Time [s]')

%% Plot pitch and pitch rate model vs. reality
figure(4)

% Pitch
plot(t,x3_1,'--',pitch_1(1,:),pitch_1(3,:))
title('Pitch for different $q$', 'interpreter', 'latex')

grid
hold on
plot(t,x3_2,'--',pitch_2(1,:),pitch_2(3,:))
plot(t,x3_3,'--',pitch_3(1,:),pitch_3(3,:))
xlim([0 20])
legend('$p^*$, $Q=[80,5,20,1], R=0.5$','$p$, $Q=[80,5,20,1], R=0.5$','$p^*$, $Q=[1,1,1,1], R=1$','$p$, $Q=[1,1,1,1], R=1$', 'interpreter', 'latex')
ylabel('Pitch [rad]', 'interpreter', 'latex');
xlabel('Time [s]')

% Pitch rate
figure(5)
plot(t,x4_1,'--',pitch_rate_1(1,:),pitch_rate_1(2,:))
plot(t,x4_2,'--',pitch_rate_2(1,:),pitch_rate_2(2,:))
plot(t,x4_3,'--',pitch_rate_3(1,:),pitch_rate_3(2,:))
title('Pitch rate for different $q$', 'interpreter', 'latex')
grid
hold on
xlim([0 20])
legend('$\dot{p}^*$, $Q=[80,5,20,1], R=0.5$','$\dot{p}$, $Q=[80,5,20,1], R=0.5$','$\dot{p}^*$, $Q=[1,1,1,1], R=1$','$\dot{p}$, $Q=[1,1,1,1], R=1$', 'interpreter', 'latex')
ylabel('Pitch rate [rad/s]', 'interpreter', 'latex');
xlabel('Time [s]')



