function [agc,window]=AGC(offsets,twt,normalized_debiased, debiased)
%AGC carries out an RMS automatic gain control

window=61;%must be odd number to have center value;

%initializing agc, with padding
agc=zeros(800+window-1,3104);

%Padding zeros at start, and end of my data
normalized_debiased=[zeros(((window-1)/2),length(normalized_debiased(1,:)));normalized_debiased;zeros(((window-1)/2),length(normalized_debiased(1,:)))];

%creating for loop for sliding window, for all traces
for k=1:length(normalized_debiased(1,:))
    for j=window:length(agc(:,1))-(window-1) %calculating center of window
        center=j;
        rms_ave=sqrt(sum(normalized_debiased([j-(window-1)/2:j+(window-1)/2],k).^2)/window);
        agc(center,k)=normalized_debiased(center,k)/rms_ave;
    end
end



%plotting all my figures
figure()
subplot(2,1,1)
plot(twt,normalized_debiased(1:800,2564))
title('Trace Before AGC')
ylabel('Debiased Amplitude (m) ')

subplot(2,1,2)
plot(twt,agc(1:800,2564))
title('Trace After AGC')
xlabel('Time (s)')
ylabel("AGC'd and Debiased Amplitude (m) ")


figure()
imagesc(offsets,twt,agc)
title('Scaled and Cut GPR Data Post-AGC')
xlabel('Offsets (m)')
ylabel('Time (s)')
c=colorbar();
c.Label.String="AGC'd Amplitude";


end
