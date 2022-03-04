%% A.1.
% Calculul si analiza unui transformator de retea
U1=220;
U21=18;
I21=2;
U22=14;
U23=14;
I22=6;
I23=6;
% A.1.2. Etapele de calcul ale transformatorului 
% A.1.2.1 Puterea totala in secundar
S2=U21*I21+U22*I22+U23*I23 %[W]
P2=S2;

% A.1.2.2 Puterea de gabarit
ntr=[0.78 0.81 0.83 0.85 0.87 0.88 0.92 0.93 0.94 0.945 0.95];

if (P2>=1 && P2<=15)
    ntr=ntr(1);
    J=4; % densitatea de curent [A/mm^2]
end
if (P2>15 && P2<=25)
    ntr=ntr(2);
    J=3.8;
end
if (P2>25 && P2<=40)
    ntr=ntr(3);
    J=3.6;
end
if (P2>40 && P2<=60)
    ntr=ntr(4);
    J=3.2;
end
if (P2>60 && P2<=80)
    ntr=ntr(5);
end
if (P2>80 && P2<=150)
    ntr=ntr(6);
    J=2.4;
end
if (P2>150 && P2<=250)
    ntr=ntr(7);
    J=1.4;
end
if (P2>250 && P2<=400)
    ntr=ntr(8);    
    J=1.25;
end
if (P2>400 && P2<=600)
    ntr=ntr(9);
    J=1;
end
if (P2>600 && P2<=800)
    ntr=ntr(10);
end
if (P2>800 && P2<=1000)
    ntr=ntr(11);
    J=0.90;
end
Pg=(P2/2)*(1+(1/ntr)) %[W]

% A.1.2.3 Calculul aproximativ al sectiunii miezului de fier
% trebuie sa alegem constanta din fata radicalului intre 1.1 si 1.5
Sfe=1.3*sqrt(Pg*((1+ntr)/(J*ntr))) %[cm^2]

% A.1.2.4 Alegerea tipului tolei
% inductia admisa
B=1.1; %[T]

% latimea tolei calculata
l=sqrt(Sfe) %[cm]
h=l; % inaltimea tolei = cu latimea pentru ca inecracam sa realizam o sectiune patrata a miezului
if (l>=0.1 && l<=1.14)
    lstea=1;
end
if (l>1.14 && l<=1.44)
    lstea=1.28;
end
if (l>1.44 && l<=1.8)
    lstea=1.6;
end
if (l>1.8 && l<=2.25)
    lstea=2;
end
if (l>2.25 && l<=2.65)
    lstea=2.5; 
end
if (l>2.65 && l<=3)
    l=2.8;
end
if (l>3 && l<=3.4)
    lstea=3.2;
end
if (l>3.4 && l<=3.8)
    lstea=3.6;
end
if (l>3.8 && l<=4.5)
    lstea=4;
end
if (l>4.5 && l<=5.5)
    lstea=5;
end
if (l>=5.5)
    lstea=6;
end

b=Sfe/lstea % grosimea pachetului de tole
% grosimea reala (finala)
% pentru a tine cont de izolatia dintre tole, constanta din fata se alege intre 1.1 si 1.25
bstea=1.11*b %[cm]

% grosimea tolelor
g=0.035; %[cm]

N=b/g; % numarul de tole
Ntole=round(N)

% valoarea reala a sectiunii miezului
Sfestea=lstea*bstea %[cm^2]

% A.1.2.5 Lungimea spirei medii
lmed=8*(lstea/4)+2*lstea+2*bstea %[cm]
lmed=lmed/100; %[m]

% A.1.2.6 Calculul infasurarilor transformatorului
% pentru infasurarile secundare 
% aria sectiunii conductorului de cupru
Scu21=I21/J %[mm^2]
Scu22=I22/J
Scu23=I23/J

% diametrul spirelor
d21=sqrt(4*Scu21/pi) %[mm]
d22=sqrt(4*Scu22/pi)
d23=sqrt(4*Scu23/pi)

% pentru infasurarea primara
% curentul primar
I1=Pg/U1 %[A]
% aria sectiunii conductorului
Scu1=I1/J %[mm^2]
% diametrul spirei
d1=sqrt(4*Scu1/pi) %[mm]
% d21=1.65;
% d22=1.35;
% d23=d22;
% d1=0.92;
% diametre pentru înfã?urãrile secundare respectiv înfã?urarea primarã
d = [0.07 0.10 0.12 0.15 0.18 0.20 0.22 0.25 0.28 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1 1.2 1.4 1.5 1.6 1.8 2];
min1 = abs(d21-d(1))
for i = 2:30
    if (abs(d21-d(i))<min1)
        min1 = abs(d21-d(i));
        position = i;
    end
end
d21stea = d(position)
    
min1 = abs(d22-d(1));
for i = 2:30 
    if (abs(d22-d(i))<min1)
        min1 = abs(d22-d(i));
        position = i;
    end
end
d22stea = d(position)
     
min1 = abs(d23-d(1));
for i= 2:30 
    if (abs(d23-d(i))<min1)
        min1 = abs(d23-d(i));
        position = i;
    end
end
d23stea = d(position)
     
min1 = abs(d1-d(1));
for i= 2:30 
    if (abs(d1-d(i))<min1)
        min1 = abs(d1-d(i));
        position = i;
    end
end
d1stea = d(position)

% tensiunea electromotoare indusa intr o spira
f=50; %[Hz]
e=4.44*f*B*(0.9*Sfestea)*0.0001 %[V/spira]

% numarul de spire
% pentru infasurarea primara
w1=U1/e; %[spire]
w1=round(w1)
% pentru infasurarile secundare
w21=U21/e; %[spire]
w21=round(w21)
w22=U22/e;
w22=round(w22)
w23=w22;

% rezistenþele ohmice ale bobinajelor transformatorului
% pentru infsurarea primara
p=0.0172; % rezistivitatea nominala a cuprului[ohm*mm^2/m] 
R1=w1*p*(lmed/Scu1) %[ohm]
% pentru infasurarile secundare
R21=w21*p*(lmed/Scu21) %[ohm]
R22=w22*p*(lmed/Scu22)
R23=R22;

% rezistentele secundare "raportate" (totale)
R21stea=R21+R1*(w21/w1)^2 %[ohm]
R22stea = R22+R1*(w22/w1)^2
R23stea = R23+R1*(w23/w1)^2

% rezistente de sarcina "nominale"
Rs1n=U21/I21 %[ohm]
Rs2n=U22/I22
Rs3n=U23/I23;

% A.1.2.7 Recalcularea numarului de spire ale infasurarilor secundare 
e21=U21
e22=U22
e23=U23

e21stea=e21-R21stea*I21
e22stea=e22-R22stea*I22
e23stea=e23-R23stea*I23

w21stea=w21+(R21stea*I21/e); %[spire]
w22stea=w22+(R22stea*I22/e);
w23stea=w23+(R23stea*I23/e);
w21stea=round(w21stea)
w22stea=round(w22stea)
w23stea=round(w23stea)

%% A.1.3
% Calculul exepeditiv al transformatelor de mica putere folosind nomograme

% A.1.3.1 Puterea secundara 
P2=U21*I21+U22*I22+U23*I23 %[W]
P=(1/ntr)*P2 % puterea de gabarit [W]

% A.1.3.2 Calculul infasurarulor transformatorului
Sm=Sfe % sectiunea miezului de fier [cm^2]
N0=w1/U1; % numarul de spire pe volt pentru infsaurarea primara
N0=round(N0)
N021=w21/U21; % numarul de spire pe volt pentru infasurarile secundare
N022=w22/U22;
N023=w23/U23;
N021=round(N021)
N022=round(N022)
N023=round(N023)

