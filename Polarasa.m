function [ pol ] = Polarasa(alpha)
load Inputs/Polares
%% Achar os indices
alphasup=ceil(alpha);
alphainf=floor(alpha);
pond=alpha-alphainf;
indexsup=find(Polares{4,2}.asa==alphasup);
indexinf=find(Polares{4,2}.asa==alphainf);

%% Parte comum da polar
pol(:,1)=Polares{1,2}(indexsup).dados(:,1);  %Pos
pol(:,2)=Polares{1,2}(indexsup).dados(:,2);  %Corda


% Interpolar

CLsup(:,1)=Polares{1,2}(indexsup).dados(:,4);
CLinf(:,1)=Polares{1,2}(indexinf).dados(:,4);
pol(:,3)=CLsup(:,1).*pond+CLinf(:,1).*(1-pond);         %CLs
CDsup(:,1)=Polares{1,2}(indexsup).dados(:,5)+Polares{1,2}(indexsup).dados(:,6);
CDinf(:,1)=Polares{1,2}(indexinf).dados(:,5)+Polares{1,2}(indexinf).dados(:,6);
pol(:,4)=CDsup(:,1).*pond+CDinf(:,1).*(1-pond);         %CDs
Cmsup(:,1)=Polares{1,2}(indexsup).dados(:,8);
Cminf(:,1)=Polares{1,2}(indexinf).dados(:,8);
pol(:,5)=Cmsup(:,1).*pond+Cminf(:,1).*(1-pond);          %Cms




end

