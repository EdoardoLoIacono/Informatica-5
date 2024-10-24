<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="eseAuto.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Ese Biblioteca</title>
</head>
<body>
    <p>USER AGENT: <asp:Label ID="lblUserAgent" runat="server"></asp:Label></p>
    <p>VISIT COUNTER: <asp:Label ID="lblCounter" runat="server"></asp:Label></p>
    <p>ONLINE SINCE: <asp:Label ID="lblConnectionTime" runat="server"></asp:Label></p>
    <h1>Esercizio Biblioteca</h1>
    <form id="form1" runat="server">
        <div>
            Author filter: <asp:DropDownList ID="cmbAutore" runat="server" OnSelectedIndexChanged="cmbAutore_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
        </div>
        <div>
            Title filter: <asp:TextBox ID="txtNome" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnDetails" runat="server" OnClick="btnDetails_Click" Text="Cerca"/>
        <asp:DataGrid ID="gdBooks" runat="server"></asp:DataGrid>
    </form>
</body>
</html>
