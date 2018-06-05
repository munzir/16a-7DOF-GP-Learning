clc; clear; close all;

flag = 1;
if flag==0
    load('gpVariables.mat');
else
    load('gpVariables_nonddq.mat');
end

%% Evaluate normalized-MSE on predicted torque and torque from testing set
nMSE = compute_nMSE(testTauPred, testTorque);
fprintf('nMSE between predicted torque and actual torque:\n');
disp(nMSE);

nMSEreal = compute_nMSE(testPhiBeta, testTorque);
fprintf('nMSE between rbd torque and actual torque:\n');
disp(nMSEreal);

fprintf('Order of improvement in prediction:\n');
disp((nMSEreal./nMSE))

%% Plotting torques - predicted torque, PhiBeta test torque, actual test torque
rows = 3;   cols = 3;
for i = 1:7
    subplot(rows, cols, i);
    plot(time_test, testTauPred(:,i), 'b', ...
        time_test, testPhiBeta(:,i), 'g', ...
        time_test, testTorque(:,i),'r');
    grid on;
    xlabel('Time (seconds)','Interpreter','latex');
    ylabel('Torque','Interpreter','latex');
    leg1 = legend('$\tau_{pred}$','$\tau_{rbd}$', '$\tau_{real}$');
    set(leg1,'Interpreter','latex');
    title(['Joint ', num2str(i)]);
end

