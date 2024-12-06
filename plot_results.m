function plot_results(raw_ecg, preprocessed_ecg, valid_channels, fs)
    % PLOT_RESULTS
    % Generates plots to visualize raw and preprocessed ECG data.

    n_channels = size(preprocessed_ecg, 2);
    time = (0:size(raw_ecg, 1)-1) / fs; % Time vector in seconds

    for ch = 1:n_channels
        figure;
        grid on;

        % Plot raw ECG
        subplot(2, 1, 1);
        plot(time, raw_ecg(:, valid_channels(ch)), 'b'); % Use original channel index
        title(['Raw ECG (Channel ', num2str(valid_channels(ch)), ')']);
        xlabel('Time (s)');
        ylabel('Amplitude');

        % Plot preprocessed ECG
        subplot(2, 1, 2);
        plot(time, preprocessed_ecg(:, ch), 'b');
        title(['Preprocessed ECG (Channel ', num2str(valid_channels(ch)), ')']);
        xlabel('Time (s)');
        ylabel('Amplitude');
    end

    disp('Plots generated.');
end

