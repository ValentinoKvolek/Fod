(*Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma fue
construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
tiempo_total_de_sesiones_abiertas.
Notas:
● Cada archivo detalle está ordenado por cod_usuario y fecha.
● Un usuario puede iniciar más de una sesión el mismo día en la misma máquina, o
inclusive, en diferentes máquinas.
● El archivo maestro debe crearse en la siguiente ubicación física: /var/log.*) 

program ejer5prac2

uses
    SysUtils;

const
    CANT_MAQUINAS = 5;
    VALOR_ALTO = 999;

type
    detalle = record
        cod_usuario: integer;
        fecha: string;
        tiempo_sesion: real;
    end;

    maestro = record
        cod_usuario: integer;
        fecha: string;
        tiempo_total_de_sesiones_abiertas: real;
    end;

    fileMaestro = file of maestro;
    fileDetalle = file of detalle;
    detalles = array[1..CANT_MAQUINAS] of fileDetalle;
    regDetalles = array[1..CANT_MAQUINAS] of detalle;

procedure leer(var arch: fileDetalle; var dato: detalle);
begin
    if not eof(arch) then
        read(arch, dato)
    else
        dato.cod_usuario := VALOR_ALTO; 
end;

procedure minimo(var dets: detalles; var regs: regDetalles; var min: detalle);
var
    i, posMin: integer;
begin
    min.cod_usuario := VALOR_ALTO;  
    posMin := 1;
    for i := 1 to CANT_MAQUINAS do begin  
        if (regs[i].cod_usuario < min.cod_usuario) or 
           ((regs[i].cod_usuario = min.cod_usuario) and (regs[i].fecha < min.fecha)) then begin
            min := regs[i];
            posMin := i;
        end;
    end;
    leer(dets[posMin], regs[posMin]);
end;

procedure CrearMaestro(var vd: detalles);
var
    i: integer;
    vrd: regDetalles;
    mae: fileMaestro;
    regm: maestro;
    min: detalle;
    actual_cod: integer;
    actual_fecha: string;
    total: real;  
begin
    assign(mae, '/var/log/maestro');  
    rewrite(mae);  
    for i := 1 to CANT_MAQUINAS do begin
        assign(vd[i], 'detalle' + IntToStr(i));  
        reset(vd[i]);  
        leer(vd[i], vrd[i]); 
    end;

    minimo(vd, vrd, min);
    while min.cod_usuario <> VALOR_ALTO do begin
        actual_cod := min.cod_usuario;
        actual_fecha := min.fecha;
        total := 0;
        while (min.cod_usuario = actual_cod) and (min.fecha = actual_fecha) do begin
            total := total + min.tiempo_sesion;
            minimo(vd, vrd, min);
        end;
        regm.cod_usuario := actual_cod;
        regm.fecha := actual_fecha;
        regm.tiempo_total_de_sesiones_abiertas := total;
        write(mae, regm);
    end;

    close(mae);  
    for i := 1 to CANT_MAQUINAS do
        close(vd[i]);  
end;

var
    vd: detalles;

begin
    CrearMaestro(vd);
end.