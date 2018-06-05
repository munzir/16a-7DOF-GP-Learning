clc; clear; close all;
flag = 1;
if flag==0
    load('gpVariables.mat');
else
    load('gpVariables_nonddq.mat');
end


%% Finding prediction vector offline alpha_k = inv(K + sigma)*(y - M(X))
alpha = getAlpha(hyp2, trainTrajectory, trainTauDiff);
fprintf('Done\n');

fprintf('Alpha dimensions: ');
disp(size(alpha));

if flag==0
    save('alphaVariable', 'alpha');
else
    save('alphaVariable_nonddq', 'alpha');
end


%% Storing alpha and torque data from training set


if flag==0
    fprintf('Writing alpha with ddq data to ./forPredictionData folder ... ');
    load alphaVariable
    write_to_text_file(alpha, 'forPredictionData/alpha2174.txt');
else
    fprintf('Writing alpha withOUT ddq data to ./forPredictionData folder ... ');
    load alphaVariable_nonddq
    write_to_text_file(alpha, 'forPredictionData/alpha2174_nonddq.txt');
end

fprintf('Done\n');


%% Plotting alpha values for each joint
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
