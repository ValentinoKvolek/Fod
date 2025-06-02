(* 
Considere que se tiene un archivo que contiene informacion de los prestmoas ortorgados por una empresa financiera que cuenta con varias sucursales.
    Por cada prestmaos se tiene la sigueinte informacion: numero de sucursal donde se otorgo., DNI del empleado que lo otorgo. numero de prestamo, fecha de orogracion y
    monto otorgado., cada prestamo otordao por la emprea se considera como una venta, ademas , se sabe que el archivo esta ordenado por los siguiente criterios.
    code sucursal, dni del empleado, fecha de otorgacion, (en ese orde)

    Se le solicita definir las estrucutras de datos necesarias y escribir el moduilo que reciba el archivo de datos y genere un informe  en un acrchivo de texto. con el 
    siguiente formato : 

*)

program parcial1;

const
  VALOR_ALTO = 999;

type
  prestamo = record
    codeSucursal: integer;
    dni: integer;
    numPrestamo: integer;
    fecha: integer;
    montoOtorgado: real;
  end;

  fileP = file of prestamo;

procedure Leer(var arch: fileP; var dato: prestamo);
begin
  if not eof(arch) then
    read(arch, dato)
  else
    dato.codeSucursal := VALOR_ALTO;
end;


procedure realizarInforme(var arch: fileP);
var
  p: prestamo;
  txt: Text;
  sucursalActual, dniActual, anioActual: integer;
  cantAnio, montoAnio: integer;
  cantDni: integer;
  montoDni: real;
  cantSucursal, totalVentas: integer;
  montoSucursal, montoTotal: real;
begin
  assign(txt, 'informe.txt');
  reset(arch);
  rewrite(txt);

  totalVentas := 0;
  montoTotal := 0.0;

  Leer(arch, p);

  while (p.codeSucursal <> VALOR_ALTO) do begin
    sucursalActual := p.codeSucursal;
    writeln(txt, 'Sucursal ', sucursalActual);
    cantSucursal := 0;
    montoSucursal := 0;

    while (p.codeSucursal = sucursalActual) do begin
      dniActual := p.dni;
      writeln(txt, '  Empleado, DNI ', dniActual);
      cantDni := 0;
      montoDni := 0;

      while (p.codeSucursal = sucursalActual) and (p.dni = dniActual) do begin
        anioActual := extraerAnio(p.fecha);
        cantAnio := 0;
        montoAnio := 0;

        while (p.codeSucursal = sucursalActual) and (p.dni = dniActual) and (extraerAnio(p.fecha) = anioActual) do begin
          cantAnio := cantAnio + 1;
          montoAnio := montoAnio + p.montoOtorgado;
          Leer(arch, p);
        end;

        writeln(txt, '    Año ', anioActual, ': Cantidad de ventas: ', cantAnio, '  Monto de ventas: ', montoAnio:0:2);
        cantDni := cantDni + cantAnio;
        montoDni := montoDni + montoAnio;
      end;

      writeln(txt, '  Totales -> Total ventas empleado: ', cantDni, '  Monto total empleado: ', montoDni:0:2);
      cantSucursal := cantSucursal + cantDni;
      montoSucursal := montoSucursal + montoDni;
    end;

    writeln(txt, 'Cantidad total de ventas sucursal: ', cantSucursal);
    writeln(txt, 'Monto total vendido por sucursal: ', montoSucursal:0:2);
    writeln(txt);

    totalVentas := totalVentas + cantSucursal;
    montoTotal := montoTotal + montoSucursal;
  end;

  writeln(txt, 'Cantidad de ventas de la empresa: ', totalVentas);
  writeln(txt, 'Monto total vendido por la empresa: ', montoTotal:0:2);

  close(txt);
  close(arch);
end;
