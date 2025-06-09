program parcial5;


type


    empleado = record
        numero:integer;
        nombre:String;
        apellido:String;
        dni:integer;
        fechaNacimiento:String;
        genero:String;
    end;
    //el num de empleado no puede repetirse.
    
    fileEmpleados = file of empleado;


procedure ExisteEmpleado(var arch:fileEmpleados; numEmpleado:integer; var pos:integer);
var
    reg:empleado;
    encontre :boolean;
begin
    encontre:=false;
    pos:=0;
    reset(arch);
    seek(arch, 1);
    read(arch, reg);
    while(not eof (arch)) and (not encontre) do begin

        if (reg.numero = numEmpleado) then begin
            pos:=filepos(arch)-1;
            encontre:=true;
        end;

        read(arch, reg);
    end;    
end;

procedure AltaEmpleado(var arch:fileEmpleados);
var

    reg, aux:empleado;
    pos:integer;
begin

    writeln('ingrese numero de empleado a agregar');
    readln(reg.numero);

    reset(arch);

    ExisteEmpleado(arch, reg.numero, pos);
    if(pos = 0) do begin

        writeln('ingrese nombre:');
        readln(reg.nombre);
        writeln('ingrese apellido:');
        readln(reg.apellido);
        writeln('ingrese dni:');
        readln(reg.dni);
        writeln('ingrese fecha Nacimiento: ');
        readln(reg.fechaNacimiento);
        writeln('ingresar genero');
        readln(reg.genero);

        read(arch, aux);
        if(aux.numero <> 0 ) then begin

            seek(arch, (aux.numero * -1));
            read(arch, aux);
            pos:=aux.numero;
            seek(arch, filepos(arch)-1);
            write(arch, reg);

            seek(arch, 0);
            aux.numero:= -pos;
            write(arch, aux);
        end;
        else begin
            seek(arch, filesize(arch));
            write(arch, reg);
        end;
    end;
    else begin
        writeln('ya existe pavo');
    end;
    close(arch);
end;

procedure BajaEmpleado(var arch : fileEmpleados);
var 
    ultBaja,pos:integer;
    reg, aux:empleado;
begin

    reset(arch);

    writeln('ingrese numero de empleado a agregar');
    readln(reg.numero);

    ExisteEmpleado(arch, reg.numero, pos);

    if(pos<>0) then begin

        read(arch, aux);
        ultBaja:=aux.numero;

        seek(arch, pos);
        read(arch, aux);
        aux.numero:=ultBaja;
        seek(arch, filepos(arch)-1);
        write(arch,aux);

        seek(arch, 0);
        read(arch, aux);
        aux.numero:= -pos;
        seek(arch, filepos(arch)-1);
        write(arch,aux);
    end;
    else
    begin
        writeln('no existe.')
    end;
    
end;







