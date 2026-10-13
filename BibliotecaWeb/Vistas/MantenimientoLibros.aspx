
<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="MantenimientoLibros.aspx.cs"
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

            <h2><asp:Label ID="lblTituloFormulario" runat="server" Text="Registro de Libros" /></h2>

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
                    
                    <asp:RequiredFieldValidator
                        ID="rfvTitulo"
                        runat="server"
                        ControlToValidate="txtTitulo"
                        ErrorMessage="El título es obligatorio."
                        Display="Dynamic"
                        CssClass="mensaje-error"
                        ValidationGroup="GuardarLibro"
                        SetFocusOnError="true" />

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

                    <asp:RequiredFieldValidator
                        ID="rfvAutor"
                        runat="server"
                        ControlToValidate="txtAutor"
                        ErrorMessage="El autor es obligatorio."
                        Display="Dynamic"
                        CssClass="mensaje-error"
                        ValidationGroup="GuardarLibro"
                        SetFocusOnError="true" />
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

                    <asp:RequiredFieldValidator
                        ID="rfvISBN"
                        runat="server"
                        ControlToValidate="txtISBN"
                        ErrorMessage="El ISBN es obligatorio."
                        Display="Dynamic"
                        CssClass="mensaje-error"
                        ValidationGroup="GuardarLibro"
                        SetFocusOnError="true" />

                    <asp:RegularExpressionValidator
                        ID="revISBN"
                        runat="server"
                        ControlToValidate="txtISBN"
                        ValidationExpression="^\d{13}$"
                        ErrorMessage="El ISBN debe contener exactamente 13 dígitos."
                        Display="Dynamic"
                        CssClass="mensaje-error"
                        ValidationGroup="GuardarLibro"
                        SetFocusOnError="true" />
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

                    <asp:RequiredFieldValidator
                        ID="rfvAnio"
                        runat="server"
                        ControlToValidate="txtAnio"
                        ErrorMessage="El año de publicación es obligatorio."
                        Display="Dynamic"
                        CssClass="mensaje-error"
                        ValidationGroup="GuardarLibro"
                        SetFocusOnError="true" />

                    <asp:RegularExpressionValidator
                        ID="revAnio"
                        runat="server"
                        ControlToValidate="txtAnio"
                        ValidationExpression="^\d+$"
                        ErrorMessage="Ingrese un año utilizando solo números enteros."
                        Display="Dynamic"
                        CssClass="mensaje-error"
                        ValidationGroup="GuardarLibro"
                        SetFocusOnError="true" />

                    <asp:RangeValidator
                        ID="rngAnio"
                        runat="server"
                        ControlToValidate="txtAnio"
                        Type="Integer"
                        MinimumValue="1450"
                        MaximumValue="2100"
                        ErrorMessage="El año debe estar entre 1450 y 2100."
                        Display="Dynamic"
                        CssClass="mensaje-error"
                        ValidationGroup="GuardarLibro"
                        SetFocusOnError="true" />

                    <asp:CustomValidator
                        ID="cvAnioActual"
                        runat="server"
                        ControlToValidate="txtAnio"
                        OnServerValidate="cvAnioActual_ServerValidate"
                        ValidateEmptyText="false"
                        ErrorMessage="El año no puede ser mayor que el año actual."
                        Display="Dynamic"
                        CssClass="mensaje-error"
                        ValidationGroup="GuardarLibro"
                        SetFocusOnError="true" />
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

                    <asp:RequiredFieldValidator
                        ID="rfvCantidad"
                        runat="server"
                        ControlToValidate="txtCantidad"
                        ErrorMessage="La cantidad disponible es obligatoria."
                        Display="Dynamic"
                        CssClass="mensaje-error"
                        ValidationGroup="GuardarLibro"
                        SetFocusOnError="true" />

                    <asp:RegularExpressionValidator
                        ID="revCantidad"
                        runat="server"
                        ControlToValidate="txtCantidad"
                        ValidationExpression="^\d+$"
                        ErrorMessage="La cantidad debe ser un número entero no negativo."
                        Display="Dynamic"
                        CssClass="mensaje-error"
                        ValidationGroup="GuardarLibro"
                        SetFocusOnError="true" />

                    <asp:RangeValidator
                        ID="rngCantidad"
                        runat="server"
                        ControlToValidate="txtCantidad"
                        Type="Integer"
                        MinimumValue="0"
                        MaximumValue="2147483647"
                        ErrorMessage="La cantidad debe ser igual o mayor que cero."
                        Display="Dynamic"
                        CssClass="mensaje-error"
                        ValidationGroup="GuardarLibro"
                        SetFocusOnError="true" />
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

                    <asp:RequiredFieldValidator
                        ID="rfvUsuario"
                        runat="server"
                        ControlToValidate="txtUsuario"
                        ErrorMessage="El usuario responsable es obligatorio."
                        Display="Dynamic"
                        CssClass="mensaje-error"
                        ValidationGroup="GuardarLibro"
                        SetFocusOnError="true" />
                </div>

                <!-- BOTONES -->
                <asp:Button ID="btnGuardar"
                    runat="server"
                    Text="Guardar libro"
                    CssClass="boton boton-guardar"
                    ValidationGroup="GuardarLibro"
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


                <asp:DropDownList
                    ID="ddlTipoBusqueda"
                    runat="server"
                    CssClass="entrada"
                    ClientIDMode="Static">
                    <asp:ListItem Text="Todos los libros" Value="Todos" />
                    <asp:ListItem Text="Buscar por título" Value="Titulo" />
                    <asp:ListItem Text="Buscar por ISBN" Value="ISBN" />
                </asp:DropDownList>



                <asp:TextBox ID="txtBuscar"
                    runat="server"
                    CssClass="entrada"
                    placeholder="Ingrese título o ISBN" />

                <div style="margin-top:10px;">

                    <asp:Button ID="btnBuscar"
                        runat="server"
                        Text="Buscar"
                        CssClass="boton boton-buscar"
                        CausesValidation="false"
                        OnClick="btnBuscar_Click" />

                    <asp:Button ID="btnMostrarTodos"
                        runat="server"
                        Text="Mostrar todos"
                        CssClass="boton boton-editar"
                        CausesValidation="false"
                        OnClick="btnMostrarTodos_Click" />

                </div>

            </section>

            <!-- LISTADO -->
            <section style="margin-top:30px;">

                <h2>Listado de Libros</h2>

                <div style="overflow-x:auto;">
                    <div class="tabla-responsive">

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

                            <asp:BoundField
                                DataField="Editorial"
                                HeaderText="Editorial" />

                            <asp:BoundField
                                DataField="AnioPublicacion"
                                HeaderText="Año de publicación" />

                            <asp:BoundField
                                DataField="Categoria"
                                HeaderText="Categoría" />

                            <asp:BoundField
                                DataField="UsuarioAgrego"
                                HeaderText="Registrado por" />

                            <asp:BoundField
                                DataField="FechaAdicion"
                                HeaderText="Fecha de registro"
                                DataFormatString="{0:dd/MM/yyyy HH:mm}"
                                HtmlEncode="false" />




                            <asp:TemplateField HeaderText="Acciones">
                                <ItemTemplate>

                                    <asp:LinkButton
                                        ID="btnEditar"
                                        runat="server"
                                        Text="Editar"
                                        CssClass="boton boton-editar"
                                        CommandName="EditarLibro"
                                        CausesValidation="false"
                                        CommandArgument='<%# Eval("IdLibro") %>' />

                                    <asp:LinkButton
                                        ID="btnEliminar"
                                        runat="server"
                                        Text="Eliminar"
                                        CssClass="boton boton-eliminar"
                                        CommandName="EliminarLibro"
                                        CausesValidation="false"
                                        CommandArgument='<%# Eval("IdLibro") %>'
                                        OnClientClick="return confirm('¿Desea eliminar este libro?');" />

                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>

                    </asp:GridView>
                         </div>

                </div>

            </section>

        </main>

    </form>
</body>
</html>
