function [raw_ecg, ecg, valid_channels] = load_and_characterize(file_name, fs)
    % LOAD_AND_CHARACTERIZE
    % Loads the ECG data and removes disconnected channels.
    % A disconnected channel is identified if its mean absolute value is too low.

    % Load ECG data
    load(file_name, 'ecg');
    if ~isa(ecg, 'double')
        error('ECG data must be of type "double".');
    end

    % Preserve raw ECG data
    raw_ecg = ecg; % Save a copy of the raw, unprocessed signal

    % Identify disconnected channels based on mean absolute value
    abs_mean = mean(abs(ecg));  % Mean of the absolute values of each channel
    mean_threshold = 0.1 * median(abs_mean);  % Threshold: 10% of the median mean absolute value
    disconnected_channels = abs_mean < mean_threshold;  % Identify disconnected channels

    % Remove disconnected channels
    valid_channels = find(~disconnected_channels);  % Indices of valid channels
    ecg(:, disconnected_channels) = [];  % Remove disconnected channels

    % Display warnings
    for ch = find(disconnected_channels)
        fprintf('WARNING: Channel %d is disconnected (low mean absolute value).\n', ch);
    end

    disp(['Number of valid channels: ', num2str(length(valid_channels))]);
end
