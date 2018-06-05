function [hyp2, meanfunc, covfunc, likfunc] = ...
            rbd_mean(training_trajectories, training_output, covValues, likValue)
meanfunc = [];              % No mean
covfunc = @covSEiso;        % Squared Exponental covariance function
likfunc = @likGauss;        % Gaussian likelihood

%[7.6941 12.5268] , 'lik', -2.5548);
hyp = struct('mean',[], 'cov', covValues , 'lik', likValue);
hyp2 = minimize(hyp, @gp, -50, @infGaussLik, meanfunc, covfunc, likfunc, ...
    training_trajectories, training_output);
disp('Calculated hyperparameters by optimizing marginal likelihood');

end