program ejer15_prac2;

type
     
     maestro = record
        codeProv: integer;
        nombreProv:string;
        codeLocalidad:integer;
        nombreLocalidad:string;
        viviendasSinLuz:integer;
        viviendasSinGas:integer;
        viviendasSinChapa:integer;
        viviendasSinAgua:integer;
        viviendasSinSanitario:integer;
    end;

    detalle = record
        codeProv:integer;
        codeLocalidad:integer;
        viviendasConLuz:integer;
        viviendasConGas:integer;
        viviendasConstruidas:integer;
        viviendasConAgua:integer;
        entregaSanitario:integer;
    end;

    fileMaestro = file of maestro;
    fileDetalle = file of detalle;
    
    arrayDetalles = array [1.. 10] of fileDetalle;
    arrayRegs = array[1..10] of detalle;

    
