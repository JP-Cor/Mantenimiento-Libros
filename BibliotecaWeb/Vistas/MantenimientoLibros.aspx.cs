
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using BibliotecaWeb.Modelos;
using BibliotecaWeb.Repositorios;

namespace BibliotecaWeb.Vistas
{
    public partial class Libros : Page
    {
        private readonly LibroRepositorio repositorio =
            new LibroRepositorio();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarLibros();
            }
        }

        // Mostrar todos los libros
        private void CargarLibros()
        {
            gvLibros.DataSource = repositorio.ObtenerLibros();
            gvLibros.DataBind();
        }

        // Guardar o actualizar libro
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtTitulo.Text) ||
                    string.IsNullOrWhiteSpace(txtAutor.Text) ||
                    string.IsNullOrWhiteSpace(txtISBN.Text) ||
                    string.IsNullOrWhiteSpace(txtUsuario.Text))
                {
                    MostrarMensaje(
                        "Complete los campos obligatorios.", false);
                    return;
                }

                int anio;
                int cantidad;

                if (!int.TryParse(txtAnio.Text, out anio) ||
                    anio < 1450 ||
                    anio > DateTime.Now.Year)
                {
                    MostrarMensaje(
                        "Ingrese un año de publicación válido.", false);
                    return;
                }

                if (!int.TryParse(txtCantidad.Text, out cantidad) ||
                    cantidad < 0)
                {
                    MostrarMensaje(
                        "La cantidad no puede ser negativa.", false);
                    return;
                }

                string isbn = txtISBN.Text.Trim();

                if (isbn.Length != 13 ||
                    !System.Text.RegularExpressions.Regex.IsMatch(
                        isbn, @"^\d{13}$"))
                {
                    MostrarMensaje(
                        "El ISBN debe contener 13 dígitos.", false);
                    return;
                }

                Libro libro = new Libro
                {
                    Titulo = txtTitulo.Text.Trim(),
                    Autor = txtAutor.Text.Trim(),
                    ISBN = isbn,
                    Editorial = txtEditorial.Text.Trim(),
                    AnioPublicacion = anio,
                    Categoria = txtCategoria.Text.Trim(),
                    CantidadDisponible = cantidad
                };

                bool editando =
                    !string.IsNullOrEmpty(hfIdLibro.Value);

                if (editando)
                {
                    libro.IdLibro = int.Parse(hfIdLibro.Value);
                    libro.UsuarioModifico = txtUsuario.Text.Trim();

                    repositorio.ActualizarLibro(libro);
                }
                else
                {
                    libro.UsuarioAgrego = txtUsuario.Text.Trim();

                    repositorio.CrearLibro(libro);
                }

                LimpiarFormulario();
                CargarLibros();

                MostrarMensaje(
                    editando
                        ? "Libro actualizado correctamente."
                        : "Libro registrado correctamente.",
                    true);
            }
            catch (SqlException ex)
            {
                MostrarMensaje(
                    "Error de base de datos: " + ex.Message, false);
            }
            catch (Exception ex)
            {
                MostrarMensaje(
                    "Error: " + ex.Message, false);
            }
        }

        // Buscar por título o ISBN

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                string tipoBusqueda = ddlTipoBusqueda.SelectedValue;
                string criterio = txtBuscar.Text.Trim();

                if (tipoBusqueda == "Todos")
                {
                    CargarLibros();
                    lblMensaje.Text = "";
                    return;
                }

                if (string.IsNullOrWhiteSpace(criterio))
                {
                    MostrarMensaje(
                        "Ingrese un criterio de búsqueda.", false);
                    return;
                }

                List<Libro> libros = new List<Libro>();

                if (tipoBusqueda == "Titulo")
                {
                    libros = repositorio.BuscarLibrosPorTitulo(criterio);
                }
                else if (tipoBusqueda == "ISBN")
                {
                    Libro libro = repositorio.BuscarLibroPorISBN(criterio);

                    if (libro != null)
                    {
                        libros.Add(libro);
                    }
                }

                gvLibros.DataSource = libros;
                gvLibros.DataBind();

                if (libros.Count == 0)
                {
                    MostrarMensaje(
                        "No se encontraron libros.", false);
                }
                else
                {
                    lblMensaje.Text = "";
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje(
                    "Error al buscar: " + ex.Message, false);
            }
        }


        // Mostrar todos
        protected void btnMostrarTodos_Click(
            object sender, EventArgs e)
        {
            try
            {
                ddlTipoBusqueda.SelectedValue = "Todos";
                txtBuscar.Text = "";
                CargarLibros();
                lblMensaje.Text = "";
            }
            catch (Exception ex)
            {
                MostrarMensaje(
                    "Error al consultar: " + ex.Message, false);
            }
        }

        // Editar o eliminar desde GridView
        protected void gvLibros_RowCommand(
            object sender, GridViewCommandEventArgs e)
        {
            int id;

            if (!int.TryParse(
                Convert.ToString(e.CommandArgument), out id))
                return;

            try
            {
                if (e.CommandName == "EditarLibro")
                {
                    Libro libro = repositorio.ObtenerLibroPorId(id);

                    if (libro == null)
                    {
                        MostrarMensaje(
                            "El libro no existe.", false);
                        return;
                    }

                    hfIdLibro.Value = libro.IdLibro.ToString();
                    txtTitulo.Text = libro.Titulo;
                    txtAutor.Text = libro.Autor;
                    txtISBN.Text = libro.ISBN;
                    txtEditorial.Text = libro.Editorial;
                    txtAnio.Text = libro.AnioPublicacion.ToString();
                    txtCategoria.Text = libro.Categoria;
                    txtCantidad.Text =
                        libro.CantidadDisponible.ToString();
                    txtUsuario.Text = "";

                    btnGuardar.Text = "Actualizar libro";

                    MostrarMensaje(
                        "Modifique los datos y presione Actualizar libro.",
                        true);
                }
                else if (e.CommandName == "EliminarLibro")
                {
                    repositorio.EliminarLibro(id);

                    LimpiarFormulario();
                    CargarLibros();

                    MostrarMensaje(
                        "Libro eliminado correctamente.", true);
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje(
                    "Error en la operación: " + ex.Message, false);
            }
        }

        // Limpiar formulario
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
            lblMensaje.Text = "";
        }

        private void LimpiarFormulario()
        {
            hfIdLibro.Value = "";
            txtTitulo.Text = "";
            txtAutor.Text = "";
            txtISBN.Text = "";
            txtEditorial.Text = "";
            txtAnio.Text = "";
            txtCategoria.Text = "";
            txtCantidad.Text = "";
            txtUsuario.Text = "";

            btnGuardar.Text = "Guardar libro";
        }

        // Mensajes informativos
        private void MostrarMensaje(string mensaje, bool exito)
        {
            lblMensaje.Text =
                Server.HtmlEncode(mensaje);

            lblMensaje.CssClass = exito
                ? "mensaje-exito"
                : "mensaje-error";
        }
    }
}
