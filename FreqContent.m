function FreqContent(agc,twt,offsets)
%FreqContent computes and displays an amplitude spectrum for 
%a debiased trace using Matlabs FFT

%since 2^10=1024, we'll pad zeros to our trace, as FFT works best with
%powers of 2

%picking a trace to analyze
which_trace=843;

%calculating delta time
del_t=twt(2)-twt(1);

%padding zeros
padded_zeros=zeros((1024-length(agc(:,1))),1);
%Nyquist frequency
fn=1./(2*del_t);
%sampling frequency
fs=length(padded_zeros)*del_t/2;

%padding zeros to agc data
padded_agc=[padded_zeros;agc(:,which_trace)];

%using positive values, post fast fourier transform
padded_agc=abs(fft(padded_agc));
%calculating frequencies, from zero to nyquist
freq=(fs*(0:length(padded_agc)/2))/length(padded_agc);

%plotting and labelling figures
figure()
subplot(2,1,1);
plot(freq,padded_agc(1:(length(padded_agc)/2 +1)));
ylabel('Amplitude (m)')
title('Amplitude Spectrum')

subplot(2,1,2)
plot(freq,mag2db(padded_agc(1:(length(padded_agc)/2+1))));
xlabel('Frequency (Hz)')
ylabel('Amplitude (Db)')

end

