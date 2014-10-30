t = 1:0.1:3;
et = exp(t);

im_in = read_image('sunflower3.png');

scale_space = create_scale_space(im_in, et);

for i=1:21
   
    subplot(3,7,i);
    imagesc(squeeze(scale_space(i,:,:)));
    title_string = sprintf('\\sigma =%6.2f', et(i));
    title(title_string);
    h = get(gca, 'title');
    set(h, 'FontSize', 16) 
    set(gca,'ytick',[]);
    set(gca,'xtick',[]) 
    colormap gray;
    drawnow();
    
end