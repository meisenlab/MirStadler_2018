function  [prebleach_smoothed postbleach_smoothed] = frap_plot_means3(frapData, bleach_frame, smoothWindowSize, numberofFrames)
%FRAP_PLOT_MEANS Plots the frap_norm_means for our FRAP data
%   Detailed explanation goes here
framerate = 0.0240;
figure();
set(gca,'fontsize',20)
colors = {[72/255, 143/255, 208/255],[107/255, 107/255, 107/255],[255/255, 148/255, 5/255]};
hold on;
for k=1:length(frapData)
    sample_matrix = frapData(k).norm_FRAP;
    num_samples = length(sample_matrix(1,:));
    means = mean(sample_matrix,2);
    std_devs = std(sample_matrix, 0, 2);
    std_err_mean = std_devs ./ sqrt(num_samples);
    prebleach_smoothed = smooth(means(1:bleach_frame), smoothWindowSize);
    postbleach_smoothed = smooth(means((bleach_frame + 1):numberofFrames), smoothWindowSize);
    means_smoothed = vertcat(prebleach_smoothed, postbleach_smoothed);
    
    %means_smoothed = postbleach_smoothed;
    %return
    shadedErrorBar(framerate * (1:numberofFrames),means_smoothed(1:numberofFrames),std_err_mean(1:numberofFrames), 'lineprops',{'markerfacecolor',colors{k}, 'color', colors{k}, 'linewidth', 2.5});
end
xlabel('Time (s)')
ylabel('Fluorescence (corrected)')

hold off
end

