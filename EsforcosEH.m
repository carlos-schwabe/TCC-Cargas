for i=1:29
    pos(i,1)=polareh(i,1);
    Selem(i,1)=(polareh(i+1,1)-polareh(i,1))*(cmah);
    Lift(i,1)=1.5*(0.5*rho*V^2*Selem(i)*polareh(i,2));
    Drag(i,1)=1.5*(0.5*rho*V^2*Selem(i)*polareh(i,3));
    Cm(i,1)=1.5*(.5*rho*V^2*Selem(i)*cmah*polareh(i,4));
    Cn(i,1)=Lift(i)*cos(deg2rad(Alphah))+Drag(i)*sin(deg2rad(Alphah));
    Ct(i,1)=-Lift(i)*sin(deg2rad(Alphah))+Drag(i)*cos(deg2rad(Alphah));
    qn(i,1)=Cn(i)/(polareh(i+1,1)-polareh(i,1));
    qt(i,1)=Ct(i)/(polareh(i+1,1)-polareh(i,1));
end
i=30;
pos(i,1)=polareh(i,1);
Selem(i,1)=(bh/2-polareh(i,1))*cmah;
Lift(i,1)=1.5*(0.5*rho*V^2*Selem(i)*polareh(i,2));
Drag(i,1)=1.5*(0.5*rho*V^2*Selem(i)*polareh(i,3));
Cm(i,1)=1.5*(.5*rho*V^2*Selem(i)*cmah*polareh(i,4));
Cn(i,1)=Lift(i)*cos(deg2rad(Alphah))+Drag(i)*sin(deg2rad(Alphah));
Ct(i,1)=-Lift(i)*sin(deg2rad(Alphah))+Drag(i)*cos(deg2rad(Alphah));
qn(i,1)=Cn(i)/(bh/2-polareh(i,1));
qt(i,1)=Ct(i)/(bh/2-polareh(i,1));
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
outeh.qn=qn;
outeh.qt=qt;
outeh.Vy=Vy;
outeh.Vz=Vz;
outeh.Mt=Mt;
outeh.MFz=MFz;
outeh.MFy=MFy;
outeh.pos=pos;
FFFFPPPPP(l)=Fprof;
clear Vy Vz Mt MFz MFy i qt qn Ct Cn pos Selem Lift Drag Cm
