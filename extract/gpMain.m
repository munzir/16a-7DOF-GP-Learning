clc; close all; clear;

fprintf('Adding GPML 4.1 path ... ')
gpmlPath = '../gpml_4.1/v4.1-2017-10-19/';
addpath(gpmlPath);
addpath(strcat(gpmlPath,'cov'));
addpath(strcat(gpmlPath,'doc'));
addpath(strcat(gpmlPath,'inf'));
addpath(strcat(gpmlPath,'lik'));
addpath(strcat(gpmlPath,'mean'));
addpath(strcat(gpmlPath,'prior'));
addpath(strcat(gpmlPath,'util'));
fprintf('Done!\n');

train_dir = '../all_data/dataSet2/trainingData/';
test_dir = '../all_data/dataSet2/testingData/';

fprintf('Loading training set ..... ');
[qTrain, dqTrain, ddqTrain, trainTorque, time_train, M_Train, CgTrain] = ...
    get_data(train_dir);
fprintf('Done!\n');

fprintf('Loading testing set ...... ');
[qTest, dqTest, ddqTest, testTorque, time_test, M_Test, CgTest] = ...
    get_data(test_dir);
fprintf('Done!\n');

disp('Finished fetching Training & Testing datasets');
fprintf('\n');

%%
num_training_samples = roundn(length(qTrain),0);
fprintf('Loading %d samples from Training set ... ', num_training_samples);
for i = 1:num_training_samples
    q_sample    = qTrain(i,:);
    dq_sample   = dqTrain(i,:);
    ddq_sample  = ddqTrain(i,:);
    b = horzcat(q_sample, dq_sample, ddq_sample);
    trainTrajectory(i,:) = b;
    
    M = M_Train((i-1)*7+1:(i-1)*7+7,:);
    trainPhiBeta(i,:) = (M*ddq_sample')'+CgTrain(i,:);
end
fprintf('Done!\n');
fprintf('RBD Mean for Training set completed. Size: ');
disp(size(trainPhiBeta));

num_test_samples = length(qTest);
fprintf('Loading %d samples from Testing set ..... ', num_test_samples);
for i = 1:num_test_samples
    q_sample    = qTest(i,:);
    dq_sample   = dqTest(i,:);
    ddq_sample  = ddqTest(i,:);
    
    b = horzcat(q_sample, dq_sample, ddq_sample);
    testTrajectory(i,:)=  b;
    
    M = M_Test((i-1)*7+1:(i-1)*7+7,:);
    
    testPhiBeta(i,:) = (M*ddq_sample')'+CgTest(i,:);
end
fprintf('Done!\n');
fprintf('RBD Mean for Testing set completed. Size:      ');
disp(size(testPhiBeta));



%%
trainTauDiff = minus(trainTorque, trainPhiBeta);
covValue = [1 1];
likValue = 1;
fprintf('Performing RBD Mean computation and finding hyperparameters ... \n');
[hyp2, meanfunc, covfunc, likfunc] = rbd_mean(trainTrajectory, trainTauDiff, covValue, likValue);
fprintf('Done!\n\n');

%%
fprintf('Hyperparameters: \n');
disp(hyp2)


fprintf('Predicting torque & its mean prediction for training set ... \n');
[trainTauPred, muTrain] = ...
    rbd_mean_predict(hyp2, meanfunc, covfunc, likfunc, trainTrajectory, ...
    trainTauDiff, trainTrajectory, trainPhiBeta);
fprintf('Done!\n');

fprintf('Predicting torque & its mean prediction for testing set ... \n');
[testTauPred, muTest] = ...
    rbd_mean_predict(hyp2, meanfunc, covfunc, likfunc, trainTrajectory, ...
    trainTauDiff, testTrajectory, testPhiBeta);
fprintf('Done!\n\n');


save('gpVariables.mat')

