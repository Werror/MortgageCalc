clear all
close all


fid = fopen('boc.csv');
HDRS = textscan(fid,'%s %s %s %s %s %s %s %s %s %s %s %s %s',1, 'delimiter',',');
DATA = textscan(fid,'%s %d %d %d %d %s %d %d %d %d %d %d %d','delimiter',',');
fclose(fid);
outCell = cell(size(DATA{1},1), length(HDRS));
for i = 1:length(HDRS)
    if isnumeric(DATA{i})
        outCell(:,i) = num2cell(DATA{i});
    else
        outCell(:,i) = DATA{i};
    end
end

date = flipud(datestr(DATA{1,1}));
datalen = size(date);
M = csvread('boc.csv', 1, 1);
prime = fliplr(M(:,4)');

plot(prime,'.');
title('Historical prime rate')
set(gca,'XTick',[1:50:datalen],'XTickLabel',date(1:50:end,:));
rotateXLabels(gca, 90);
clear fid DATA outCell

%%

years=25;
annual_rate=1.99/100; % 1.99% annual rate
house_value=566500;
downpayment=20/100; % 20% down
num_pay_per_year=26;

loan_size=house_value*(1-downpayment);

[P,In,Ba]=compute_mortgage(loan_size,annual_rate,years,num_pay_per_year);

% close all

fprintf('tatal princeple %d\n', loan_size)
fprintf('down payment %d\n', downpayment*house_value)
fprintf('Each Payment: %1.2f \nTotal Interest Paid: %1.2f\n',P,sum(In));

figure;
Ps=P-In;
subplot(221)
plot((1:length(Ps))/num_pay_per_year,Ps/P,(1:length(In))/num_pay_per_year,In/P);
title('Fractions of principal and interest paid at each period');
xlabel('Year');
ylabel('Fractions');
legend('Principal fraction','interest fraction');
hold on
subplot(223)
plot((1:length(Ps))/num_pay_per_year,Ps,(1:length(In))/num_pay_per_year,In);
title('Fractions of principal and interest paid at each period');
xlabel('Year');
ylabel('$');
legend('Principal $','interest $');
hold on
plot((1:length(Ps))/num_pay_per_year,P,'k');

subplot(222)
plot((1:length(Ba))/num_pay_per_year, Ba);
title('Remaining loan');
xlabel('Period');
ylabel('Remaining loan');
hold on

subplot(224)
plot((1:length(Ba))/num_pay_per_year, cumsum(In))
hold on
%%

years=25;
annual_rate=2.5/100; % 1.99% annual rate
house_value=566500;
downpayment=20/100; % 20% down
num_pay_per_year=26;

loan_size=house_value*(1-downpayment);

[P,In,Ba]=compute_mortgage(loan_size,annual_rate,years,num_pay_per_year);

fprintf('tatal princeple %d\n', loan_size)
fprintf('down payment %d\n', downpayment*house_value)
fprintf('Each Payment: %1.2f \nTotal Interest Paid: %1.2f\n',P,sum(In));


Ps=P-In;
subplot(221)
plot((1:length(Ps))/num_pay_per_year,Ps/P,'--',(1:length(In))/num_pay_per_year,In/P,'--');
title('Fractions of principal and interest paid at each period');
xlabel('Year');
ylabel('Fractions');
legend('Principal fraction','interest fraction','Location','NorthWest');
subplot(223)
plot((1:length(Ps))/num_pay_per_year,Ps,'--',(1:length(In))/num_pay_per_year,In,'--');
title('Fractions of principal and interest paid at each period');
xlabel('Year');
ylabel('$');
legend('Principal $','interest $','Location','SouthWest');
plot((1:length(Ps))/num_pay_per_year,P,'k--');


subplot(222)
plot((1:length(Ba))/num_pay_per_year, Ba,'--');
title('Remaining loan');
xlabel('Period');
ylabel('Remaining loan');

subplot(224)
plot((1:length(Ba))/num_pay_per_year, cumsum(In),'--')
title('Interest CDF');


years=25;
annual_rate=1.99/100; % 1.99% annual rate
house_value=566500;
for i=20:50
    downpayment=i/100; % 20% down
    num_pay_per_year=26;
    loan_size=house_value*(1-downpayment);
    [P,In,Ba]=compute_mortgage(loan_size,annual_rate,years,num_pay_per_year);
    a(i-19,:)=sum(In)-122212.53;
    b(i-19,:)=downpayment*house_value-113300;
end

plot(b,a);