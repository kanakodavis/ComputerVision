disp('Starting benchmark');

total = tic;

disp('Running colorizing task');
%RunBenchmark('./run_task_colorizing');

disp('Running image segmentation task');
RunBenchmark('./run_task_image_segmentation');

disp('Running scale invariant blob detection task');
RunBenchmark('./run_task_blob_detection');

disp('Total benchmark runtime:');
toc(total)

disp('Benchmarking done');