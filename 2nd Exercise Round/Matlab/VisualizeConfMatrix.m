function VisualizeConfMatrix(conf_matrix,group,category_names)

conf_matrix = conf_matrix ./ repmat(sum(conf_matrix,2),1,size(conf_matrix',1));

figure;
imagesc(conf_matrix);
colormap(flipud(gray));
textStrings = num2str(conf_matrix(:),'%0.2f');
textStrings = strtrim(cellstr(textStrings)); 
numCategories = size(unique(group),1);
[x,y] = meshgrid(1:numCategories);   %# Create x and y coordinates for the strings
hStrings = text(x(:),y(:),textStrings(:),...      %# Plot the strings
                'HorizontalAlignment','center');
midValue = mean(get(gca,'CLim'));  %# Get the middle value of the color range
textColors = repmat(conf_matrix(:) > midValue,1,3);  %# Choose white or black for the
                                             %#   text color of the strings so
                                             %#   they can be easily seen over
                                             %#   the background color
set(hStrings,{'Color'},num2cell(textColors,2));  %# Change the text colors

set(gca,'XTick',1:numCategories,...                         %# Change the axes tick marks
        'XTickLabel',category_names,...  %#   and tick labels
        'YTick',1:numCategories,...
        'YTickLabel',category_names,...
        'TickLength',[0 0]);

end