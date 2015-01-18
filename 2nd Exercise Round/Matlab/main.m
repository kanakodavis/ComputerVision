function main()
%main Launches all task for assigment 2 ? Image stitching and scene
%recognition

%Check if VL toolbox is installed and install if not
if (~exist('vl_version'))
    run('vlfeat/toolbox/vl_setup');
end

addpath('Material');

run_task_image_stitching(false);
run_task_image_stitching(true);
run_task_scene_recognition();

end

