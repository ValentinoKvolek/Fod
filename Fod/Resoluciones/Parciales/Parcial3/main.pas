program parcial3;

type

    profesional = record;
        dni:integer;
        nombre:string[30];
        apellido:string[30];
        sueldo:real;
    end;

    fileProfesionales = file of profesional;


procedure crear(var arch:fileProfesionales; var info:TEXT);
var
    p:profesional;
begin
    reset(info);

    rewrite(arch);
    //creo la cabecera.
    p.dni:=0;
    p.nombre:='';
    p.apellido:='';
    p.saldo:=0.0;
    write(arch, p);
    //creo la cabecera.

    while (not eof(info)) do begin
        read( info , p.dni, p.sueldo , p.nombre, p.apellido);
        write(arch, p);
    end;
end;

procedure agregar(var arch:fileProfesionales; p:profesional);
var 
    aux:profesional;
    ultBaja:integer;
begin

    reset(arch);
    read(arch, aux);

    if(aux.dni <> 0) then begin

        ultBaja:= aux.dni;
        seek(arch, ultBaja);
        read(arch, aux);
        ultBaja:=aux.dni;
        seek(arch, filepos(arch)-1);
        write(arch, p);

        seek(arch, 0);
        write(arch, aux);

    end;
    else
    begin
        seek(arch, filesize(arch)-1);
        write(arch, aux);
    end;
    close(arch);
end;

procedure eliminar(var arch:fileProfesionales; dni:integer; var BAJAS:TEXT);
var
    p:profesional;
    encontre:boolean;
    ultBaja:integer;
    posActual:integer;
begin

    encontre:=false;
    reset(arch);
    reset(BAJAS);

    // leer cabecera
    read(arch, p);
    ultBaja := p.dni

    while(not eof(arch)) and (not encontre) do begin
        posActual := FilePos(arch);
        read(arch, p);
        if(p.dni = dni) then
            encontre:=true;

    end;
    if(encontre) then begin

        writeln(BAJAS, p.dni, ' ',  p.sueldo:0:2 , ' ', p.nombre, ' ', p.apellido);

        seek(arch, posActual);
        p.dni:=ultBaja;
        write(arch,p);
        
        seek(arch, 0);
        p.dni:=posActual * -1;
        write(arch, p);

    end;
    else begin
        writeln('la persona no existe en el archivo');
    end;

    close(arch);
    close(BAJAS);
end;
