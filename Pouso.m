%% Forcas por secao na asa Eixos tangenciais
for i=1:29
    pos(i,1)=polarasa(i,1);
    Lift(i,1)=1.5*(-Massas{1,2}(i).Massa*n);
    Cn(i,1)=Lift(i);
end
i=30;
pos(i,1)=polarasa(i,1);
Lift(i,1)=1.5*(-Massas{1,2}(i).Massa*n);
Cn(i,1)=Lift(i);
%% Esforços Solicitantes
i=30;
Vy(i,1)=Cn(i);
MFz(i,1)=Cn(i)*(pos(i)-pos(i-1))/2;
i=0;
for i=1:29
    Vy(30-i,1)=Cn(30-i)+Vy(30-i+1);
    MFz(30-i,1)=MFz(30-i+1)+Vy(30-i+1)*(pos(30-i+1)-pos(30-i))+Cn(30-i)*(pos(30-i+1)-pos(30-i))/2;
end

outasa.Vy=Vy;
outasa.MFz=MFz;
outasa.pos=pos;



