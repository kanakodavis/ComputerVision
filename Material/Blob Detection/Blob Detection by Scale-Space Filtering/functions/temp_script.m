clear blobs;

% Optimal call for 'onecircle.png'
%im_in = read_image('onecircle.png');
%blobs = detect_blobs(im_in, 0.50, 1:.1:3.0);
%blobs_trimmed = prune_blobs(blobs, 0.25);

% Optimal call for 'scalespaceTest.png'
im_in = read_image('scalespaceTest.png');
blobs = detect_blobs(im_in, 0.20, 1:.2:3.0);
blobs_trimmed = prune_blobs(blobs, 0.25);

% Optimal call for 'sunflower2.png'
%im_in = read_image('sunflower2.png');
%blobs = detect_blobs(im_in, 0.33, 2:.20:3.5, [50 50]);
%blobs_trimmed = prune_blobs(blobs, 0.25);

% Optimal call for 'sunflower3.png'
%im_in = read_image('sunflower3.png');
%blobs = detect_blobs(im_in, 0.25, 2:.20:3.5);
%blobs_trimmed = prune_blobs(blobs, 0.25);

figure();
imagesc(double(im_in));    
set(gca,'ytick',[]);
set(gca,'xtick',[]) 
colormap gray;
axis square;
hold on;

for i=1:length(blobs_trimmed)
    
    blob_info = blobs_trimmed{i};
    
    [circx circy] = create_circle(blob_info(1), blob_info(2), 1.5*blob_info(3));
    plot(circy, circx, '-r', 'linewidth', 2);

    %fprintf('x: %f \t y: %f \t value: %f\n', blob_info(1), blob_info(2), blob_info(4)); 
    
end