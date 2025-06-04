(*

Suponga que se tiene un archivo con informacion referente a los productos que se 
comercializan en un supermercado, De cada producto se conoce el codigo de producto(Unico) , nombre del producto , descripcion, precio de compra. precio de venta
y ubicacion en deposito

Se solicita hacer el mantenimineto de este archivo utilizando la tecnica de reutilizacion de espacio llamada Lista invertida. 

Declare las estructuras de datos necesarias e implemente los siguientes modulos: 

Agregar Producto:  recibe el archivo sin abrir y solicita al usuario que ingrese los datos del producto y lo agrega al archivo solo si el codigo ingresado no existe. Suponga 
existe una funcion llamda existe producto que recibe el codigo y un archivo y devuelve verdadero si el codigo existe en el archivo o falso en caso contrario. la funcion 
no debe ser implementada. si el producto ya existe debe informarlo en pantalla.

Quitar producto que recibe el arch sin abrir y solicita al usuario que ingrese el codigo y lo elimina del arch solo  si existe. en caso de que el producto no exista debe 
informar en pantalla.

*)

program parcial2;

type

    producto = record
        codeProduc:  integer;
        nombreProduc : string;
        descripcion: string;
        precioCompra:real;
        precioVenta:real;
        ubicacion: string;
    end;

    fileP = file of producto;


procedure agregarProducto(var arch: fileP);

var

    p:producto;
    
    auxp:producto;

    posLibre:integer;

    posAux:integer;

begin

    reset(arch);

    writeln('ingrese el codigo del nuevo producto');
    readln(p.codeProduc);

    if( not (existeProducto(arch, p.codeProduc))) then begin

        writeln('ingrese el nombre del producto');
        readln(p.nombreProduc);
        writeln('ingrese la descripcion');
        readln(p.descripcion);
        writeln('ingrese precio de compra');
        readln(p.precioCompra);
        writeln('ingrese precio de venta');
        readln(p.precioVenta);
        writeln('ingrese ubicacion');
        readln(p.ubicacion);

        read(arch, auxp);

        if(auxp.codeProduc <> 0 ) then begin // esto quiere decir que hay un espacio libre.
            
            posLibre:= (auxp.codeProduc *  - 1); 

            seek(arch, posLibre);
            read(arch,auxp);
            posAux:= auxp.codeProduc; //guardo la anterior pos libre o puede ser 0 si no hay mas

            seek(arch, 0);
            read(arch, auxp);
            auxp.codeProduc:= posAux;
            seek(arch, 0);
            write(arch, auxp) // me guardo para que siga funcionando la lista invertida.

            seek(arch, posLibre);
            write(arch, p);  //voy a la pos libre y escribo.

        end
        else
            seek(arch, filesize(arch)-1);
            write(arch, p); 
        end;

    end
    else
    begin
        writeln('ya existe este producto.')
    end;

    close(arch);    
end;


procedure eliminar (var arch:fileP);
var
    code:integer;
    p:producto;

begin


    writeln('ingrese el code de producto que quiere eliminar');
    readln(code);

    if(existeProducto(arch, code)) then begin

        reset(arch);

        read(arch, p); //cabecera
        
        ultBaja:= p.codeProduc;

        while(code <> p.codeProduc ) do begin
            read(arch, p);
        end;
        
        seek(arch, FilePos(arch)-1;); //voy a pos donde quiero eliminar 

        p.codeProduc:= ultBaja; 
        ultBaja:= (FilePos(arch) * -1);
        writeln(arch, aux);

        seek(arch, 0);
        p.codeProduc:=ultBaja;
        write(arch, aux);

    end
    else
        writeln('el producto no existe.')
    end;

    close(arch);
    
end;


var 

    fp:fileP;

begin

    assign(fp, 'c/ruta/parcial/ejemplo');
    agregarProducto(fileP);
    
end;
