%% Adipocytes flux and confidence interval estimation script

% input metabolite labeling and fractions
input.GLC0=isotopomervector([0 0 0 0 0 0],1);
input.GLCU=isotopomervector([1 1 1 1 1 1],1);
input.LAC0=isotopomervector([0 0 0],1);
input.Gln0=isotopomervector([0 0 0 0 0],1);
input.GlnU=isotopomervector([1 1 1 1 1],1);
input.AcCoA0=isotopomervector([0 0],1);
input.Ala0=isotopomervector([0 0 0],1);
input.CO20=isotopomervector([0],1);

% read data on JAVA enabled computers (Mac, PC, Linux)
[mea,covar,raw,avgvar]=xlsreadplus('data.xlsx',{'newglc3','newglc2','newgln3','newgln2'});
[model,free_net,free_xch]=readFluxModel('model3_re.h5');
fmea = xlsreadfmea('data.xlsx',model,free_net,free_xch);
ineq=xlsreadineq('data.xlsx',model,free_net,free_xch);

% cumomer model
simulate=@model3_re;

% account for extremely low variances to avoid overfitting
minvar= 6.80434E-05;
var=diag(covar);
var(var<minvar)=minvar;
var=diag(var);

% evaluate the best fit fluxes and labeling pattern
[net_opt,xch_opt,info]=pargloptflux(simulate,model,free_net,free_xch,ineq,[],input,mea,fmea,var,60);

% display optimal flux data and comparison between simulated and measured
[tflux,tiso,tscore]=writetableplus(simulate,model,net_opt,xch_opt,input,mea,fmea,var);

% estimate 95% confidence intervals
[lb,ub,hs,net_nopt,xch_nopt,nscore,nflag,I]=parconfest3_1(simulate,model,net_opt,xch_opt,ineq,input,mea,fmea,var);
