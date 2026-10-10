
using System;

namespace BibliotecaWeb.Modelos
{
    public class Libro
    {
        public int IdLibro { get; set; }

        public string Titulo { get; set; }

        public string Autor { get; set; }

        public string ISBN { get; set; }

        public string Editorial { get; set; }

        public int AnioPublicacion { get; set; }

        public string Categoria { get; set; }

        public int CantidadDisponible { get; set; }

        public DateTime FechaAdicion { get; set; }

        public string UsuarioAgrego { get; set; }

        public DateTime? FechaModificacion { get; set; }

        public string UsuarioModifico { get; set; }
    }
}
