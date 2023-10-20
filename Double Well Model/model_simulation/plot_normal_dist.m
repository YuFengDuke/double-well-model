function [] = plot_normal_dist(mu,std)
x = linspace(-4*std + mu,4*std + mu,1000);
y = 1/sqrt(2*pi)/std*exp(-(x-mu).^2/(2*std^2));
hold on;
plot(x,y,'--k','LineWidth',3);