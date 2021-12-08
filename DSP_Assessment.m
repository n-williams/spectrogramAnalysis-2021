clear
% Load data
load DSP_Assessment.mat
%>> whos
%  Name                     Size
%  x                     22400x1 
%  fs                        1x1 

% Define segment size
seg_pwr=7;
seg_size=2^seg_pwr;

% Determine number of complete segments
nseg=fix(length(x)/seg_size);

% Reshape into columns and calculate DFT for each column
x1=reshape(x(1:nseg*seg_size),seg_size,nseg);
dx1=fft(x1);

% Spectrogram based on periodogram for each segment
Sx=(1/seg_size)*abs(dx1.*dx1);


% plot(time,x);
% xlabel('t_{seconds}');
% ylabel('Amplitude');

% Define nyquist freqency and cutoff frequency
nyquist_freq = fs/2;
cutoff_freq = 3500;
cutoff_segment = (cutoff_freq/nyquist_freq)*seg_size;

% Converting sample rate and total samples into time
time = linspace(0,(length(x)/fs),nseg);
freq = linspace(0,cutoff_freq,cutoff_segment);

logSx = log10(Sx(1:cutoff_segment,1:nseg));

% Plot contour map with colour bar
[M,c] = contourf(time,freq,logSx,100);
c.LineColor = 'none';
colormap(jet);
colorbar;

title(['log_{10} Spectrogram, N=' num2str(seg_size)]);
xlabel('t_{seconds}');
ylabel('f_{Hz}'); 
