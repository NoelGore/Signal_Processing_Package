%% Examine Raw Data
%Plotting raw data with colorbar, title and labels
load('GPR_Lac_St_Anne_line11.mat')
subplot(3,1,1)
imagesc(offsets,twt,GPR11)
c=colorbar();
c.Label.String='Signal Amplitude'
xlabel('Offsets [m]')
ylabel('Time [s]')
title('Raw GPR Data')

subplot(3,1,2)
%creating plot of clipped/cut data
imagesc(offsets,twt,GPR11)
caxis([-1.05e-7 1.05e-7])
c=colorbar();
c.Label.String='Signal Amplitude'
xlabel('Offsets [m]')
ylabel('Time [s]')
title('Clipped Raw GPR Data')

%creating plot of isolated inline GPR panel 
subplot(3,1,3)
GPRplot(twt,GPR11)

%% Debias Traces
debiased=debiasTrace(offsets,GPR11,twt);

%% Trace Equalization
normalized_debiased = TraceEqualization(debiased,offsets);
%% Simple Gain
simpleGain(offsets,twt,normalized_debiased,debiased,GPR11)
%% Automatic Gain Control
[agc,window]=AGC(offsets,twt,normalized_debiased, debiased);
%% Trace Averaging to remove ringing
dewowed = TraceAveraging(offsets,twt,agc,window);
%% Frequency Content
FreqContent(agc,twt,offsets)

%choosing corner frequencies
fcorner=[0.5e8 1e8 1.5e8 3e8];
%applying bandpass filter
[filttraces] = bandpass(agc,twt,fcorner);

%Plotting and labeling figures
figure()
% subplot(2,1,1)
imagesc(offsets,twt,filttraces)
ylabel('Time (s)')
title('Final Filtered Traces')
c=colorbar();
c.Label.String='Filtered Trace Amplitudes'

figure()
% subplot(2,1,2)
imagesc(offsets,twt,agc)
ylabel('Time (s)')
xlabel('Offsets (m)')
title("AGC'd Traces")
c=colorbar();
c.Label.String="AGC'd Trace Amplitudes"

[single_trace]=bandpass(agc(:,2654),twt,fcorner);
figure()
subplot(2,1,1)

plot(twt,agc(1:800,2654))
title('Amplitude Pre-Bandpass')
ylabel('Amplitude (m)')

subplot(2,1,2)
plot(twt,single_trace(1:800))
title('Amplitude Post-Bandpass')
ylabel('Amplitude (m)')
xlabel('Time (s)')