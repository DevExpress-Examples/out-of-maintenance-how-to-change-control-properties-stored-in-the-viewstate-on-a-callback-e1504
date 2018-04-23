Imports System
Imports System.Collections.Generic
Imports System.Drawing
Imports System.Web
Imports System.Web.UI
Imports DevExpress.Web.ASPxClasses

Namespace ControlPropertiesChangeOnCallback
    Partial Public Class _Default
        Inherits System.Web.UI.Page

        Protected Property ButtonBorderColor() As Color
            Get
                Return ColorTranslator.FromHtml(DirectCast(ButtonState("borderColor"), String))
            End Get
            Set(ByVal value As Color)
                ButtonState("borderColor") = ColorToString(value)
                btnButton.Border.BorderColor = value
            End Set
        End Property
        Protected Property ButtonText() As String
            Get
                Return DirectCast(ButtonState("text"), String)
            End Get
            Set(ByVal value As String)
                ButtonState("text") = value
                btnButton.Text = value
            End Set
        End Property
        Protected ReadOnly Property ButtonState() As Dictionary(Of String, Object)
            Get

                Dim buttonState_Renamed As Object = Nothing
                If Not hfPageState.TryGet(btnButton.ClientID, buttonState_Renamed) Then
                    buttonState_Renamed = New Dictionary(Of String, Object)()
                    hfPageState(btnButton.ClientID) = buttonState_Renamed
                End If
                Return DirectCast(buttonState_Renamed, Dictionary(Of String, Object))
            End Get
        End Property

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
            If Not IsCallback Then
                ASPxWebControl.RegisterUtilsScript(Me)
            End If

            If (Not IsCallback) AndAlso (Not IsPostBack) Then
                ButtonBorderColor = Color.Black
                ButtonText = "Initial Text"
            Else
                ButtonBorderColor = ButtonBorderColor
                ButtonText = ButtonText
            End If
        End Sub
        Protected Sub OnCallback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase)
            If e.Parameter = "ChangeButtonProperties" Then
                ButtonBorderColor = GetRandomColor()
                ButtonText = GetRandomText()
            End If
        End Sub

        ' Utils
        Private Shared ReadOnly Random As New Random()

        Private Shared Function GetRandomColor() As Color
            Return Color.FromArgb(Random.Next(70, 230), Random.Next(70, 230), Random.Next(70, 230))
        End Function
        Private Shared Function GetRandomText() As String
            Return "Random Text from Server: " & Random.Next(10000, 65536).ToString()
        End Function
        Private Shared Function ColorToString(ByVal color As Color) As String
            Return String.Format("#{0:x2}{1:x2}{2:x2}", color.R, color.G, color.B)
        End Function
    End Class
End Namespace
