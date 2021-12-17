    w=TOW*g*0.224809;
    %% Condicao inicial
    CLw=2*TOW*g/V/V/rho/Sw;
    Alphaw=incidencia+interp1(polartrim(:,4),polartrim(:,1),CLw);
    CLh=interp1(polartrim(:,4),polartrim(:,6),CLw);
    Alphah=interp1(polartrim(:,4),polartrim(:,3),CLw);
    Deltah=interp1(polartrim(:,4),polartrim(:,2),CLw);
    %% Calculo fatores de Rajada Asa
    mi=2*(TOW*32.174/(Sw*0.3048^2))/(rho*0.0019403*cmaw*3.28084*CLalpha*32.174);
    kg=0.88*mi/(5.3+mi);
    n=1+kg*Uref*V*1.94384*CLalpha/(498*(TOW*9.81/Sw*0.02088));
    %% Calculo fatores de Rajada EH
    Fprof=(.5*rho*V^2*Sh*CLh*interp1(etha(:,1),etha(:,2),Alphaw));
    Deltanprof=1+4.44*kg*((Uref*V*1.94384*6*Sh*10.76/(498))/abs(Fprof)*(1-depsilondalpha));
    %Fprof=Deltanprof*Fprof;
    %% Criar Polares
    CLw=2*TOW*g*n/V/V/rho/Sw;
    if CLw>CLmax
        deltanasa=CLw/CLmax;
        CLw=CLmax;
    else
        deltanasa=1;
    end
    Alphaw=incidencia+interp1(polartrim(:,4),polartrim(:,1),CLw);
    polareh=Polareh(Deltah,Alphah);
    polareh(:,2)=polareh(:,2)*Deltanprof;
    polarasa=Polarasa(Alphaw);
    polarasa(:,3)=polarasa(:,3)*deltanasa;
    clear CLh CLw Deltah deltanasa Deltanprof mi kg w
    