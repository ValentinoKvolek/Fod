program ejer16_prac2;

type

    maestro = record
        fecha = integer;
        codeSemanario:integer;
        descripcion:string;
        precio:real;
        totalEjem:integer;
        totalEjemVendidos:integer;
    end;

    detalle = record    
        
        fecha:integer;
        codeSemanario:integer;
        cantEjemVendidos:integer;
    end;

    fileMaestro = file of maestro 