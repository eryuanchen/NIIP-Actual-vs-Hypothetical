% read CA and NIIP
CA = timeseries([570610.543427073;1084709.37792188;1848260.45146685;2686283.89755524;2922208.18281915;1661620.74704081;1609728.61849005;879629.66254546;1358789.86425482;911162.823993165;1454202.31703199;1841064.10163964;1270798.40819002;1274768.2339229;159560.00643703;710801.94391915;1716943.13322465;2276071.94738866;2704738.07314462], {'12/01/2004','12/01/2005','12/01/2006','12/01/2007','12/01/2008','12/01/2009','12/01/2010','12/01/2011','12/01/2012','12/01/2013','12/01/2014','12/01/2015','12/01/2016','12/01/2017','12/01/2018','12/01/2019','12/01/2020','12/01/2021','12/01/2022'});
CA.Name = 'BoP: Current Account (CA)';
CA.TimeInfo.Format = 'mm/dd/yyyy';
CA.UserData.seriesInfo = struct('seriesId','368511627','srCode','SR96648387','country','China','seriesName','BoP: Current Account (CA)','nameLocal','','Unit','RMB mn','frequency','Yearly','source','State Administration of Foreign Exchange','firstObsDate','12/01/1957 00:00:00','LastObsDate','12/01/2023 00:00:00','multiplierCode','mn','tLastUpdTime','02/18/2024 09:29:52','seriesStatus','Active','remarks','','functionInformation','""');
NIIP = timeseries([1992914.26983687;2926616.24933966;4134772.34466941;7243704.26246486;9675844.13774032;8909700.98254733;10046059.1164492;9919756.50343813;10586065.2247456;11179369.027831;9920566.07269424;10674031.785736;13182993.2469699;13953487.5178144;13935368.0327135;15883328.5684405;15778690.0005485;14099825.6095922;17037422.4353155], {'12/01/2004','12/01/2005','12/01/2006','12/01/2007','12/01/2008','12/01/2009','12/01/2010','12/01/2011','12/01/2012','12/01/2013','12/01/2014','12/01/2015','12/01/2016','12/01/2017','12/01/2018','12/01/2019','12/01/2020','12/01/2021','12/01/2022'});
NIIP.Name = 'CN: International Investment Position: Net Asset';
NIIP.TimeInfo.Format = 'mm/dd/yyyy';
NIIP.UserData.seriesInfo = struct('seriesId','368515597','srCode','SR90484277','country','China','seriesName','CN: International Investment Position: Net Asset','nameLocal','','Unit','RMB mn','frequency','Yearly','source','State Administration of Foreign Exchange','firstObsDate','12/01/2004 00:00:00','LastObsDate','12/01/2022 00:00:00','multiplierCode','mn','tLastUpdTime','04/02/2023 14:47:57','seriesStatus','Active','remarks','','functionInformation','""');% Actual NIIP

% read GDP
GDP = timeseries([16184.01609068;18731.89031177;21943.84748167;27009.23237181;31924.46127785;34851.77437348;41211.92557961;48794.01805254;53857.9953469;59296.3229549;64356.31045438;68885.82180493;74639.50594835;83203.59485599;91928.11290666;98651.52022919;101356.70022307;114923.69786109;120472.4], {'12/01/2004','12/01/2005','12/01/2006','12/01/2007','12/01/2008','12/01/2009','12/01/2010','12/01/2011','12/01/2012','12/01/2013','12/01/2014','12/01/2015','12/01/2016','12/01/2017','12/01/2018','12/01/2019','12/01/2020','12/01/2021','12/01/2022'});
GDP.Name = 'Gross Domestic Product';
GDP.TimeInfo.Format = 'mm/dd/yyyy';
GDP.UserData.seriesInfo = struct('seriesId','2126801','srCode','SR597583','country','China','seriesName','Gross Domestic Product','nameLocal','','Unit','RMB bn','frequency','Yearly','source','National Bureau of Statistics','firstObsDate','12/01/1952 00:00:00','LastObsDate','12/01/2023 00:00:00','multiplierCode','BN','tLastUpdTime','01/17/2024 02:02:33','seriesStatus','Active','remarks','','functionInformation','""');

% Actural NIIP is the NIIP official
A_NIIP = NIIP;

% set benchmark as 2003
% Hypothetical NIIP = Benchmark + CA
H_NIIP = NIIP;
N = length(CA.Time)-1
for i = 1:N
    H_NIIP.Data(i+1) = H_NIIP.Data(i)+CA.Data(i+1)
end

% adjusted by GDP
A_NIIP.Data = A_NIIP.Data./GDP.Data./10;
H_NIIP.Data = H_NIIP.Data./GDP.Data./10;

% plot
plot(A_NIIP,'b')
hold on
grid on
plot(H_NIIP,'color','r','linestyle','--')
title('China Actual v. Hypothetical NIIP per GDP');
ylabel('Net International Investment Position (CNY, %)');
xlabel('Year')
ylim([0,50])
legend('Actual NIIP','Hypothetical NIIP')
hold off
