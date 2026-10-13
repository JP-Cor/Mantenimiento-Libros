[README_Mantenimiento_Libros_CORREGIDO.md](https://github.com/user-attachments/files/33409883/README_Mantenimiento_Libros_CORREGIDO.md)
# Mantenimiento de Libros

**Asignación #1 – Programación de Computadores V (IN3054)**  
**Fecha de entrega:** 13 de octubre de 2026  
**Tecnologías:** ASP.NET Web Forms, C#, ADO.NET y Microsoft SQL Server

Aplicación web académica para administrar los libros de una biblioteca. Permite registrar, consultar, buscar, actualizar y eliminar libros, con separación entre la base de datos, el modelo, el repositorio y la interfaz.

## 1. Tecnologías utilizadas

- Visual Studio 2026
- ASP.NET Web Forms
- .NET Framework 4.7.2
- C#
- ADO.NET
- Microsoft SQL Server
- HTML y CSS
- Git y GitHub

## 2. Funcionalidades

La aplicación está diseñada para permitir:

- Registrar libros.
- Consultar el listado completo de libros.
- Buscar libros por coincidencia parcial del título.
- Buscar libros por ISBN.
- Cargar un registro en el formulario para editarlo.
- Actualizar la información de un libro existente.
- Eliminar libros después de solicitar confirmación.
- Mostrar mensajes informativos al usuario.
- Registrar automáticamente la fecha de adición.
- Guardar la fecha y el usuario que realizó la última modificación.
- Mostrar los registros en un `GridView` con columnas definidas manualmente.
- Usar estilos CSS externos y permitir el desplazamiento horizontal del listado en pantallas estrechas.

## 3. Estructura del proyecto

La solución y el proyecto de Visual Studio están dentro de `BibliotecaWeb`. El script SQL se ubica dentro de la carpeta `BaseDatos`; no se debe indicar una copia en la raíz a menos que se agregue realmente allí.

```text
Mantenimiento-Libros/
├── .gitignore
├── README.md
└── BibliotecaWeb/
    ├── BibliotecaWeb.slnx
    ├── BibliotecaWeb.csproj
    ├── Web.config
    ├── packages.config
    ├── BaseDatos/
    │   └── Biblioteca.sql
    ├── Modelos/
    │   └── Libro.cs
    ├── Repositorios/
    │   └── LibroRepositorio.cs
    ├── Vistas/
    │   ├── MantenimientoLibros.aspx
    │   ├── MantenimientoLibros.aspx.cs
    │   └── MantenimientoLibros.aspx.designer.cs
    ├── Content/
    │   └── EstilosBiblioteca.css
    └── ... archivos adicionales del proyecto Web Forms
```

Los archivos `BibliotecaWeb.slnx` y `BibliotecaWeb.csproj` deben permanecer juntos dentro de `BibliotecaWeb`, ya que la solución referencia el proyecto mediante la ruta relativa `BibliotecaWeb.csproj`.

## 4. Base de datos

- **Base de datos:** `Biblioteca`
- **Tabla principal:** `dbo.Libros`

### Columnas de `Libros`

- `IdLibro`: identificador autoincremental y clave primaria.
- `Titulo`: título del libro.
- `Autor`: autor del libro.
- `ISBN`: identificador ISBN del libro.
- `Editorial`: editorial (opcional).
- `AnioPublicacion`: año de publicación.
- `Categoria`: categoría (opcional).
- `CantidadDisponible`: unidades disponibles.
- `FechaAdicion`: fecha y hora del registro.
- `UsuarioAgrego`: usuario que registró el libro.
- `FechaModificacion`: fecha y hora de la última modificación, cuando corresponda.
- `UsuarioModifico`: usuario que modificó el registro, cuando corresponda.

### Procedimientos almacenados

1. `sp_CrearLibro`
2. `sp_ConsultarLibros`
3. `sp_ConsultarLibroPorId`
4. `sp_BuscarLibrosPorTitulo`
5. `sp_BuscarLibroPorISBN`
6. `sp_ActualizarLibro`
7. `sp_EliminarLibro`

El repositorio debe llamar estos procedimientos mediante ADO.NET. La cadena de conexión se obtiene de `Web.config`, no se repite en cada método.

## 5. Instalación y ejecución

### Paso 1. Obtener el proyecto

Clonar o descargar el repositorio:

<https://github.com/JP-Cor/Mantenimiento-Libros>

### Paso 2. Crear la base de datos

1. Abrir SQL Server Management Studio (SSMS).
2. Conectarse a la instancia de SQL Server que se utilizará.
3. Abrir el archivo `BibliotecaWeb/BaseDatos/Biblioteca.sql` desde la carpeta raíz del repositorio.
4. Revisar que se esté trabajando en una instalación nueva y ejecutar el script.
5. Confirmar que se crearon la base de datos `Biblioteca`, la tabla `dbo.Libros` y los siete procedimientos almacenados.

**Advertencia:** el script crea la tabla y los procedimientos sin comprobar si ya existen. No volver a ejecutarlo sobre una base de datos que ya tenga esos objetos, porque puede producir errores. Si se necesita reiniciar la base de datos, primero haga un respaldo y proceda únicamente si puede eliminar los datos existentes.

### Paso 3. Configurar la conexión

Abrir `BibliotecaWeb/Web.config` y localizar la cadena denominada `BibliotecaConexion`. Adaptar `Data Source` al nombre real de la instancia local de SQL Server. Por ejemplo:

```xml
<connectionStrings>
  <add name="BibliotecaConexion"
       connectionString="Data Source=SERVIDOR\INSTANCIA;Initial Catalog=Biblioteca;Integrated Security=True;TrustServerCertificate=True;"
       providerName="System.Data.SqlClient" />
</connectionStrings>
```

El bloque es un ejemplo de referencia. Si ya existe una sección `<connectionStrings>` en `Web.config`, se debe editar la entrada correspondiente y no crear una sección duplicada.

### Paso 4. Abrir y ejecutar la aplicación

1. Abrir `BibliotecaWeb/BibliotecaWeb.slnx` en Visual Studio.
2. Verificar que el proyecto `BibliotecaWeb.csproj` esté cargado.
3. Restaurar los paquetes NuGet si Visual Studio lo solicita.
4. Confirmar que el proyecto compile sin errores.
5. Seleccionar `Vistas/MantenimientoLibros.aspx` como página de inicio, si Visual Studio no la abre directamente.
6. Ejecutar con IIS Express.

## 6. Separación de responsabilidades

- **Base de datos —** `BaseDatos/Biblioteca.sql`: define la base de datos, la tabla, sus restricciones y los procedimientos almacenados.
- **Modelo —** `Modelos/Libro.cs`: representa los datos de un libro y sus campos de auditoría.
- **Repositorio —** `Repositorios/LibroRepositorio.cs`: realiza el acceso a SQL Server mediante ADO.NET y procedimientos almacenados.
- **Vista —** `Vistas/MantenimientoLibros.aspx`: contiene el formulario, la búsqueda y el `GridView`.
- **Código detrás —** `Vistas/MantenimientoLibros.aspx.cs`: responde a los eventos de la interfaz y llama al repositorio.
- **Diseñador Web Forms —** `Vistas/MantenimientoLibros.aspx.designer.cs`: declara los controles de la página para utilizarlos desde C#.
- **Estilos —** `Content/EstilosBiblioteca.css`: contiene los estilos externos.
- **Configuración —** `Web.config`: contiene la cadena de conexión y la configuración de la aplicación.

## 7. Validaciones

La aplicación debe comprobar los campos obligatorios y validar el ISBN, el año de publicación y la cantidad disponible tanto desde el servidor como mediante los controles de validación de ASP.NET Web Forms.

Antes de entregar, comprobar que la vista incluya validadores para título, autor, ISBN, año, cantidad y usuario responsable; que los validadores pertenezcan al grupo `GuardarLibro`; y que el código detrás compruebe `Page.IsValid` antes de invocar el repositorio. También se debe probar que los botones de búsqueda, edición, limpieza y eliminación no disparen accidentalmente las validaciones de guardado.

## 8. Estado de la entrega

### Verificaciones reportadas por el equipo

- [x] Instalación probada en otra computadora.
- [x] Diseño adaptable probado.
- [x] Acceso de la profesora al repositorio reportado como comprobado.

### Acciones que deben cerrarse antes de entregar

- [X] Integrar y subir los últimos cambios de validadores ASP.NET si todavía no aparecen en la versión compartida.
- [X] Compilar de nuevo después de integrar los cambios.
- [X] Probar campos vacíos, ISBN inválido, año fuera del rango y cantidad negativa.
- [X] Confirmar que los cambios locales estén publicados en GitHub.
- [X] Guardar evidencias de commits, `push` y participación de cada integrante.
- [X] Ajustar la visibilidad del repositorio a **privado**, como exige la asignación, y volver a confirmar el acceso de la profesora.

**Nota importante sobre GitHub:** al revisar el repositorio enlazado el 13 de octubre de 2026, GitHub lo mostraba como **público**. Por eso, aunque el equipo reporte que el acceso de la profesora se verificó, la visibilidad todavía debe cambiarse a privada para cumplir el requisito de la asignación.

## 9. Trabajo colaborativo

El grupo debe estar compuesto por un máximo de tres integrantes. Se recomienda que cada integrante contribuya mediante commits descriptivos y que se conserven evidencias de los cambios enviados al repositorio remoto.

La profesora debe tener acceso al repositorio privado mediante el usuario de GitHub `Thatyana1997`. La invitación y el acceso deben verificarse después de cambiar la visibilidad del repositorio.

## 10. Repositorio

<https://github.com/JP-Cor/Mantenimiento-Libros>

Descripción sugerida para GitHub:

> Mantenimiento de libros desarrollado con ASP.NET Web Forms, C#, ADO.NET y SQL Server para la asignación #1 de Programación de Computadores V (IN3054).
