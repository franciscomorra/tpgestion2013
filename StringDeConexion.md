# Intro #

Para usar la libreria de SQL Data del TP de 2008


# Detalles #

Add your content here.  Format your content with:
Primero tenemos que tener la carpeta Data que contiene al proyecto de conexion de base de datos. La copiamos dentro de nuestro proyecto.

Luego vamos al Visual Studio 2008, click derecho en la solucion, y agregar proyecto, elegimos existente.

Buscamos el proyecto en la carpeta Data, y lo seleccionamos. Nos deberia aparecer un nuevo proyecto Data en el cuadro de soluciones.

Una vez agregado, tenemos que linkearlo a nuestro proyecto. Para hacer eso, click derecho en nuestro proyecto, el formulario por ejemplo, y agregar referencia, solapa proyectos, y seleccionamos Data.

# Utlilizacion de la libreria #

Para usar la libreria, creamos un procedimiento en la base de datos, y le damos a ejecutar, un procedimiento puede o no recibir parametros, y devolver o no algun valor.

# Ejemplo QUERY SELECT #

Un llamado a un procedimiento que devuelve multiples valores, como un
```c

SELECT COLUMNA1, COLUMNA2,COLUMNADEFECHA,COLUMNA4,COLUMNABOOL FROM tabla WHERE columna1 = @Parametro1

var result = SqlDataAccess.ExecuteDataTableQuery(ConfigurationManager.ConnectionStrings["StringConexion"].ToString(),

"Nuestra base de datos.Nuestro procedimiento", SqlDataAccessArgs
.CreateWith("@Parametro1", valor del Parametro).Arguments);

var data = new BindingList<CLASE QUE TIENE LAS COLUMNAS>();
if (result != null && result.Rows != null)
{
foreach (DataRow row in result.Rows)
{
data.Add(
new CLASE QUE TIENE LAS COLUMNAS()
{
ATRIBUTO1DECLASE = int.Parse(row["COLUMNA1 [INT]"].ToString()),

ATRIBUTO2DECLASE = double.Parse(row["COLUMNA2 [numeric]"].ToString()),

ATRIBUTODEFECHA = Convert.ToDateTime(row["COLUMNADEFECHA [datetime]"]),

ATRIBUTOTEXTO = row["COLUMNA4 [nvarchar]"].ToString(),

ATRIBUTODEBOOL = Convert.ToBoolean(row["COLUMNABOOL  [bit]"])

}
);
}
}
return data;
}


```



# EJEMPLO DE PROCEDIMIENTO QUE DEVUELVE UN SOLO VALOR #
un insert que nos devuelva el id de la fila insertada por ejemplo
```c

var id = SqlDataAccess.ExecuteScalarQuery<TIPO DE DATOS QUE TIENE QUE DEVOLVER>ConfigurationManager.ConnectionStrings["StringConexion"].ToString(),
"Nuestradb.Procedimientos", SqlDataAccessArgs
.CreateWith("@Parametro1", valorParametro1)
.And("@parametro2", valorParametro2)
.Arguments);
MessageBox.Show(id ); //Saca un msg con el valor id



```
# EJEMPLO DE PROCEDIMIENTO QUE NO DEVUELVE NADA #
ejemplo un insert, o update

```c

SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["StringConexion"].ToString(),
"NuestraDB.PROCEDIMIENTO", SqlDataAccessArgs
.CreateWith("@Parametro1", valorParametro1)
.And("@Parametro2", valorParametro2)
.Arguments);

```