
function PP = fcn_Aumentar_P(PP,del,inc_ini,i)

e=5;
if i == 1
e = .000001;  
end

tam_PP = size(PP);
tam_Borrar = size(del);

DU = zeros(0);
for s = 1 : tam_Borrar(1)
    
DU(1+(3*(s-1)),1+(3*(s-1))) = e;
DU(2+(3*(s-1)),2+(3*(s-1))) = e;
DU(3+(3*(s-1)),3+(3*(s-1))) = e;   
    
end    

PP = [PP zeros(tam_PP(1),tam_Borrar(1)*3);zeros(tam_Borrar(1)*3,tam_PP(1)) DU];