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
            <asp:GridView ID="gridAuto" runat="server"></asp:GridView>
        </div>
    </form>
</body>
</html>
