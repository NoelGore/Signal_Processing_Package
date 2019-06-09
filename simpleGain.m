function simpleGain(offsets,twt,normalized_debiased,debiased,GPR11)
%simpleGain function to apply a time dependent gain
% applies function of form g(t)=t^n on a single trace, post-debiasing and
% energy normalization

%generating random trace for quality control
which_trace=randi(length(GPR11(1,:)))
n=3; %some constant larger than 1

%gain
g=twt.^n;

%single trace, pre and post simple gaining
prefilter=GPR11(:,which_trace);
postfilter=normalized_debiased(:,which_trace).*g;


%plotting and labelling figures
figure()
subplot(2,1,1)
plot(twt,prefilter)
ylabel('Prefilter Amplitude (m)')
title('Prefilter Data')

subplot(2,1,2)
plot(twt,postfilter)
title('Postfilter data')
xlabel('Time (s)')
ylabel('Postfilter Amplitude (m)')


figure()
imagesc(offsets,twt,normalized_debiased)
caxis([-1.05e-7 1.05e-7])
c=colorbar()
c.Label.String='Debiased Amplitude'
title('Scaled and Cut GPR Data Post-Filter')
xlabel('Offsets (m)')
ylabel('Time (s)')
end

