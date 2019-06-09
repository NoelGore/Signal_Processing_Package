function [filttraces] = bandpass(traces,t,fcorner)

%bandpass is a program to carry out a bandpass filter
% over a set of seismic traces.  traces is
% the set of traces ordered in traces by columns,
% t is the timebase (seconds), and fcorner is a four component
% vector which contains the corners of a trapezoid
% bandpass
% To run  [filttraces] = bandpass(traces,t,fcorner);

delt = t(2) - t(1);
Nqy = 1/(2*delt);

if fcorner(4) > Nqy
	disp('Bandpass frequencies are greater than Nyquist')
	return;
end

[m,n] = size(traces);
%disp('NOTE: Present implementation assumes even data points')
mask = zeros(1,m);
delf = 2*Nqy/m;
ind = round(fcorner/delf) + 1; % Remember 0 freq = first number in fft
% ind(5:8) = m - (ind -2);
temp = hanning(2*(ind(2)-ind(1))+1);
mask(ind(1):ind(2)) = temp(1:round(length(temp)/2));
mask(ind(2):ind(3)) = ones(size(mask(ind(2):ind(3))));
temp = hanning(2*(ind(4)-ind(3))+1);
mask(ind(3):ind(4)) = temp(round(length(temp)/2):length(temp));
clear temp
mask((2+m/2):m) = fliplr(mask(2:(m/2)));
mask = mask';

temp = fft(traces);
temp = temp.*(mask*ones(1,n));
filttraces = real(ifft(temp));

return;
