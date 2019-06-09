function dewowed = TraceAveraging(offsets,twt,agc,window)
%TraceAveraging Function to dewow my GPR Data to remove ringing 

%calculating average of each row
trace_ave=mean(agc');

%subtracting average and transposing data
dewowed=agc'-trace_ave;
dewowed=dewowed';


%Plotting and labelling
figure()
imagesc(offsets,twt,dewowed)
c=colorbar()
c.Label.String='Dewowed Data'
xlabel('Offsets (m)')
ylabel('Times (s)')
title('Dewowed Traces')

%shifting time window, because AGC has padded zeros above
twt=[zeros((window-1),1);twt];

%plotting
figure()
plot(twt,trace_ave)
xlabel('Time (s)')
ylabel('Trace Average Amplitude (m)')
title('Trace Average')

end

