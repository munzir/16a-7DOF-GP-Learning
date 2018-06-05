function alpha = getAlpha(hyp, trainingTraj, torqueDiff)
    sigma_n = hyp.lik;
    num_samples = size(trainingTraj,1);
    tic
    fprintf('Computing covariance matrix K ... \n');
    for i = 1:num_samples
        fprintf('Query point %d/%d\n', i, num_samples);
        for j=1:num_samples
            K(i,j) = calc_Kernel(hyp, trainingTraj(i,:), trainingTraj(j,:));
        end
%         predTauBar(j,:) = testPhiBetaMean(j,:) + k*alpha;
    end
    fprintf('Done! \n');
    toc
    fprintf('Inverting the matrix of size %d x %d ... \n', size(K,1), size(K,2));
    Kinv = pinv(K + sigma_n^2*eye(size(K)) );
    fprintf('Inverted!\n');
    
    fprintf('On the last step ... \n');
    alpha = Kinv*torqueDiff; 
end