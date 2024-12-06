function filtered_ecg = filter_pipeline(ecg, fs)
    % FILTER_PIPELINE
    % Applies spike removal, low-pass, notch, and high-pass filters to the ECG data.

    % STEP 1: Spike removal
    spike_threshold = 5;
    ecg_spike_removed = ecg;
    for ch = 1:size(ecg, 2)
        ecg_spike_removed(:, ch) = filloutliers(ecg(:, ch), 'linear', 'ThresholdFactor', spike_threshold);
    end

    % STEP 2: Low-pass filter
    % Create the low-pass filter using a 4th-order Butterworth filter
    cutoffFreq = 60; % in Hz
    [b, a] = butter(4, cutoffFreq / (fs / 2), 'low');  % 4th-order low-pass filter
    ecg_lp = filtfilt(b, a, ecg_spike_removed);  % Apply the filter to the ECG signal

    % Notch filter
    % Design a notch filter centered at the notch frequency (50 Hz) with a suitable bandwidth
    notch_freq = 50;
    q_factor = 30;
    wo = notch_freq / (fs / 2);
    bw = wo / q_factor;
    [notchB, notchA] = iirnotch(wo, bw);
    ecg_notch = filtfilt(notchB, notchA, ecg_lp);

    % High-pass filter
    % Remove baseline wander from the ECG signal using a high-pass filter.
    hp_freq = 0.5;
    [hpB, hpA] = butter(2, hp_freq / (fs / 2), 'high');
    filtered_ecg = filtfilt(hpB, hpA, ecg_notch);

    disp('Filtering completed.');
end
