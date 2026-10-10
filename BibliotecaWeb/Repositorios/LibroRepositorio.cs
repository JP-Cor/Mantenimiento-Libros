
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using BibliotecaWeb.Modelos;

namespace BibliotecaWeb.Repositorios
{
    public class LibroRepositorio
    {
        private readonly string conexion =
            ConfigurationManager.ConnectionStrings[
                "BibliotecaConexion"].ConnectionString;

        // Consultar todos los libros
        public List<Libro> ObtenerLibros()
        {
            List<Libro> libros = new List<Libro>();

            using (SqlConnection cn =
                new SqlConnection(conexion))
            {
                using (SqlCommand cmd =
                    new SqlCommand("sp_ConsultarLibros", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cn.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            libros.Add(MapearLibro(dr));
                        }
                    }
                }
            }

            return libros;
        }

        // Consultar libro por identificador
        public Libro ObtenerLibroPorId(int id)
        {
            using (SqlConnection cn =
                new SqlConnection(conexion))
            {
                using (SqlCommand cmd =
                    new SqlCommand("sp_ConsultarLibroPorId", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@IdLibro",
                        SqlDbType.Int).Value = id;

                    cn.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                            return MapearLibro(dr);
                    }
                }
            }

            return null;
        }

        // Convertir los datos SQL en un objeto Libro
        private Libro MapearLibro(SqlDataReader dr)
        {
            return new Libro
            {
                IdLibro = Convert.ToInt32(dr["IdLibro"]),
                Titulo = dr["Titulo"].ToString(),
                Autor = dr["Autor"].ToString(),
                ISBN = dr["ISBN"].ToString(),
                Editorial = dr["Editorial"] == DBNull.Value
                    ? null : dr["Editorial"].ToString(),
                AnioPublicacion =
                    Convert.ToInt32(dr["AnioPublicacion"]),
                Categoria = dr["Categoria"] == DBNull.Value
                    ? null : dr["Categoria"].ToString(),
                CantidadDisponible =
                    Convert.ToInt32(dr["CantidadDisponible"]),
                FechaAdicion =
                    Convert.ToDateTime(dr["FechaAdicion"]),
                UsuarioAgrego = dr["UsuarioAgrego"].ToString(),
                FechaModificacion =
                    dr["FechaModificacion"] == DBNull.Value
                    ? (DateTime?)null
                    : Convert.ToDateTime(dr["FechaModificacion"]),
                UsuarioModifico =
                    dr["UsuarioModifico"] == DBNull.Value
                    ? null : dr["UsuarioModifico"].ToString()
            };

        }
        // Crear un nuevo libro
        public int CrearLibro(Libro libro)
        {
            using (SqlConnection cn = new SqlConnection(conexion))
            using (SqlCommand cmd = new SqlCommand("sp_CrearLibro", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@Titulo", SqlDbType.NVarChar, 200).Value = libro.Titulo;
                cmd.Parameters.Add("@Autor", SqlDbType.NVarChar, 150).Value = libro.Autor;
                cmd.Parameters.Add("@ISBN", SqlDbType.VarChar, 13).Value = libro.ISBN;
                cmd.Parameters.Add("@Editorial", SqlDbType.NVarChar, 150).Value =
                    (object)libro.Editorial ?? DBNull.Value;
                cmd.Parameters.Add("@AnioPublicacion", SqlDbType.Int).Value = libro.AnioPublicacion;
                cmd.Parameters.Add("@Categoria", SqlDbType.NVarChar, 100).Value =
                    (object)libro.Categoria ?? DBNull.Value;
                cmd.Parameters.Add("@CantidadDisponible", SqlDbType.Int).Value = libro.CantidadDisponible;
                cmd.Parameters.Add("@UsuarioAgrego", SqlDbType.NVarChar, 100).Value = libro.UsuarioAgrego;

                cn.Open();
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        // Buscar libros por título
        public List<Libro> BuscarLibrosPorTitulo(string titulo)
        {
            List<Libro> libros = new List<Libro>();

            using (SqlConnection cn = new SqlConnection(conexion))
            using (SqlCommand cmd = new SqlCommand("sp_BuscarLibrosPorTitulo", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Titulo", SqlDbType.NVarChar, 200).Value = titulo;

                cn.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        libros.Add(MapearLibro(dr));
                    }
                }
            }

            return libros;
        }

        // Buscar libro por ISBN
        public Libro BuscarLibroPorISBN(string isbn)
        {
            using (SqlConnection cn = new SqlConnection(conexion))
            using (SqlCommand cmd = new SqlCommand("sp_BuscarLibroPorISBN", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@ISBN", SqlDbType.VarChar, 13).Value = isbn;

                cn.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                        return MapearLibro(dr);
                }
            }

            return null;
        }

        // Actualizar libro
        public void ActualizarLibro(Libro libro)
        {
            using (SqlConnection cn = new SqlConnection(conexion))
            using (SqlCommand cmd = new SqlCommand("sp_ActualizarLibro", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@IdLibro", SqlDbType.Int).Value = libro.IdLibro;
                cmd.Parameters.Add("@Titulo", SqlDbType.NVarChar, 200).Value = libro.Titulo;
                cmd.Parameters.Add("@Autor", SqlDbType.NVarChar, 150).Value = libro.Autor;
                cmd.Parameters.Add("@ISBN", SqlDbType.VarChar, 13).Value = libro.ISBN;
                cmd.Parameters.Add("@Editorial", SqlDbType.NVarChar, 150).Value =
                    (object)libro.Editorial ?? DBNull.Value;
                cmd.Parameters.Add("@AnioPublicacion", SqlDbType.Int).Value = libro.AnioPublicacion;
                cmd.Parameters.Add("@Categoria", SqlDbType.NVarChar, 100).Value =
                    (object)libro.Categoria ?? DBNull.Value;
                cmd.Parameters.Add("@CantidadDisponible", SqlDbType.Int).Value = libro.CantidadDisponible;
                cmd.Parameters.Add("@UsuarioModifico", SqlDbType.NVarChar, 100).Value = libro.UsuarioModifico;

                cn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        // Eliminar libro
        public void EliminarLibro(int id)
        {
            using (SqlConnection cn = new SqlConnection(conexion))
            using (SqlCommand cmd = new SqlCommand("sp_EliminarLibro", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdLibro", SqlDbType.Int).Value = id;

                cn.Open();
                cmd.ExecuteNonQuery();
            }
        }




    }
}

