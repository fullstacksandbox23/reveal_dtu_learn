close all; clear all;

%% Simple convolution
% Let's have a simple example of a convolution and how the overlap of 
% impulse responses over time construct a more complex signal

% Some parameters to start with
fs = 200;       % sampling frequency
T = 1;          % duration in seconds
t = 0:1/fs:T-1/fs;

% the path to the files for export
path2files = ['..', filesep, 'pics', filesep];
fig_w = 9;
fig_h = 8;      % figure width/height in cm
lw = 1.5;       % line width

% three pulses equally spaced, differently scaled
t_1 = .2;
a_1 = 2;
t_2 = .4;
a_2 = -1;
t_3 = .6;       % in s
a_3 = 3;        % a.u.

% the impulse response
tau = .15;
f_h = 11;
h = cos(2*pi*f_h*t).*exp(-t/tau);

% create the sequence of pulses
x = zeros(1,fs*T);
x([t_1*fs t_2*fs t_3*fs]) = [a_1 a_2 a_3];

% plot the signal x
prepare_figure_scale(fig_w,fig_h)     % this is a self-written function to do figure cosmetics
stem(t,x,'linewidth',lw);
ylim([-4.5 3.5])
xlabel('time / a.u.')
ylabel('amplitude ( a.u.)')
legend('input signal','Location','SouthWest')
% exporting
fname = [path2files, 'lecture_02_simple_conv_0'];
saveas(gcf,fname,'png')


% now all we have to do is to place the IRs at the spots where we have the
% impulses
xh_1 = zeros(1,fs*T);
xh_1([t_1*fs:end-1]) = a_1*h(1:end-t_1*fs)
hold on;
stem(t,xh_1,'linewidth',lw)
legend({'input signal','IR evoked by first pulse'})
% exporting
fname = [path2files, 'lecture_02_simple_conv_1'];
saveas(gcf,fname,'png')

xh_2 = zeros(1,fs*T);
xh_2([t_2*fs:end-1]) = a_2*h(1:end-t_2*fs)
hold on;
stem(t,xh_2,'linewidth',lw)
legend({'input signal','IR evoked by first pulse', 'IR evoked by second pulse'})
% exporting
fname = [path2files, 'lecture_02_simple_conv_2'];
saveas(gcf,fname,'png')

xh_3 = zeros(1,fs*T);
xh_3([t_3*fs:end-1]) = a_3*h(1:end-t_3*fs)
hold on;
stem(t,xh_3,'linewidth',lw)
legend({'input signal','IR evoked by first pulse', ...
            'IR evoked by second pulse', ...
            'IR evoked by third pulse'})
% exporting
fname = [path2files, 'lecture_02_simple_conv_3'];
saveas(gcf,fname,'png')


% and now adding them all up
prepare_figure_scale(fig_w,fig_h)     % this is a self-written function to do figure cosmetics
x_total = xh_1 + xh_2 + xh_3;
stem(t,x_total,'linewidth',lw)
ylim([-4.5 3.5])
xlabel('time / a.u.')
ylabel('amplitude ( a.u.)')

% if you want to compare with the convolution result - here you go:
y = conv(x,h);
hold on;
plot(t,y(1:length(t)),'r','linewidth',lw);
legend({'Summed evoked IR','Result of convolution'}, ...
        'Location','SouthWest')   
% exporting
fname = [path2files, 'lecture_02_simple_conv_4'];
saveas(gcf,fname,'png')

