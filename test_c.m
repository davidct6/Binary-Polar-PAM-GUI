% Parameters
N = 10; T = 1e-3; Q = 20; A = 1; SNR_dB = 10;

% Generate signal and matched filter output
[r, y, t_y, b, p] = generate_pam_signal_matched_filter_output(N, T, Q, A, SNR_dB);

% Plot matched filter output
Ts = T / Q;
t_y = (0:length(y)-1) * Ts;

figure;
plot(t_y, y, 'm'); hold on;
stem(t_y(Q:Q:end), y(Q:Q:end), 'ko', 'filled'); % sampling points
title('Matched Filter Output y[n]');
xlabel('Time (s)');
ylabel('Amplitude');
legend('y[n]', 'Samples at multiples of T');
grid on;
