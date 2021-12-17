%% Dados do Aviao
Sw=1.3;
bw=4.1;
ctipw=.13;
cmaw=.33;
depsilondalpha=0.211;
Sh=0.1;
cmah=0.14;
bh=0.71;
rho=1.06;
g=9.81;
incidencia=2;
etha=[-9	0.861427062
    -8	0.867657856
    -7	0.874562084
    -6	0.88201513
    -5	0.889878152
    -4	0.898499335
    -3	0.9061396
    -2	0.913266122
    -1	0.91965427
    0	0.923955257
    1	0.925148884
    2	0.924846278
    3	0.923974412
    4	0.922408469
    5	0.920509287
    6	0.918393745
    7	0.916117261
    8	0.913587165
    9	0.910776058
    10	0.907745128
    11	0.904334981
    12	0.900051336
    ];
uref=10;
load Inputs/Polares.mat
load Inputs/Massas.mat
%% Dados de entrada
TOWs=[15.6,18.72,19.76,20.8];
CGS=[1,2,3,4];
Clalpha=[6.268,6.273,6.273,6.285];
Vmax=[24.99,24.8,24.55,23,56];
nmax=2;
divVaVc=30;
divVcVd=20;
divn=10;
count=1;
l=1;
for condTOW=1:4
    TOW=TOWs(condTOW);
    cg=CGS(condTOW);
    CLalpha=Clalpha(condTOW);
    Vc=Vmax(condTOW);
    %% Polar Trimada
    polartrim=Polares{3,2}{cg,2};
    CLmax=max(polartrim(:,4));
    Vstall=sqrt(2*TOW*g/Sw/rho/CLmax);
    Va=sqrt(nmax)*Vstall;
    Vd=Vc*1.25;
    %% Rajadas
    j=1;
    for V=linspace(Va,Vc,divVaVc)
        try
            Uref=uref;
            run CalculoRajada.m
            run EsforcosAsa.m
            run EsforcosEH.m
            run EsforcosBoom.m
            cargasrajada.boom(j).V=V;
            cargasrajada.boom(j).n=n;
            cargasrajada.boom(j).Cargas=outboom;
            cargasrajada.asa(j).V=V;
            cargasrajada.asa(j).n=n;
            cargasrajada.asa(j).Cargas=outasa;
            cargasrajada.eh(j).V=V;
            cargasrajada.eh(j).n=n;
            cargasrajada.eh(j).Cargas=outeh;
            j=j+1;
            l=l+1;
            clear outboom outasa outeh n Alphaw Alphah Deltah CLw
        catch
            
        end
    end
    
    for V=linspace(Vc,Vd,divVcVd)
        try
            Uref=uref/2;
            run CalculoRajada.m
            run EsforcosAsa.m
            run EsforcosBoom.m
            run EsforcosEH.m
            cargasrajada.boom(j).V=V;
            cargasrajada.boom(j).n=n;
            cargasrajada.boom(j).Cargas=outboom;
            cargasrajada.asa(j).V=V;
            cargasrajada.asa(j).n=n;
            cargasrajada.asa(j).Cargas=outasa;
            cargasrajada.eh(j).V=V;
            cargasrajada.eh(j).n=n;
            cargasrajada.eh(j).Cargas=outeh;
            j=j+1;
            l=l+1;
            clear outboom outasa outeh n Alphaw Alphah Deltah CLw
        catch
            clear outboom outasa outeh Alphaw Alphah Deltah CLw
        end
    end
    
    %%Trimagem
    j=1;
    for n=linspace(1,nmax,divn)
        for V=linspace(Va,Vc,divVaVc)
            try
                run CalculoTrimagem.m
                run EsforcosAsa.m
                run EsforcosEH.m
                run EsforcosBoom.m
                cargastrim.boom(j).V=V;
                cargastrim.boom(j).n=n;
                cargastrim.boom(j).Cargas=outboom;
                cargastrim.asa(j).V=V;
                cargastrim.asa(j).n=n;
                cargastrim.asa(j).Cargas=outasa;
                cargastrim.eh(j).V=V;
                cargastrim.eh(j).n=n;
                cargastrim.eh(j).Cargas=outeh;
                j=j+1;
                l=l+1;
                clear outboom outasa outeh Alphaw Alphah Deltah CLw
            catch
                clear outboom outasa outeh Alphaw Alphah Deltah CLw
            end
        end
        
        for V=linspace(Vc,Vd,divVcVd)
            try
                run CalculoTrimagem.m
                run EsforcosAsa.m
                run EsforcosBoom.m
                run EsforcosEH.m
                cargastrim.boom(j).V=V;
                cargastrim.boom(j).n=n;
                cargastrim.boom(j).Cargas=outboom;
                cargastrim.asa(j).V=V;
                cargastrim.asa(j).n=n;
                cargastrim.asa(j).Cargas=outasa;
                cargastrim.eh(j).V=V;
                cargastrim.eh(j).n=n;
                cargastrim.eh(j).Cargas=outeh;
                j=j+1;
                l=l+1;
                clear outboom outasa outeh Alphaw Alphah Deltah CLw
            catch
                clear outboom outasa outeh Alphaw Alphah Deltah CLw
            end
        end
    end
    
    Cargas(count).Xcg=cg;
    Cargas(count).TOW=TOW;
    Cargas(count).CargasRajada=cargasrajada;
    Cargas(count).CargasTrim=cargastrim;
    clear cargastrim cargasrajada
    count=count+1;
end
run EnvelopeAsa.m

