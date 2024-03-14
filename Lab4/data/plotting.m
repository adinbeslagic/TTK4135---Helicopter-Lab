
time = array1(1, 1:15000);
travel1= array1(2, 1:15000)
travel2 = array2(2, 1:15000)
pitch1= array1(3, 1:15000);
pitch2= array2(3, 1:15000);

figure();
hold on;
plot(time, travel1)
plot(time, travel2)
plot(time, pitch1)
plot(time,pitch2)
grid on;

legend('Travel1', 'Travel2', 'Pitch1', 'Pitch2')