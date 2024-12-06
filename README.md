# software_test

Here is the "ELECTROCARDIOGRAM SIGNAL PROCESSING TEST" to continue in the selection process of COR/Corify.

## Description

This repository contains scripts for preprocessing multichannel ECG data. It includes functions for detecting disconnected channels, applying various filters (spike removal, low-pass, notch, high-pass), and visualizing the results. Additionally, a verification script is provided to test the functionality and performance of the preprocessing pipeline.

## Files in the Repository

- **`main_script.m`**: Main script for ECG signal preprocessing. It loads the data, applies the preprocessing pipeline, and visualizes the results.
- **`load_and_characterize.m`**: Function to load ECG data, identify and remove disconnected channels based on the mean absolute value.
- **`filter_pipeline.m`**: Function that applies spike removal, low-pass, notch, and high-pass filters to the ECG data.
- **`plot_results.m`**: Function that generates plots comparing raw and preprocessed ECG signals for each channel.
- **`ecgConditioningExample.mat`**: Example ECG dataset used for testing the preprocessing pipeline (replace with your own dataset as needed).
- **`preprocessing_verification.m`**: A verification script that tests the preprocessing functions for computational time, data compatibility, expected results validation, and full pipeline functionality.

## Usage

1. Run the `main_script.m` to preprocess the ECG data and visualize the results.
2. Run the `verification_script.m` to test the preprocessing pipeline, check computational time, validate expected results, and verify full pipeline functionality.

