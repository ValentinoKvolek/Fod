program   ejer2_prac2;
const 
    valorAlto  = 'ZZZZ';
type

    producto = record
        codeP:integer;
        nombreComercial:string;
        precioVenta:real;
        stockActual:integer;
        stockMin:integer;
    end;

    venta = record
        codeP:integer;
        cantVendida:integer;
    end;

    // ambos archivos estan ordenados por codigo de producto.

    fileProductos = file of producto;
    fileVentas = file of fileVentas;


procedure leer(var arch : fileVentas; dato:venta);
begin
    if(not eof(arch))then 
        read(arch,dato);
    else
        dato.code:= valorAlto;
end;


procedure incisoB(var mae:fileProductos);
var

    txtFile: text;
    regm: producto;
    aux:string;

begin

    assign(txtFile, 'stock_minimo.txt');
    rewrite(txtFile);

    reset(mae);

    while not eof(mae) do begin

        read(mae, regm);
        if(regm.stockActual < regm.stockMin) then 
            writeln(txtFile, regm.codeP,'  ',regm.precioVenta:0:2,' ', regm.stockActual,' ', regm.stockMin,' ', regm.nombreComercial);

    end;

end;



var
    regd : producto;
    regm :venta;

    mae : fileProductos;
    det: fileVentas;

    total:integer;
    aux:string;

begin

    assign(mae, 'maestroProductos');
    assign(det, 'detalleVentas');

    reset(mae);
    reset(det);

    // A) Actualizar el Maestro.
    leer(det, regd);

    while (regd.code <> valorAlto) do begin

        aux:= regd.code; // el auxiliar lo uso para comparar
        total:=0;

        while(aux = regd.code) do begin
            total:= total + regd.cantVendida; 
            leer(det,regd); 
        end; 

        while(regm.code <> aux ) do 
            read(mae, regm); //mientras no encuentre el producto que vendi, itero.

        //cuando lo encuentro modifico: 
        regm.stockActual:= regm.stockActual - total;
        seek(mae,filepos(mae)-1) // me posiciono en donde lo encontre.
        write(mae, regm);  

        if(not(eof(mae))) then
            read(mae, regm); // sigo leyendo por que el archivo maestro puede ser actualizado 1 0 mas veces por el detalle.
          
    end;
    close(mae);
    close(det);

    incisoB(mae);


end.

