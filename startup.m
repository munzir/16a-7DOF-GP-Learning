% startup script to make Octave/Matlab aware of the GPML package
%
% Copyright (c) by Carl Edward Rasmussen and Hannes Nickisch 2017-02-22.

disp('Executing GPML 4.1 Startup Script...')
mydir = fileparts(mfilename('/home/mouhyemen/desktop/software/gpml_4.1/v4.1-2017-10-19/'));
addpath(mydir)

dirPath = '/home/mouhyemen/desktop/software/gpml_4.1/v4.1-2017-10-19/';
addpath('/home/mouhyemen/desktop/software/gpml_4.1/v4.1-2017-10-19/');
addpath('/home/mouhyemen/desktop/software/gpml_4.1/v4.1-2017-10-19/cov');
addpath('/home/mouhyemen/desktop/software/gpml_4.1/v4.1-2017-10-19/doc');
addpath('/home/mouhyemen/desktop/software/gpml_4.1/v4.1-2017-10-19/inf');
addpath('/home/mouhyemen/desktop/software/gpml_4.1/v4.1-2017-10-19/lik');
addpath('/home/mouhyemen/desktop/software/gpml_4.1/v4.1-2017-10-19/mean');
addpath('/home/mouhyemen/desktop/software/gpml_4.1/v4.1-2017-10-19/prior');
addpath('/home/mouhyemen/desktop/software/gpml_4.1/v4.1-2017-10-19/util');