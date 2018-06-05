% clc; clear; close all;
load gpVariables
load alphaVariable


%%
for j=1:num_test_samples
    fprintf('Query point %d/%d\n', j, num_test_samples);
    xq = horzcat(qTest(j,:), dqTest(j,:), ddqTest(j,:));
    for i=1:num_training_samples
        k(i) = calc_Kernel(hyp2, trainTrajectory(i,:), xq);
    end
    kernelTau(j,:) = testPhiBeta(j,:) + k*alpha;
    kValues(j,:)   = k*alpha;
end

%% Plotting torques - predicted torque, PhiBeta test torque, actual test torque
rows = 3;   cols = 3;
for i = 1:7
    subplot(rows, cols, i);
        plot(time_test, kernelTau(:,i),   'r', ...
            time_test,  testPhiBeta(:,i), 'b', ...
            time_test,  testTorque(:,i),  'k');
        leg1 = legend('$\tau_{pred}$','$\tau_{rbd}$', '$\tau_{real}$');
        ylabel('Torque','Interpreter','latex');
    grid on;
    
%     plot(time_test, muTest(:,i), 'r', ...
%         time_test, kValues(:,i), 'b');
%     grid on;
%     leg1 = legend('$\mu_{test}$','$k*\alpha_{val}$');
%     ylabel('Prediction Values','Interpreter','latex');
    
    
    xlabel('Time (seconds)','Interpreter','latex');
    %     leg1 = legend('$\tau_{kernel}$','$\tau_{gpml}$');
    set(leg1,'Interpreter','latex');
    title(['Joint ', num2str(i)],'Interpreter','latex');
end

