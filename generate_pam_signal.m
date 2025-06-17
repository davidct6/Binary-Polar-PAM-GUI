function [r, t, b, p] = generate_pam_signal(N, T, Q, A, SNR_dB)

    % Parameters
    Ts = T / Q;                    % Sampling period
    L = N * Q;                     % Total number of samples
    t = (0:L-1) * Ts;              % Time vector

    % Generate binary sequence: b[k] in {-A, +A}
    b = A * (2 * randi([0, 1], 1, N) - 1);

    % Generate rectangular pulse
    p = ones(1, Q) / sqrt(T); 

    % Convolve symbols with pulse
    b_upsampled = zeros(1, L);
    b_upsampled(1:Q:end) = b;      % Insert symbols every Q samples
    s = conv(b_upsampled, p, 'full');  % Final signal without noise

    % Compute noise variance from SNR
    signal_power = A^2 / T;
    snr_linear = 10^(SNR_dB / 10);
    sigma_w = sqrt(signal_power / snr_linear);

    % Generate and add white Gaussian noise
    w = sigma_w * randn(1, length(s));
    r = s + w;

    % Trim to match length of original signal
    r = r(1:L + Q - 1);
    t = (0:length(r)-1) * Ts;
end
