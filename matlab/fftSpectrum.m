function [P1,f] = fftSpectrum(X,Fs)
    L = length(X);
    f = Fs*(0:floor(L/2))/L;
    Y = fft(X);
    P2 = abs(Y/L);
    P1 = P2(1:floor(L/2)+1);
    P1(2:end-1) = 2*P1(2:end-1);
end

