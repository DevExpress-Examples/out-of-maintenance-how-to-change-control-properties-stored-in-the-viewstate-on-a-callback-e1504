<%@ Page Language="vb" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="ControlPropertiesChangeOnCallback._Default" %>
<%@ Register Assembly="DevExpress.Web.v9.1" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v9.1" Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dxcp" %>
<%@ Register Assembly="DevExpress.Web.v9.1" Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dxhf" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v9.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>

    <script type="text/javascript">
        function OnChangePropertiesOnClient(s, e) {
    SetButtonBorderColor(button, GetRandomColor());
    SetButtonText(button, GetRandomText());
}
function OnChangePropertiesOnCallback(s, e) {
    callbackPanel.PerformCallback("ChangeButtonProperties");
}
function OnPerformEmptyCallback(s, e) {
    callbackPanel.PerformCallback();
}
function SetButtonBorderColor(button, borderColor) {
    ASPxClientUtils.GetChildByTagName(button.GetMainElement(), "TD", 0).style.borderColor = borderColor;
    UpdatePageState(button.name, "borderColor", borderColor);
}
function SetButtonText(button, text) {
    button.SetText(text);
    UpdatePageState(button.name, "text", text);
}

// Utils
function UpdatePageState(controlName, propertyName, propertyValue) {
    var controlState = pageState.Get(controlName);
    controlState[propertyName] = propertyValue;
}

function GetRandomText() {
    return "Random Text from Client: " + GetRandomNumber(10000, 65536);
}
function GetRandomColor() {
    var color = "#";
    for(var i = 0; i < 3; i++)
        color += GetRandomNumber(70, 230).toString(16);
    return color;
}
function GetRandomNumber(min, max) {
    return Math.floor(min + Math.random() * (max - min));
}
    </script>

    <style type="text/css">
        body * { font: 9pt Arial; }
        p { width: 600px; }
        strong { font-weight: bold; }
        td.label { width: 150px; text-align: right; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <dxcp:ASPxCallbackPanel ID="cpCallbackPanel" runat="server" ClientInstanceName="callbackPanel"
            OnCallback="OnCallback" HideContentOnCallback="False" RenderMode="Table">
            <PanelCollection>
                <dxp:PanelContent runat="server">
                    <%-- BeginRegion Page State --%>
                    <dxhf:ASPxHiddenField ID="hfPageState" runat="server" ClientInstanceName="pageState" />
                    <%-- EndRegion --%>

                    <table>
                        <tr>
                            <td class="label">&nbsp;</td>
                            <td>
                                <dxe:ASPxButton ID="btnButton" runat="server" AutoPostBack="False" UseSubmitBehavior="False"
                                    Text="Initial Text" Width="130px" ClientInstanceName="button">
                                    <Border BorderStyle="Solid" BorderColor="Blue" BorderWidth="4px" />
                                </dxe:ASPxButton>
                            </td>
                        </tr>
                    </table>

                    <%-- BeginRegion Command Buttons --%>
                    <br />
                    <br />
                    <table>
                        <tr>
                            <td class="label">Change Control Properties:</td>
                            <td>
                                <dxe:ASPxButton ID="btnChangePropertiesOnCallback" runat="server" AutoPostBack="False" UseSubmitBehavior="False"
                                    Text="On Callback" EncodeHtml="False" Width="130px">
                                    <ClientSideEvents Click="OnChangePropertiesOnCallback" />
                                </dxe:ASPxButton>
                            </td>
                            <td>
                                <dxe:ASPxButton ID="btnChangePropertiesOnClient" runat="server" AutoPostBack="False" UseSubmitBehavior="False"
                                    Text="On Client" EncodeHtml="False" Width="130px">
                                    <ClientSideEvents Click="OnChangePropertiesOnClient" />
                                </dxe:ASPxButton>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">Update Page:</td>
                            <td>
                                <dxe:ASPxButton ID="btnSendEmptyCallback" runat="server" AutoPostBack="False" UseSubmitBehavior="False"
                                    Text="Via Callback" EncodeHtml="False" Width="130px">
                                    <ClientSideEvents Click="OnPerformEmptyCallback" />
                                </dxe:ASPxButton>
                            </td>
                            <td>
                                <dxe:ASPxButton ID="btnDoPostback" runat="server" Text="Via Postback" EncodeHtml="False" Width="130px" />
                            </td>
                        </tr>
                    </table>
                    <%-- EndRegion --%>
                </dxp:PanelContent>
            </PanelCollection>
        </dxcp:ASPxCallbackPanel>

        <%-- BeginRegion Description --%>
        <p style="margin-top: 35px;">
            <strong>Description</strong>: In this example, you can change the Text and BorderColor
            properties of the test ASPxButton control either on the server via a callback or on
            the client. Then, you can update the page via a postback or update a part of the page
            that contains the test button via a callback. The customized ASPxButton doesn't lose
            its appearance during these updates, which always happens when you change some
            view-state-stored properties on a callback. Such a result is achieved by storing
            the Text and BorderColor properties in an external ASPxHiddenField.
        </p>
        <%-- EndRegion --%>

    </div>
    </form>
</body>
</html>