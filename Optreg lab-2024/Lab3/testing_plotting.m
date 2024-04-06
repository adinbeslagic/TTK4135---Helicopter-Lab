% load('data/p_1_2.mat')
% load('data/p_0.12.mat')

%% Plot figures
figure(1),
subplot(511)
plot(var(1,:), var(2,:),var(1,:),var2(2,:), "LineWidth",3)
legend('Travel [rad]case 1', 'Travel [rad]case 2'),grid
xlabel('Time [s]');
ylabel('Value');
subplot(512)
plot(var(1,:), var(3,:),var(1,:),var2(3,:) ,"LineWidth",3)
legend('Travel rate [rad/s]case 1', 'Travel rate [rad/s]case 2') ,grid
xlabel('Time [s]');
ylabel('Value');
subplot(513)
plot(var(1,:), var(4,:),var(1,:),var2(4,:), "LineWidth",3)
legend('Pitch [rad]case 1','Pitch [rad]case 2'), grid
xlabel('Time [s]');
ylabel('Value');
subplot(514)
plot(var(1,:), var(5,:),var(1,:),var2(5,:), "LineWidth",3)
legend('Pitch rate[rad/s]case 1', 'Pitch rate[rad/s] case2'),grid
xlabel('Time [s]');
ylabel('Value');
subplot(515)
plot(var(1,:), var(6,:),var(1,:),var2(6,:), "LineWidth",3)
legend('u [rad]case 1', 'u [rad]case 2'),grid
xlabel('Time [s]');
ylabel('Value');
title(subplot(511),'Case 1: Q =1, P =0.12')
