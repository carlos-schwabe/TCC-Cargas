function [pol] = Polareh(deltah,alpha)
load Input/Polares
deltasup=ceil(deltah/5)*5;
deltainf=floor(deltah/5)*5;
alphasup=ceil(alpha);
alphainf=floor(alpha);
ponderdelta=(deltah-deltainf)/5;
ponderalpha=alpha-alphainf;
indexdeflexsup=find(Polares{4,2}.deflex==deltasup);
indexdeflexinf=find(Polares{4,2}.deflex==deltainf);
indexalphasupsup= Polares{4,2}.EH{indexdeflexsup}==alphasup;
indexalphainfinf= Polares{4,2}.EH{indexdeflexinf}==alphainf;
indexalphasupinf= Polares{4,2}.EH{indexdeflexinf}==alphasup;
indexalphainfsup= Polares{4,2}.EH{indexdeflexsup}==alphainf;


%% criar parte comum
pol(:,1)=Polares{2,2}{indexdeflexsup,2}(indexalphasupsup).dados(:,2) ;% Posicoes

%% Interpolar Polar   
    
% interpolar para os alphas

clsupsup(:,1:3)=Polares{2,2}{indexdeflexsup,2}(indexalphasupsup).dados(:,6:8);
clinfinf(:,1:3)=Polares{2,2}{indexdeflexinf,2}(indexalphainfinf).dados(:,6:8);
clsupinf(:,1:3)=Polares{2,2}{indexdeflexinf,2}(indexalphasupinf).dados(:,6:8);
clinfsup(:,1:3)=Polares{2,2}{indexdeflexsup,2}(indexalphainfsup).dados(:,6:8);

% Interpolar para os deltas

CLsup(:,1:3)=clsupsup.*ponderalpha+clinfsup.*(1-ponderalpha);
CLinf(:,1:3)=clsupinf.*ponderalpha+clinfinf.*(1-ponderalpha);

pol(:,2:4)=CLsup.*ponderdelta+CLinf.*(1-ponderdelta);






end

