function [r, t_r, b, y, t_y, p] = generate_pam_signal_matched_filter_output(N, T, Q, A, SNR_dB)
    % Parameters
    Ts = T / Q;             % Sampling period
    L = N * Q;              % Total number of samples (before convolution)

    % Generate binary sequence: b[k] in {-A, +A}
    b = A * (2 * randi([0, 1], 1, N) - 1);

    % Generate rectangular pulse and normalize it
    p = ones(1, Q); 
    p = p / norm(p);        % Ensures unit energy

    % Upsample and shape the signal
    b_upsampled = zeros(1, L);
    b_upsampled(1:Q:end) = b;       % Insert symbols every Q samples
    s = conv(b_upsampled, p, 'full');  % Signal after pulse shaping

    % Compute noise variance from SNR
    signal_power = A^2 / T;
    snr_linear = 10^(SNR_dB / 10);
    sigma_w = sqrt(signal_power / snr_linear);

    % Add white Gaussian noise
    w = sigma_w * randn(1, length(s));
    r = s + w;

    % Matched filter output
    y = conv(r, p, 'full');

    % Time vectors
    t_r = (0:length(r)-1) * Ts;     % For received signal
    t_y = (0:length(y)-1) * Ts;     % For matched filter output
end
