% Main script for ECG Signal Preprocessing
% Author: Miriam Sanz Berbegal (modificado por ChatGPT)
% Description:
% This script loads multichannel ECG data, preprocesses it 
% (removes artifacts, filters, and corrects baseline),
% and visualizes processed ECG signals for each channel.

% Sampling frequency
fs = 1000; 

% Load the dataset 
load("ecgConditioningExample.mat");
n_samples = size(ecg, 1);
time = (0:n_samples-1) / fs;  % Time in seconds

% Plot the original signal of channel 2 (for testing)
figure;
plot(time, ecg(:, 2));
title('Original ECG Signal (Channel 2)');
xlabel('Time (s)');
ylabel('Amplitude');

% Characterize ECG data
disp('Loading and characterizing ECG data...');
[raw_ecg, ecg, valid_channels] = load_and_characterize('ecgConditioningExample.mat', fs);

% Apply filter pipeline
disp('Applying filter pipeline...');
preprocessed_ecg = filter_pipeline(ecg, fs);

% Plot results
disp('Plotting results...');
plot_results(raw_ecg, preprocessed_ecg, valid_channels, fs);

disp('Pipeline completed successfully.');
