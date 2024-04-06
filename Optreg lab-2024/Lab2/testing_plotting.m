load('data/case1_0_2.mat')
load('data/case1_1_2.mat')
load('data/case1_12.mat')

%% Plot figures
figure(1),
title(subplot(511),'R = 0.R = 12: P =R = 0.R = 12, R = 1.2 & R = 12')
subplot(511)
plot(var1(1,:), var1(6,:),var1(1,:),var2(6,:),var1(1,:),var3(6,:), "LineWidth",3)
legend('R = 0.12', 'R = 1.2', 'R = 12', 'Fontsize', 15),grid
xlabel('Time [s]', 'FontSize',15);
ylabel('Input', 'FontSize',15);
subplot(512)
plot(var1(1,:), var1(2,:),var1(1,:),var2(2,:),var1(1,:),var3(2,:), "LineWidth",3)
legend('R = 0.12', 'R = 1.2', 'R = 12', 'Fontsize', 15),grid
xlabel('Time [s]', 'FontSize',15);
ylabel('Travel [rad]', 'Fontsize', 15);
subplot(513)
plot(var1(1,:), var1(3,:),var1(1,:),var2(3,:) ,var1(1,:),var3(3,:) ,"LineWidth",3)
legend('R = 0.12', 'R = 1.2', 'R = 12', 'Fontsize', 15) ,grid
xlabel('Time [s]', 'FontSize',15);
ylabel('Travel Rate [rad/s]', 'Fontsize', 15);
subplot(514)
plot(var1(1,:), var1(4,:),var1(1,:),var2(4,:),var1(1,:),var3(4,:), "LineWidth",3)
legend('R = 0.12','R = 1.2','R = 12', 'Fontsize', 15), grid
xlabel('Time [s]', 'FontSize',15);
ylabel('Pitch [rad]', 'Fontsize', 15);
subplot(515)
plot(var1(1,:), var1(5,:),var1(1,:),var2(5,:),var1(1,:),var3(5,:), "LineWidth",3)
legend('R = 0.12', 'R = 1.2', 'R = 12', 'Fontsize', 15),grid
xlabel('Time [s]', 'FontSize',15);
ylabel('Pitch rate [rad/s]', 'Fontsize', 15);

