# Mantenimiento de Libros

**Asignación #1 – Programación de Computadores V (IN3054)**

Sistema web desarrollado en **ASP.NET Web Forms, C#, ADO.NET y SQL Server** para administrar los libros de una biblioteca mediante operaciones de registro, consulta, búsqueda, actualización y eliminación.

## 1. Tecnologías utilizadas

- Visual Studio 2026
- ASP.NET Web Forms
- .NET Framework 4.7.2
- C#
- ADO.NET
- Microsoft SQL Server
- HTML y CSS
- Git y GitHub

## 2. Funcionalidades implementadas

El sistema permite:

- Registrar libros nuevos.
- Consultar todos los libros registrados.
- Buscar libros por título, incluyendo coincidencias parciales.
- Buscar libros por ISBN.
- Modificar la información de un libro existente.
- Eliminar libros con confirmación.
- Mostrar mensajes informativos sobre las operaciones.
- Registrar automáticamente la fecha de creación.
- Almacenar el usuario y la fecha de modificación.
- Seleccionar el tipo de búsqueda mediante una lista desplegable.
- Mostrar los registros mediante un GridView.
- Utilizar un diseño con estilos externos y ajustes para dispositivos móviles.

## 3. Estructura del proyecto

```text
Mantenimiento-Libros/
│
├── Biblioteca.sql
├── README.md
├── .gitignore
│
└── BibliotecaWeb/
    ├── BaseDatos/
    │   └── Biblioteca.sql
    │
    ├── Modelos/
    │   └── Libro.cs
    │
    ├── Repositorios/
    │   └── LibroRepositorio.cs
    │
    ├── Vistas/
    │   ├── MantenimientoLibros.aspx
    │   ├── MantenimientoLibros.aspx.cs
    │   └── MantenimientoLibros.aspx.designer.cs
    │
    ├── Content/
    │   └── EstilosBiblioteca.css
    │
    ├── Web.config
    └── BibliotecaWeb.slnx
```

*La ubicación del archivo de solución y la copia de `Biblioteca.sql` dentro de `BaseDatos` deben verificarse en el repositorio antes de la entrega.*

## 4. Base de datos

**Nombre:** `Biblioteca`

**Tabla principal:** `Libros`

### Campos

- `IdLibro`
- `Titulo`
- `Autor`
- `ISBN`
- `Editorial`
- `AnioPublicacion`
- `Categoria`
- `CantidadDisponible`
- `FechaAdicion`
- `UsuarioAgrego`
- `FechaModificacion`
- `UsuarioModifico`

### Procedimientos almacenados

1. `sp_CrearLibro`
2. `sp_ConsultarLibros`
3. `sp_ConsultarLibroPorId`
4. `sp_BuscarLibrosPorTitulo`
5. `sp_BuscarLibroPorISBN`
6. `sp_ActualizarLibro`
7. `sp_EliminarLibro`

El acceso a la base de datos se realiza mediante ADO.NET y procedimientos almacenados.

## 5. Instalación del proyecto

### Paso 1. Descargar el repositorio

Clonar o descargar el proyecto desde:

https://github.com/JP-Cor/Mantenimiento-Libros

### Paso 2. Crear la base de datos

1. Abrir SQL Server Management Studio.
2. Conectarse a una instancia de SQL Server.
3. Abrir `Biblioteca.sql`.
4. Ejecutar el script en una instalación nueva.

El script crea la base de datos `Biblioteca`, la tabla `Libros` y sus procedimientos almacenados.

**Advertencia:** no volver a ejecutar el script sobre una base de datos que ya tenga estos objetos creados.

### Paso 3. Configurar la conexión

Abrir `BibliotecaWeb/Web.config` y localizar la conexión denominada `BibliotecaConexion`.

Ejemplo:

```xml
<connectionStrings>
  <add name="BibliotecaConexion"
       connectionString="Data Source=SERVIDOR\INSTANCIA;Initial Catalog=Biblioteca;Integrated Security=True;TrustServerCertificate=True;"
       providerName="System.Data.SqlClient" />
</connectionStrings>
```

Sustituir `SERVIDOR\INSTANCIA` por el nombre de la instancia local de SQL Server.

### Paso 4. Ejecutar la aplicación

1. Abrir la solución `BibliotecaWeb.slnx` en Visual Studio.
2. Restaurar los paquetes NuGet si es necesario.
3. Compilar la solución.
4. Establecer `Vistas/MantenimientoLibros.aspx` como página de inicio.
5. Ejecutar mediante IIS Express.

## 6. Organización del código

**Modelo:** `Libro.cs` representa los datos de la entidad libro.

**Repositorio:** `LibroRepositorio.cs` administra la comunicación con SQL Server utilizando ADO.NET.

**Vista:** `MantenimientoLibros.aspx` contiene el formulario, la búsqueda y el listado.

**Código detrás:** `MantenimientoLibros.aspx.cs` administra los eventos y utiliza los métodos del repositorio.

**Estilos:** `EstilosBiblioteca.css` contiene la presentación visual.

## 7. Validaciones

El sistema incluye validaciones en C# para comprobar campos obligatorios, año de publicación, cantidad disponible e ISBN.

**Pendiente:** completar y probar los controles validadores propios de ASP.NET Web Forms para los campos obligatorios y numéricos.

## 8. Estado actual del proyecto

### Completado

- Base de datos y procedimientos almacenados.
- Modelo y repositorio.
- Operaciones CRUD.
- Búsqueda por título e ISBN.
- Lista desplegable para seleccionar la búsqueda.
- GridView con información de los libros.
- Estilos CSS y ajustes de diseño adaptable.
- Publicación inicial en GitHub.

### Pendiente de finalizar o verificar

- Completar validadores ASP.NET.
- Realizar pruebas finales de validación y diseño adaptable.
- Verificar la instalación en otra computadora.
- Confirmar los colaboradores y el acceso de la profesora en GitHub.
- Publicar los últimos cambios locales.
- Preparar evidencias de commits y participación de los integrantes.

## 9. Trabajo colaborativo

El proyecto se desarrolla en un grupo de máximo tres integrantes.

Se recomienda trabajar con ramas independientes, realizar commits descriptivos y utilizar pull requests para integrar cambios.

La profesora debe agregarse al repositorio privado mediante el usuario de GitHub `Thatyana1997`.



## 10. Repositorio

https://github.com/JP-Cor/Mantenimiento-Libros
