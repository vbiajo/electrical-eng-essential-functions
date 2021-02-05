
%% DECLARATIONS AND INITIALIZATIONS

% Calculates the running THD array of a signal using the specified fundamental frequency and sample time. The initial THD is considered zero.
% y = running_thd(signal, fundamental_frequency, sample_time)

% Author: A. Bolu Ajiboye (rms function), Vítor Biajo (modification for running_thd)

function y = running_thd(signal, fundamental_frequency, sample_time)

windowlength = 1/(sample_time)/fundamental_frequency;
sample_frequency = 1/sample_time;
overlap = windowlength-1;
delta = windowlength - overlap;

%% CALCULATE RMS

indices = 1:delta:length(signal);

if length(signal) - indices(end) + 1 < windowlength
    indices = indices(1:find(indices+windowlength-1 <= length(signal), 1, 'last'));
end

rmsT = zeros(1, length(indices));
thd = zeros(1, length(indices));


% Square the samples
signal2 = signal.^2;

index = 0;
for i = indices
	index = index+1;
	% Average and take the square root of each window
	rmsT(index) = sqrt(mean(signal2(i:i+windowlength-1)));
    
    Y = fft((signal(i:i+windowlength-1)));
    Y = abs(Y/windowlength);
    Y = Y(1:floor(windowlength/2)+1);
    Y(2:end-1) = 2*Y(2:end-1);
    
    n_f1 = fundamental_frequency/(sample_frequency/windowlength) + 1;
    rmsF = Y(n_f1)/sqrt(2);
    
    thd(index) = sqrt((rmsT(index)^2 - rmsF^2))/rmsF;
    
end

y = [zeros(1,overlap) thd];
