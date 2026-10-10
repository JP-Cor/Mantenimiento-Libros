# Mantenimiento de Libros

Sistema web para el mantenimiento de libros de una biblioteca, desarrollado con ASP.NET Web Forms, C#, ADO.NET y SQL Server.

## Tecnologías utilizadas

- Visual Studio 2026
- ASP.NET Web Forms
- .NET Framework 4.7.2
- C#
- ADO.NET
- Microsoft SQL Server
- HTML y CSS
- Git y GitHub

## Funcionalidades

El sistema permite:

1. Registrar libros.
2. Consultar los libros disponibles.
3. Buscar libros por título o ISBN.
4. Modificar la información de los libros.
5. Eliminar libros.
6. Registrar el usuario y la fecha de creación o modificación.

## Estructura del proyecto

- `BibliotecaWeb/Modelos/Libro.cs`: modelo de datos.
- `BibliotecaWeb/Repositorios/LibroRepositorio.cs`: acceso a SQL Server mediante ADO.NET.
- `BibliotecaWeb/Vistas/Libros.aspx`: interfaz del sistema.
- `BibliotecaWeb/Vistas/Libros.aspx.cs`: lógica de la interfaz.
- `BibliotecaWeb/Content/EstilosBiblioteca.css`: estilos visuales.
- `Biblioteca.sql`: creación de la base de datos, tabla y procedimientos almacenados.

## Instalación

### 1. Descargar el proyecto

Clonar el repositorio o descargarlo desde GitHub.

### 2. Configurar la base de datos

Abrir SQL Server Management Studio y ejecutar `Biblioteca.sql` en una instancia de SQL Server compatible.

El script está diseñado para una instalación inicial y no debe ejecutarse sobre una base de datos que ya contenga los mismos objetos.

### 3. Configurar la conexión

Abrir `BibliotecaWeb/Web.config` y modificar el nombre del servidor en la cadena de conexión `BibliotecaConexion` para utilizar la instancia local de SQL Server.

La configuración suministrada utiliza autenticación integrada de Windows.

### 4. Ejecutar la aplicación

Abrir `BibliotecaWeb.slnx` en Visual Studio, restaurar los paquetes NuGet si es necesario y ejecutar `Vistas/Libros.aspx` mediante IIS Express.

## Procedimientos almacenados

- `sp_CrearLibro`
- `sp_ConsultarLibros`
- `sp_ConsultarLibroPorId`
- `sp_BuscarLibrosPorTitulo`
- `sp_BuscarLibroPorISBN`
- `sp_ActualizarLibro`
- `sp_EliminarLibro`

## Repositorio

https://github.com/JP-Cor/Mantenimiento-Libros

