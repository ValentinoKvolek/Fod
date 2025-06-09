program main;

const VALOR_ALTO = 999;

    maestro = record
        codeMunicipio: integer;
        nombreMunicipio:String;
        cantCasosPositivos:integer;
    end;
    //ordenado por code de municipio.

    detalle = record
        codeMunicipio:integer;
        cantCasosPositivos:integer;
    end;
    //ordenado por codigo de municipio;

    fileMaestro = file of maestro;
    fileDetalle = file of detalle;

    vectorDetalles = array [1.. 30] of fileDetalle;
    vectorRegistro = array [1.. 30] of detalle;

procedure leer(var arch:fileDetalle; var dato:detalle);
begin
    if not eof(arch) then
        read(arch, dato);
    else
        dato.codeMunicipio:= VALOR_ALTO;

end;

procedure minimo(var vd:vectorDetalles; var vr:vectorRegistro; var min:detalle);
var
 i, pos:integer;
begin
    pos:=-1;
    min.codeMunicipio:=VALOR_ALTO;
    for (i:= 1 to 30) do begin
        if(vr[i].codeMunicipio < min.codeMunicipio) then begin
            min:=vr[i];
            pos:=i;
        end;
    end;

    leer(vd[pos], vr[pos]);
end;


procedure update(var mae:fileMaestro; var vd:vectorDetalles);
var
    i:integer;
    vr:vectorRegistro
    regm:maestro;
    min:detalle;
begin

    for(i:=1 to 30 ) do begin
        reset(vd[i]);
        read(vd[i], vr[i]);
    end;

    reset(mae);

    minimo(vd,vr, min);
    
    while not eof(mae) and (min.codeMunicipio <> VALOR_ALTO)  then begin

        read(mae, regm);

        while(regm.codeMunicipio <> min.codeMunicipio) then 
            read(mae, regm);
        
        while(regm.codeMunicipio = min.codeMunicipio) do begin
            regm.cantCasosPositivos:= regm.cantCasosPositivos + min.cantCasosPositivos;
            minimo(vd,vr, min);
        end;

        seek(mae, filepos(mae)-1);
        
        if(regm.cantCasosPositivos > 15) then 
            writeln(regm.nombreMunicipio, regm.codeMunicipio);

        write(mae, regm);

    end;

    close(mae);

    for (i:=1 to 30) do 
        close(vd[i]);
end;

var
    vd:vectorDetalles;
    maestro:fileMaestro;
    i:integer;
    input:String
begin

    writeln('ingrese la ruta del archivo maestro');
    readln(input);
    assign(maestro, input);

    for (i:=1 to 30) do begin
        writeln('ingrese la ruta del archivo detalle');
        readln(input);
        assign(vd[i], input);
    end;

    update(maestro, vd);

end;


