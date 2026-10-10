
<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Libros.aspx.cs"
    Inherits="BibliotecaWeb.Vistas.Libros" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport"
          content="width=device-width, initial-scale=1" />

    <title>Mantenimiento de Libros</title>

    <link href="../Content/EstilosBiblioteca.css"
          rel="stylesheet" />
</head>

<body>
    <form id="form1" runat="server">

        <!-- ENCABEZADO -->
        <header class="encabezado-biblioteca">
            <h1>Sistema de Biblioteca</h1>
            <p>Mantenimiento de Libros</p>
        </header>

        <main class="contenedor-biblioteca">

            <h2>Registro de Libros</h2>

            <asp:HiddenField ID="hfIdLibro"
                runat="server" />

            <!-- FORMULARIO -->
            <section class="formulario-libro">

                <div class="campo-formulario">
                    <label class="etiqueta" for="txtTitulo">
                        Título *
                    </label>
                    <asp:TextBox ID="txtTitulo"
                        runat="server"
                        ClientIDMode="Static"
                        MaxLength="200"
                        CssClass="entrada" />
                </div>

                <div class="campo-formulario">
                    <label class="etiqueta" for="txtAutor">
                        Autor *
                    </label>
                    <asp:TextBox ID="txtAutor"
                        runat="server"
                        ClientIDMode="Static"
                        MaxLength="150"
                        CssClass="entrada" />
                </div>

                <div class="campo-formulario">
                    <label class="etiqueta" for="txtISBN">
                        ISBN *
                    </label>
                    <asp:TextBox ID="txtISBN"
                        runat="server"
                        ClientIDMode="Static"
                        MaxLength="13"
                        CssClass="entrada" />
                </div>

                <div class="campo-formulario">
                    <label class="etiqueta" for="txtEditorial">
                        Editorial
                    </label>
                    <asp:TextBox ID="txtEditorial"
                        runat="server"
                        ClientIDMode="Static"
                        MaxLength="150"
                        CssClass="entrada" />
                </div>

                <div class="campo-formulario">
                    <label class="etiqueta" for="txtAnio">
                        Año de publicación *
                    </label>
                    <asp:TextBox ID="txtAnio"
                        runat="server"
                        ClientIDMode="Static"
                        TextMode="Number"
                        CssClass="entrada" />
                </div>

                <div class="campo-formulario">
                    <label class="etiqueta" for="txtCategoria">
                        Categoría
                    </label>
                    <asp:TextBox ID="txtCategoria"
                        runat="server"
                        ClientIDMode="Static"
                        MaxLength="100"
                        CssClass="entrada" />
                </div>

                <div class="campo-formulario">
                    <label class="etiqueta" for="txtCantidad">
                        Cantidad disponible *
                    </label>
                    <asp:TextBox ID="txtCantidad"
                        runat="server"
                        ClientIDMode="Static"
                        TextMode="Number"
                        CssClass="entrada" />
                </div>

                <div class="campo-formulario">
                    <label class="etiqueta" for="txtUsuario">
                        Usuario responsable *
                    </label>
                    <asp:TextBox ID="txtUsuario"
                        runat="server"
                        ClientIDMode="Static"
                        MaxLength="100"
                        CssClass="entrada" />
                </div>

                <!-- BOTONES -->
                <asp:Button ID="btnGuardar"
                    runat="server"
                    Text="Guardar libro"
                    CssClass="boton boton-guardar"
                    OnClick="btnGuardar_Click" />

                <asp:Button ID="btnLimpiar"
                    runat="server"
                    Text="Limpiar"
                    CssClass="boton boton-editar"
                    CausesValidation="false"
                    OnClick="btnLimpiar_Click" />

                <div style="margin-top:15px;">
                    <asp:Label ID="lblMensaje"
                        runat="server"
                        role="status"
                        aria-live="polite" />
                </div>

            </section>

            <!-- BUSQUEDA -->
            <section style="margin-top:30px;">

                <h2>Buscar Libros</h2>

                <asp:TextBox ID="txtBuscar"
                    runat="server"
                    CssClass="entrada"
                    placeholder="Ingrese título o ISBN" />

                <div style="margin-top:10px;">

                    <asp:Button ID="btnBuscar"
                        runat="server"
                        Text="Buscar"
                        CssClass="boton boton-buscar"
                        OnClick="btnBuscar_Click" />

                    <asp:Button ID="btnMostrarTodos"
                        runat="server"
                        Text="Mostrar todos"
                        CssClass="boton boton-editar"
                        OnClick="btnMostrarTodos_Click" />

                </div>

            </section>

            <!-- LISTADO -->
            <section style="margin-top:30px;">

                <h2>Listado de Libros</h2>

                <div style="overflow-x:auto;">

                    <asp:GridView ID="gvLibros"
                        runat="server"
                        AutoGenerateColumns="False"
                        DataKeyNames="IdLibro"
                        CssClass="tabla-libros"
                        EmptyDataText="No hay libros para mostrar."
                        OnRowCommand="gvLibros_RowCommand">

                        <Columns>

                            <asp:BoundField
                                DataField="IdLibro"
                                HeaderText="ID" />

                            <asp:BoundField
                                DataField="Titulo"
                                HeaderText="Título" />

                            <asp:BoundField
                                DataField="Autor"
                                HeaderText="Autor" />

                            <asp:BoundField
                                DataField="ISBN"
                                HeaderText="ISBN" />

                            <asp:BoundField
                                DataField="CantidadDisponible"
                                HeaderText="Cantidad" />

                            <asp:TemplateField HeaderText="Acciones">
                                <ItemTemplate>

                                    <asp:LinkButton
                                        ID="btnEditar"
                                        runat="server"
                                        Text="Editar"
                                        CssClass="boton boton-editar"
                                        CommandName="EditarLibro"
                                        CommandArgument='<%# Eval("IdLibro") %>' />

                                    <asp:LinkButton
                                        ID="btnEliminar"
                                        runat="server"
                                        Text="Eliminar"
                                        CssClass="boton boton-eliminar"
                                        CommandName="EliminarLibro"
                                        CommandArgument='<%# Eval("IdLibro") %>'
                                        OnClientClick="return confirm('¿Desea eliminar este libro?');" />

                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>

                    </asp:GridView>

                </div>

            </section>

        </main>

    </form>
</body>
</html>
