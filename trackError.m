clc; clear;
dof   = 7;

q = tdfread('../all_data/dataSet2/testingData/dataQ.txt', '\t');
q = q.dataQ;

qref = tdfread('../all_data/dataSet2/testingData/dataQref.txt', '\t');
qref = qref.dataQref;

time = tdfread('../all_data/dataSet2/testingData/dataTime.txt');
time = time.dataTime;

%%

figure
rows = 3; cols = 3;
for i = 1:dof
    subplot(rows, cols, i);
    plot(time, q(:,i), 'b', time, qref(:,i) , 'r'); grid on;
    leg1 = legend('$q(t)$','$q_{ref}(t)$');
    set(leg1,'Interpreter','latex');
    xlabel(['Joint ' num2str(i)])
    ylabel('State Trajectories');
end
title('Tracking Error');