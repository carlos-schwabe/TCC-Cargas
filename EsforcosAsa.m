%% Forcas por secao na asa Eixos tangenciais
for i=1:29
    pos(i,1)=polarasa(i,1);
    Selem(i,1)=(polarasa(i+1,1)-polarasa(i,1))*(polarasa(i+1,2)+polarasa(i,2))/2;
    Lift(i,1)=1.5*(0.5*rho*V^2*Selem(i)*polarasa(i,3)-Massas{1,2}(i).Massa*n);
    Drag(i,1)=1.5*(0.5*rho*V^2*Selem(i)*polarasa(i,4));
    Cm(i,1)=1.5*(.5*rho*V^2*Selem(i)*polarasa(i,2)*polarasa(i,5));
    Cn(i,1)=Lift(i)*cos(deg2rad(Alphaw))+Drag(i)*sin(deg2rad(Alphaw));
    Ct(i,1)=-Lift(i)*sin(deg2rad(Alphaw))+Drag(i)*cos(deg2rad(Alphaw));
    qn(i,1)=Cn(i)/(polarasa(i+1,1)-polarasa(i,1));
    qt(i,1)=Ct(i)/(polarasa(i+1,1)-polarasa(i,1));
end
i=30;
pos(i,1)=polarasa(i,1);
Selem(i,1)=(bw/2-polarasa(i,1))*(ctipw+polarasa(i,2))/2;
Lift(i,1)=1.5*(0.5*rho*V^2*Selem(i)*polarasa(i,3)-Massas{1,2}(i).Massa*n);
Drag(i,1)=1.5*(0.5*rho*V^2*Selem(i)*polarasa(i,4));
Cm(i,1)=1.5*(.5*rho*V^2*Selem(i)*polarasa(i,2)*polarasa(i,5));
Cn(i,1)=Lift(i)*cos(deg2rad(Alphaw))+Drag(i)*sin(deg2rad(Alphaw));
Ct(i,1)=-Lift(i)*sin(deg2rad(Alphaw))+Drag(i)*cos(deg2rad(Alphaw));
qn(i,1)=Cn(i)/(bw/2-polarasa(i,1));
qt(i,1)=Ct(i)/(bw/2-polarasa(i,1));
%% Esforços Solicitantes
i=30;
Vy(i,1)=Cn(i);
Vz(i,1)=Ct(i);
Mt(i,1)=Cm(i);
MFz(i,1)=Cn(i)*(pos(i)-pos(i-1))/2;
MFy(i,1)=Ct(i)*(pos(i)-pos(i-1))/2;
i=0;
for i=1:29
    Vy(30-i,1)=Cn(30-i)+Vy(30-i+1);
    Vz(30-i,1)=Ct(30-i)+Vz(30-i+1);
    Mt(30-i,1)=Cm(30-i)+Mt(30-i+1);
    MFz(30-i,1)=MFz(30-i+1)+Vy(30-i+1)*(pos(30-i+1)-pos(30-i))+Cn(30-i)*(pos(30-i+1)-pos(30-i))/2;
    MFy(30-i,1)=MFy(30-i+1)+Vz(30-i+1)*(pos(30-i+1)-pos(30-i))+Ct(30-i)*(pos(30-i+1)-pos(30-i))/2;
end
outasa.qn=qn;
outasa.qt=qt;
outasa.Vy=Vy;
outasa.Vz=Vz;
outasa.Mt=Mt;
outasa.MFz=MFz;
outasa.MFy=MFy;
outasa.pos=pos;

clear Vy Vz Mt MFz MFy i qt qn Ct Cn pos Selem Lift Drag Cm


