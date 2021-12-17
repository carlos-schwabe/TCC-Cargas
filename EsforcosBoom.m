for i=1:15
    pos(i,1)=Massas{2,2}(i).Posicao/1000;
    Lift(i,1)=-1.5*Massas{2,2}(i).Massa*n/1000;
end
Lift(16,1)=Fprof*1.5-1.5*Massas{2,2}(16).Massa*n/1000;
pos(16,1)=Massas{2,2}(16).Posicao/1000;
%% Esforços Solicitantes
Vy(16,1)=Lift(16);
MFz(16,1)=0;
for i=1:15
    Vy(16-i,1)=Lift(16-i)+Vy(16-i+1);
    MFz(16-i,1)=MFz(16-i+1)+Vy(16-i+1)*(pos(16-i+1)-pos(16-i))+Lift(16-i)*(pos(16-i+1)-pos(16-i))/2;
end
outboom.Vy=Vy;
outboom.MFz=MFz;
outboom.pos=pos;

clear Vy Vz Mt MFz MFy i qt qn Ct Cn pos Selem Lift Drag Cm
