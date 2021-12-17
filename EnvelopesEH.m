%%eh
load Cargas.mat
%% Rajada
counter=1
j=1;
for i=1:4
    rajada=Cargas(i).CargasRajada.eh;
    for k=1:size(rajada,2)
        Vy=rajada(k).Cargas.Vy;
        Vz=rajada(k).Cargas.Vz;
        Mt=rajada(k).Cargas.Mt;
        MFz=rajada(k).Cargas.MFz;
        MFy=rajada(k).Cargas.MFy;
        pos=rajada(k).Cargas.pos;
        for sec=1:30
            Vycheck(j,sec)=rajada(k).Cargas.Vy(sec);
            Vzcheck(j,sec)=rajada(k).Cargas.Vz(sec);
            Mtcheck(j,sec)=rajada(k).Cargas.Mt(sec);
            MFzcheck(j,sec)=rajada(k).Cargas.MFz(sec);
            MFycheck(j,sec)=rajada(k).Cargas.MFy(sec);
            indices(counter)=j;
            counter=counter+1;
        end
        monitor(j,1)=i;
        monitor(j,2)=k;
        monitor(j,3)=0;
        j=j+1;
    end
end
%% Trimagem
for i=1:4
    cg=Cargas(i).Xcg;
    tow=Cargas(i).TOW;
    rajada=Cargas(i).CargasTrim.eh;
    for k=1:size(rajada,2)
        Vy=rajada(k).Cargas.Vy;
        Vz=rajada(k).Cargas.Vz;
        Mt=rajada(k).Cargas.Mt;
        MFz=rajada(k).Cargas.MFz;
        MFy=rajada(k).Cargas.MFy;
        pos=rajada(k).Cargas.pos;
        for sec=1:30
            Vycheck(j,sec)=rajada(k).Cargas.Vy(sec);
            Vzcheck(j,sec)=rajada(k).Cargas.Vz(sec);
            Mtcheck(j,sec)=rajada(k).Cargas.Mt(sec);
            MFzcheck(j,sec)=rajada(k).Cargas.MFz(sec);
            MFycheck(j,sec)=rajada(k).Cargas.MFy(sec);
            indices(counter)=j;
            counter=counter+1;
        end
        monitor(j,1)=i;
        monitor(j,2)=k;
        monitor(j,3)=1;
        j=j+1;
    end
end


%% Linhas de envelope

for i=1:30
    Vymax(i)=max(Vycheck(:,i));
    jmax(i,1)=find(Vycheck==Vymax(i),1);
    Vzmax(i)=max(Vzcheck(:,i));
    jmax(i,2)=find(Vzcheck==Vzmax(i),1);
    Mtmax(i)=max(Mtcheck(:,i));
    jmax(i,3)=find(Mtcheck==Mtmax(i),1);
    MFzmax(i)=max(MFzcheck(:,i));
    jmax(i,4)=find(MFzcheck==MFzmax(i),1);
    MFymax(i)=max(MFycheck(:,i));
    jmax(i,5)=find(MFycheck==MFymax(i),1);
end

for i=1:30
    Vymin(i)=min(Vycheck(:,i));
    jmin(i,1)=find(Vycheck==Vymin(i));
    Vzmin(i)=min(Vzcheck(:,i));
    jmin(i,2)=find(Vzcheck==Vzmin(i));
    Mtmin(i)=min(Mtcheck(:,i));
    jmin(i,3)=find(Mtcheck==Mtmin(i));
    MFzmin(i)=min(MFzcheck(:,i));
    jmin(i,4)=find(MFzcheck==MFzmin(i));
    MFymin(i)=min(MFycheck(:,i));
    jmin(i,5)=find(MFycheck==MFymin(i));
end

%% 2D Vy x Mt
figure
subplot(1,2,1)
index=find(monitor(:,3)==1,1)
scatter(Vycheck(1:index-1,1),Mtcheck(1:index-1,1),'r');
hold on
scatter(Vycheck(index:length(monitor),1),Mtcheck(index:length(monitor),1),'g');
K1 = convhull(Vycheck(:,1),Mtcheck(:,1));
K1(:,2)=Vycheck(K1(:,1));
K1(:,3)=Mtcheck(K1(:,1));
plot(Vycheck(K1(:,1),1),Mtcheck(K1(:,1),1),'k', 'LineWidth',2)
legend('Rajada','Manobra','Envelope')
ax = gca;
ax.FontWeight='bold';
ax.FontSize=16
ax = gca;
title('Envelope V_{N} x Mt')
xlabel('V_{N} [N]')
ylabel('Mt [Nm]')

%% 2D Mz v My
subplot(1,2,2)
index=find(monitor(:,3)==1,1)
scatter(MFzcheck(1:index-1,1),MFycheck(1:index-1,1),'r');
hold on
scatter(MFzcheck(index:length(monitor),1),MFycheck(index:length(monitor),1),'g');
K2 = convhull(MFzcheck(:,1),MFycheck(:,1));
K2(:,2)=MFzcheck(K2(:,1));
K2(:,3)=MFycheck(K2(:,1));
plot(MFzcheck(K2(:,1),1),MFycheck(K2(:,1),1),'k', 'LineWidth',2)
legend('Rajada','Manobra','Envelope')
ax = gca;
ax.FontWeight='bold';
ax.FontSize=16
ax = gca;
title('Envelope MF_{N} x MF_{T}')
xlabel('MF_{N} [Nm]')
ylabel('MF_{T} [Nm]')
%% Vetor de posicoes bizarro
index=find(monitor(:,3)==1,1);
for i=1:index-1
    for k=1:30
        posi1(i,k)=pos(k);
    end
end
for i=index:length(monitor)
    for k=1:30
        posi2(i-index+1,k)=pos(k);
    end
end
%% Vy
figure
hold on
index=find(monitor(:,3)==1,1)
for sec=1:29
    scatter(posi1(:,sec),Vycheck(1:index-1,sec),'r','HandleVisibility','off');
    scatter(posi2(:,sec),Vycheck(index:length(monitor),sec),'g','HandleVisibility','off');
end
sec=30;
scatter(posi1(:,sec),Vycheck(1:index-1,sec),'r');
scatter(posi2(:,sec),Vycheck(index:length(monitor),sec),'g');
plot(pos,Vymax,'k', 'LineWidth',2)
plot(pos,Vymin,'b', 'LineWidth',2)
legend('Rajada','Manobra','Envelope Superior','Envelope Inferior')
ax = gca;
ax.FontWeight='bold';
ax.FontSize=16
ax = gca;
ylabel('V_{N} [N]')
xlabel('Semi Envergadura [m]')
title('Cortante Eixo N')
daspect([1 1 1])
axis normal
%% Vz
figure
hold on
index=find(monitor(:,3)==1,1)
for sec=1:29
    scatter(posi1(:,sec),Vzcheck(1:index-1,sec),'r','HandleVisibility','off');
    scatter(posi2(:,sec),Vzcheck(index:length(monitor),sec),'g','HandleVisibility','off');
end
sec=30;
scatter(posi1(:,sec),Vzcheck(1:index-1,sec),'r');
scatter(posi2(:,sec),Vzcheck(index:length(monitor),sec),'g');
plot(pos,Vzmax,'k', 'LineWidth',2)
plot(pos,Vzmin,'b', 'LineWidth',2)
legend('Rajada','Manobra','Envelope Superior','Envelope Inferior')
ax = gca;
ax.FontWeight='bold';
ax.FontSize=16
ax = gca;
ylabel('V_{T} [N]')
xlabel('Semi Envergadura [m]')
title('Cortante Eixo T')
daspect([1 1 1])
axis normal

%% Mz
figure
hold on
index=find(monitor(:,3)==1,1)
for sec=1:29
    scatter(posi1(:,sec),MFzcheck(1:index-1,sec),'r','HandleVisibility','off');
    scatter(posi2(:,sec),MFzcheck(index:length(monitor),sec),'g','HandleVisibility','off');
end
sec=30;
scatter(posi1(:,sec),MFzcheck(1:index-1,sec),'r');
scatter(posi2(:,sec),MFzcheck(index:length(monitor),sec),'g');
plot(pos,MFzmax,'k', 'LineWidth',2)
plot(pos,MFzmin,'b', 'LineWidth',2)
legend('Rajada','Manobra','Envelope Superior','Envelope Inferior')
ax = gca;
ax.FontWeight='bold';
ax.FontSize=16
ax = gca;
title('Momento Fletor Eixo N')
ylabel('MF_{N} [Nm]')
xlabel('Semi Envergadura [m]')
daspect([1 1 1])
axis normal
%% My
figure
hold on
index=find(monitor(:,3)==1,1)
for sec=1:29
    scatter(posi1(:,sec),MFycheck(1:index-1,sec),'r','HandleVisibility','off');
    scatter(posi2(:,sec),MFycheck(index:length(monitor),sec),'g','HandleVisibility','off');
end
sec=30;
scatter(posi1(:,sec),MFycheck(1:index-1,sec),'r');
scatter(posi2(:,sec),MFycheck(index:length(monitor),sec),'g');
plot(pos,MFymax,'k', 'LineWidth',2)
plot(pos,MFymin,'b', 'LineWidth',2)
legend('Rajada','Manobra','Envelope Superior','Envelope Inferior')
ax = gca;
ax.FontWeight='bold';
ax.FontSize=16
ax = gca;
title('Momento Fletor Eixo T')
ylabel('MF_{T} [Nm]')
xlabel('Semi Envergadura [m]')
daspect([1 1 1])
axis normal
%% Mt
figure
hold on
index=find(monitor(:,3)==1,1)
for sec=1:29
    scatter(posi1(:,sec),Mtcheck(1:index-1,sec),'r','HandleVisibility','off');
    scatter(posi2(:,sec),Mtcheck(index:length(monitor),sec),'g','HandleVisibility','off');
end
sec=30;
scatter(posi1(:,sec),Mtcheck(1:index-1,sec),'r');
scatter(posi2(:,sec),Mtcheck(index:length(monitor),sec),'g');
plot(pos,Mtmax,'k', 'LineWidth',2)
plot(pos,Mtmin,'b', 'LineWidth',2)
legend('Rajada','Manobra','Envelope Superior','Envelope Inferior')
ax = gca;
ax.FontWeight='bold';
ax.FontSize=16
ax = gca;
title('Momento Torsor')
ylabel('Mt [Nm]')
xlabel('Semi Envergadura [m]')
daspect([1 1 1])
axis normal

% kk
Kfinal=[K1;K2]
a=figure;
b=figure;
c=figure;
d=figure;
e=figure;
f=figure;
g=figure;
for i=1:length(Kfinal)
    condicaoTOW=monitor(Kfinal(i),1);
    condicaoVoo=monitor(Kfinal(i),2);
    condicaoRaj=monitor(Kfinal(i),3);
    if condicaoRaj==0
        stringTOW=num2str(Cargas(condicaoTOW).TOW);
        stringV=num2str(Cargas(condicaoTOW).CargasRajada.eh(condicaoVoo).V);
        stringN=num2str(Cargas(condicaoTOW).CargasRajada.eh(condicaoVoo).n);
        stringRaj='Rajada';
        carg(i).TOW=Cargas(condicaoTOW).TOW;
        carg(i).V=Cargas(condicaoTOW).CargasRajada.eh(condicaoVoo).V;
        carg(i).n=Cargas(condicaoTOW).CargasRajada.eh(condicaoVoo).n;
        carg(i).caso=stringRaj;
        carg(i).cargas=Cargas(condicaoTOW).CargasRajada.eh(condicaoVoo).Cargas;
        string= ['Caso ' num2str(i)];
    else
        stringTOW=num2str(Cargas(condicaoTOW).TOW);
        stringV=num2str(Cargas(condicaoTOW).CargasTrim.eh(condicaoVoo).V);
        stringN=num2str(Cargas(condicaoTOW).CargasTrim.eh(condicaoVoo).n);
        stringRaj='Manobra';
        carg(i).TOW=Cargas(condicaoTOW).TOW;
        carg(i).V=Cargas(condicaoTOW).CargasTrim.eh(condicaoVoo).V;
        carg(i).n=Cargas(condicaoTOW).CargasTrim.eh(condicaoVoo).n;
        carg(i).caso=stringRaj;
        carg(i).cargas=Cargas(condicaoTOW).CargasTrim.eh(condicaoVoo).Cargas;
        string= ['Caso ' num2str(i)];
    end
    %%Qn
    figure(a)
    hold on
    plot(carg(i).cargas.pos,carg(i).cargas.qn,'LineWidth',2,'DisplayName', string)
    ax = gca;
    ax.FontWeight='bold';
    ax.FontSize=32
    ax = gca;
    title('Carregamento Eixo N')
    ylabel('Q_{N} [N/m]')
    xlabel('Semi Envergadura [m]')
    xlim([0,0.36]);
    daspect([1 1 1])
    axis normal
    %%Qt
    figure(b)
    hold on
    plot(carg(i).cargas.pos,carg(i).cargas.qt,'LineWidth',2,'DisplayName', string)
    ax = gca;
    ax.FontWeight='bold';
    ax.FontSize=32
    ax = gca;
    title('Carregamento Eixo T')
    ylabel('Q_{T} [N/m]')
    xlabel('Semi Envergadura [m]')
    xlim([0,0.36]);
    daspect([1 1 1])
    axis normal
    %%Vn
    figure(c)
    hold on
    plot(carg(i).cargas.pos,carg(i).cargas.Vy,'LineWidth',2,'DisplayName', string)
    ax = gca;
    ax.FontWeight='bold';
    ax.FontSize=32
    ax = gca;
    title('Cortante Eixo N')
    ylabel('V_{N} [N]')
    xlabel('Semi Envergadura [m]')
    xlim([0,0.36]);
    daspect([1 1 1])
    axis normal
    %%Vt
    figure(d)
    hold on
    plot(carg(i).cargas.pos,carg(i).cargas.Vz,'LineWidth',2,'DisplayName', string)
    ax = gca;
    ax.FontWeight='bold';
    ax.FontSize=32
    ax = gca;
    title('Cortante Eixo T')
    ylabel('V_{T} [N]')
    xlabel('Semi Envergadura [m]')
    xlim([0,0.36]);
    daspect([1 1 1])
    axis normal
    %%Mn
    figure(e)
    hold on
    plot(carg(i).cargas.pos,carg(i).cargas.MFz,'LineWidth',2,'DisplayName', string)
    ax = gca;
    ax.FontWeight='bold';
    ax.FontSize=32
    ax = gca;
    title('Momento Fletor Eixo N')
    ylabel('MF_{N} [Nm]')
    xlabel('Semi Envergadura [m]')
    xlim([0,0.36]);
    daspect([1 1 1])
    axis normal
    %%Mt
    figure(f)
    hold on
    plot(carg(i).cargas.pos,carg(i).cargas.MFy,'LineWidth',2,'DisplayName', string)
    ax = gca;
    ax.FontWeight='bold';
    ax.FontSize=32
    ax = gca;
    title('Momento Fletor Eixo T')
    ylabel('MF_{T} [Nm]')
    xlabel('Semi Envergadura [m]')
    xlim([0,0.36]);
    daspect([1 1 1])
    axis normal
    %%torsor
    figure(g)
    hold on
    plot(carg(i).cargas.pos,carg(i).cargas.Mt,'LineWidth',2,'DisplayName', string)
    ax = gca;
    ax.FontWeight='bold';
    ax.FontSize=32
    ax = gca;
    title('Momento Torsor')
    ylabel('Mt [Nm]')
    xlabel('Semi Envergadura [m]')
    xlim([0,0.36]);
    daspect([1 1 1])
    axis normal
    
    figure(a)
    lgd=legend('-DynamicLegend')
    lgd.FontSize = 17;
    figure(b)
    lgd=legend('-DynamicLegend')
    lgd.FontSize = 17;
    figure(c)
    lgd=legend('-DynamicLegend')
    lgd.FontSize = 17;
    figure(d)
    lgd=legend('-DynamicLegend')
    lgd.FontSize = 17;
    figure(e)
    lgd=legend('-DynamicLegend')
    lgd.FontSize = 17;
    figure(f)
    lgd=legend('-DynamicLegend')
    lgd.FontSize = 17;
    figure(g)
    lgd=legend('-DynamicLegend')
    lgd.FontSize = 17;
    
end


