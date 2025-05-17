(*

2. Una mejora respecto a la solución propuesta en el ejercicio 1 sería mantener por un lado el archivo que contiene la información de los alumnos de la Facultad de Informática
(archivo de datos no ordenado) y por otro lado mantener un índice al archivo de datos que se estructura como un árbol B que ofrece acceso indizado por DNI de los alumnos. 

*)

//a. Defina en Pascal las estructuras de datos correspondientes para el archivo de alumnos y su índice.

program ejer2_prac4;

const M = //orden del arbol;

type

    alumno = record
        nombre:string[50];
        apellido:string[50];
        dni:integer;
        lengajo:integer;
        ano_ingreso:integer;
    end;

    TNodo = record

        cant_claves:integer;
        claves: array[1..M-1] of integer; //serian los dnis
        enlaces : array[1..M-1] of integer;   //si claves[1] = 12345678, entonces enlaces[1] tiene el número de registro en el archivo donde está el alumno con ese DNI.
                                              //No son hijos, son referencias al archivo de alumnos. 
        hijos: array[1..M] of integer; 

    end;

    TAarchivoAlumnos = file of alumno; //archivo desordenado de alumnos.
    arbolB = file of TNnodo;

    var

        archivoDatos: TAarchivoAlumnos;
        archivoIndice: arbolB;

//a

(*

b. Suponga que cada nodo del árbol B cuenta con un tamaño de 512 bytes.
¿Cuál sería el orden del árbol B (valor de M) que se emplea como índice? Asuma que los números enteros ocupan 4 bytes.
Para este inciso puede emplear una fórmula similar al punto 1b, 
pero considere además que en cada nodo se deben almacenar los M-1 enlaces a los registros correspondientes en el archivo de datos.

    el orden del arbol seria 64 ya que ahora a diferencia del ejer 1b , tenemos que solo ocupar 4 bytes en el tamaño de A que seria la referencia a ese enlace.
    en este caso como la referencia a el archivo alumnos es la clave que es un dni pasaria 4 bytes
    

c. ¿Qué implica que el orden del árbol B sea mayor que en el caso del ejercicio 1?
    Implica lo que ahora tenes dor archivos separados nos permite solo tomar una referencia unica (la clave) para referenciar a un registro alumnos en nuestro 
    archivo de datos alumno. en vez de gastar muchos mas bytes guardando un registro entero.

d. Describa con sus palabras el proceso para buscar el alumno con el DNI 12345678 usando el índice definido en este punto.


*) 


