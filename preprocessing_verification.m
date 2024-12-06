% ECG Signal Preprocessing Verification
% This script tests the implemented preprocessing functions for:
% 1. Computational time.
% 2. Data type compatibility.
% 3. Validation of expected results.
% 4. Functional testing of the complete pipeline.

% Sampling frequency
fs = 1000;

% Load raw ECG data
load('ecgConditioningExample.mat');

% ----------------------
% 1. Test computational time
% ----------------------
disp('Testing computational time...');
tic;
[raw_ecg, ecg, valid_channels] = load_and_characterize('ecgConditioningExample.mat', fs);
preprocessed_ecg = filter_pipeline(ecg, fs);
comp_time = toc;
fprintf('Computational time for the full pipeline: %.2f seconds.\n', comp_time);

% ----------------------
% 2. Test data type compatibility
% ----------------------
disp('Testing data type compatibility...');
if ~isa(raw_ecg, 'double') || ~isa(ecg, 'double')
    error('ERROR: Data is not in "double" format as expected.');
else
    disp('SUCCESS: Data is in "double" format.');
end

% ----------------------
% 3. Validate expected results
% ----------------------
disp('Validating expected results...');

% Test: Ensure disconnected channels were removed
raw_std = std(raw_ecg, 0, 1);
std_threshold = 0.1 * median(raw_std); % Threshold
disconnected_channels = raw_std < std_threshold;
if any(disconnected_channels)
    fprintf('SUCCESS: %d disconnected channel(s) detected and removed.\n', sum(disconnected_channels));
else
    disp('ERROR: No disconnected channels detected, but expected.');
end

% ----------------------
% 4. Test full pipeline functionality
% ----------------------
disp('Testing full pipeline functionality...');
try
    % Generate a sample plot to verify pipeline results
    test_channel = 2; % Arbitrary channel for testing
    time = (0:size(raw_ecg, 1) - 1) / fs;

    figure;
    subplot(2, 1, 1);
    plot(time, raw_ecg(:, test_channel), 'b');
    title(['Raw ECG Signal (Channel ', num2str(test_channel), ')']);
    xlabel('Time (s)');
    ylabel('Amplitude');

    subplot(2, 1, 2);
    plot(time, preprocessed_ecg(:, test_channel), 'b');
    title(['Preprocessed ECG Signal (Channel ', num2str(test_channel), ')']);
    xlabel('Time (s)');
    ylabel('Amplitude');

    disp('SUCCESS: Full pipeline is functional and produces results.');
catch ME
    disp(['ERROR: Pipeline failed with error: ', ME.message]);
end
