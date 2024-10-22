<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="eseAuto.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Ese Auto</title>
</head>
<body>
    <h1>Esercizio macchine</h1>
    <form id="form1" runat="server">
        <div>
            Filtro per marca:
            <asp:DropDownList ID="cmbMarche" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cmbMarche_SelectedIndexChanged"></asp:DropDownList>
        </div>
        <div>
            Filtro per alimentazione
            <asp:RadioButton ID="rbAll" runat="server" Text="All" GroupName="alimentazione" OnCheckedChanged="rbAlimentazione_CheckedChanged" AutoPostBack="true" Checked="true"/>
            <asp:RadioButton ID="rbElettrica" runat="server" Text="Elettrica" GroupName="alimentazione" OnCheckedChanged="rbAlimentazione_CheckedChanged" AutoPostBack="true" />
            <asp:RadioButton ID="rbBenzina" runat="server" Text="Benzina" GroupName="alimentazione" OnCheckedChanged="rbAlimentazione_CheckedChanged" AutoPostBack="true"  />
        </div>
        <div>
            <asp:GridView ID="gridAuto" runat="server"></asp:GridView>
        </div>
    </form>
</body>
</html>
