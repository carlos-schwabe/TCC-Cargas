    %% Condicao inicial
    CLw=2*TOW*g/V/V/rho/Sw*n;
    Alphaw=incidencia+interp1(polartrim(:,4),polartrim(:,1),CLw);
    CLh=interp1(polartrim(:,4),polartrim(:,6),CLw);
    Alphah=interp1(polartrim(:,4),polartrim(:,3),CLw);
    Deltah=interp1(polartrim(:,4),polartrim(:,2),CLw);
    %% Calculo fatores de Rajada EH
    Fprof=(.5*rho*V^2*Sh*CLh*interp1(etha(:,1),etha(:,2),Alphaw));
    %% Criar Polares
    polareh=Polareh(Deltah,Alphah);
    polareh(:,2)=polareh(:,2);
    polarasa=Polarasa(Alphaw);
    polarasa(:,3)=polarasa(:,3);
    clear CLh CLw Deltah deltanasa Deltanprof mi kg w
    