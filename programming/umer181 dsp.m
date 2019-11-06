%% lab2
f=18;
fs=10; %sampling freq
n=0:1/fs:10;
x=sin(2*pi*f*n);
stem(n,x);
%% lab3
fprintf('\Lab #03, Quantization');
b=3; % Number of bits
N=120 ; % Number of samples in final signal
n=0:(N-1); %Index
%choose the input type
choice=questdlg('Choose input','Input','Sawtooth','Sine','Random','Random' );
fprintf('Bits = %g , levels = %g , signal= %s.\n',b,2^b,choice);
%Create the input data sequence
switch choice
    case 'Sine'
        x=sin(2*pi*n/N);
    case 'Sawtooth'
        x=sawtooth(2*pi*n/N);
    case 'Random'
        x=randn(1,N); %Random data
        x=x/max(abs(x));  %scale to +/- 1
end
%signal is restricted to between -1 and +1
x(x>=+1)=(1-eps); %make signal from -1 to just less than 1
x(x<-1)=-1;
%Quantize a signal to "b" bits
xq=floor((x+1)*2^(b-1)); %signal is one of 2^n int values (0 to 2^n-1)
xq=xq/(2^(b-1)); %signal is from 0 to 2 (quantized)
xq=xq-(2^(b)-1)/2^(b); %shift signal down (rounding)
xe=x-xq; %quantization error
stem(x,'b');
hold on;
stem(xq,'r');
hold on
stem(xe,'g');
legend('exact','quantized','error','Location','Southeast')
title(sprintf('Signal,Quantized signal and error for %g bit, %g quantization levels',b,2^b));
hold off