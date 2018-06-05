function [q, dq, ddq, torque, time, M, Cg] = get_data(dir)
    time    = tdfread(strcat(dir,'dataTime.txt'));
    time    = time.dataTime;

    M       = tdfread(strcat(dir,'dataM.txt'));
    M       = M.dataM;

    Cg      = tdfread(strcat(dir,'dataCg.txt'));
    Cg      = Cg.dataCg;

    torque = tdfread(strcat(dir,'dataTorque.txt'));
    torque = torque.dataTorque;

    q       = tdfread(strcat(dir,'dataQ.txt'), '\t');
    q       = q.dataQ;

    dq      = tdfread(strcat(dir,'dataQdot.txt'), '\t');
    dq      = dq.dataQdot;

    ddq     = tdfread(strcat(dir, 'dataQdotdot.txt'));
    ddq     = ddq.dataQdotdot;


end
