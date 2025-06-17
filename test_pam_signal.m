% Parameters
N = 10;
T = 1e-3;       
Q = 20;      
A = 1;          
SNR_dB = 10;  

% Generate signal
[r, t, b, p] = generate_pam_signal(N, T, Q, A, SNR_dB);

% Plot 
figure;
plot(t, r, 'b'); hold on;
stem(t(1:Q:end), r(1:Q:end), 'ro', 'filled');
title('Noisy PAM Signal r[n]');
xlabel('Time (s)');
ylabel('Amplitude');
legend('r[n]', 'Samples at multiples of T');
grid on;
