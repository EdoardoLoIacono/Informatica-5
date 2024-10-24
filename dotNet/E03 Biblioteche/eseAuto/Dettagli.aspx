<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dettagli.aspx.cs" Inherits="eseAuto.Dettagli" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <h1>Book details</h1>
    <form id="form1" runat="server">
        <asp:Panel ID="pnlDatiLibro" runat="server" Visible="true">
            ID: <asp:Label ID="lblId" runat="server" Text=""></asp:Label>
            <br />
            Titolo: <asp:Label ID="lblTitolo" runat="server" Text=""></asp:Label>
            <br />
            Anno di pubblicazione: <asp:Label ID="lblAnno" runat="server" Text=""></asp:Label>
            <br />
            Autore: <asp:Label ID="lblAutore" runat="server" Text=""></asp:Label>
            <br />
            Nazionalità: <asp:Label ID="lblNazionalita" runat="server" Text=""></asp:Label>
            <br />
        </asp:Panel>
        <asp:Panel ID="pnlNonTrovato" runat="server" Visible="false">
            <h5>BOOK NOT FOUND</h5>
        </asp:Panel>  
        <asp:Button Text="Home Page" ID="btnHome" runat="server" OnClick="btnHome_Click" />
    </form>
</body>
</html>
