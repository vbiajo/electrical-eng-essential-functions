
%% DECLARATIONS AND INITIALIZATIONS

% Calculates the running RMS array of a signal using the specified fundamental frequency and sample time. The initial RMS is considered zero.
% y = running_rms(signal, fundamental_frequency, sample_time)

% Author: A. Bolu Ajiboye (rms function), Vítor Biajo (modification for running_rms)

function y = running_rms(signal, fundamental_frequency, sample_time)

windowlength = 1/(sample_time)/fundamental_frequency;
overlap = windowlength-1;
delta = windowlength - overlap;

%% CALCULATE RMS

indices = 1:delta:length(signal);

if length(signal) - indices(end) + 1 < windowlength
    indices = indices(1:find(indices+windowlength-1 <= length(signal), 1, 'last'));
end

y = zeros(1, length(indices));

% Square the samples
signal = signal.^2;

index = 0;
for i = indices
	index = index+1;
	% Average and take the square root of each window
	y(index) = sqrt(mean(signal(i:i+windowlength-1)));
end

y = [zeros(1,overlap) y];
