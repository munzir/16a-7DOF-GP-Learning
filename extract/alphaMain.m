clc; clear; close all;

%% Finding prediction vector offline alpha_k = inv(K + sigma)*(y - M(X))
load('gpVariables.mat');
alpha = getAlpha(hyp2, trainTrajectory, trainTauDiff);
fprintf('Done\n');

fprintf('Alpha dimensions: ');
disp(size(alpha));

save('alphaVariable', 'alpha');

%% Storing alpha and torque data from training set
load alphaVariable
fprintf('Writing prediction data to ./forPredictionData folder ... ');
write_to_text_file(alpha, 'files/alpha2174.txt');
% write_to_text_file(torqueTrain, 'forPredictionData/training_torque.txt');
fprintf('Done\n');

% Plotting alpha values for each joint
rows = 3;   cols = 3;
for i = 1:7
    subplot(rows, cols, i);
    plot(time_train, alpha(:,i), 'r');
    grid on;
    xlabel('Time (seconds)','Interpreter','latex');
    ylabel('Alpha','Interpreter','latex');
    leg1 = legend('$\alpha_{kernel}$');
%     leg1 = legend('$\tau_{kernel}$','$\tau_{gpml}$');
    set(leg1,'Interpreter','latex');
    title(['Joint ', num2str(i)],'Interpreter','latex');
end
    