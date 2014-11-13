function [ ] = RunBenchmark( funct )
%RunBenchmark Runs the given task and measures its runtime
%   Take current time, then run task, then print the elapsed time
tic;

run(funct);

toc

end

