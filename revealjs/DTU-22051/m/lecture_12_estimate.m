%% Demonstration file for estimates of statistical measures of stochastic signals

clear all
close all

% The signal parameters
L = 40;
T = 5;
mu = 3;
sigma = .1;
delta_n = 1;
n_runs = 3;

% plotting
cols = ([0 0 .6 ; .6 0 0 ; 0 .6 0]);

x = mu+linspace(-10*sigma,10*sigma,500);

figure; hold on
hp = plot(0,0);
hl = plot(0,0);
hs = plot(0,0);

ylim([0 1/sigma])

for l = 1:n_runs
    
    %% mean
    n = mu + sigma*randn(L,1);
    n_sum = 0;
    
    for k = 1:fix(L/delta_n);      
        n_sum = n_sum + sum(n( (k-1)*delta_n+1:k*delta_n));
        norm_factor = k*delta_n;
        %[N,X] = hist(n(1:k*delta_n),nr_bins);
        %bin_width = (max(N)-min(N))/nr_bins
        est_std = std(n(1:k*delta_n));
        est_mu = n_sum/norm_factor;
        %pause
        
        if k==1
            ht = title(['Length of sequence: ' num2str(k*delta_n)]);
            %hp = plot(X,N/(k*delta_n),'color',cols(l,:));
            hp = plot(x,normpdf(x,est_mu,est_std),'color',cols(l,:),'Linewidth',2);
            hl = line([est_mu est_mu],[ylim], ...
                'Color',cols(l,:));
            hs = line(est_mu+[-est_std est_std],[.9/sigma .9/sigma],'Color',cols(l,:));
            xlabel('value of random variable')
            ylabel('probability density / a.u.')
            xlim(mu+[-10*sigma 10*sigma])
        end        
        
        %disp(num2str(n_sum/norm_factor)
        %plot(N,X,'r');
        %line([n_sum/norm_factor n_sum/norm_factor],[ylim])
       
        
        set(hp,'XData',x,'Ydata',normpdf(x,est_mu,est_std));
        set(hl,'XData',[est_mu est_mu],'Ydata',ylim);
        set(hs,'XData',est_mu+[-est_std est_std],'Ydata',[.9/sigma-l*.1 .9/sigma-l*.1]);
        set(ht, 'String', ['Length of sequence: ' num2str(k*delta_n)]);
        pause(T/L)
    end
       
end

hold on
plot(x,normpdf(x,mu,sigma),'Color','k','Linewidth',2)

