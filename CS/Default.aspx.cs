using System;
using System.Collections.Generic;
using System.Drawing;
using System.Web;
using System.Web.UI;
using DevExpress.Web;

namespace ControlPropertiesChangeOnCallback {
    public partial class _Default : System.Web.UI.Page {
        protected Color ButtonBorderColor {
            get { return ColorTranslator.FromHtml((string)ButtonState["borderColor"]); }
            set {
                ButtonState["borderColor"] = ColorToString(value);
                btnButton.Border.BorderColor = value;
            }
        }
        protected string ButtonText {
            get { return (string)ButtonState["text"]; }
            set {
                ButtonState["text"] = value;
                btnButton.Text = value;
            }
        }
        protected Dictionary<string, object> ButtonState {
            get {
                object buttonState = null;
                if(!hfPageState.TryGet(btnButton.ClientID, out buttonState)) {
                    buttonState = new Dictionary<string, object>();
                    hfPageState[btnButton.ClientID] = buttonState;
                }
                return (Dictionary<string, object>)buttonState;
            }
        }
        
        protected void Page_Load(object sender, EventArgs e) {
            if(!IsCallback && !IsPostBack) {
                ButtonBorderColor = Color.Black;
                ButtonText = "Initial Text";
            } else {
                ButtonBorderColor = ButtonBorderColor;
                ButtonText = ButtonText;
            }
        }
        protected void OnCallback(object source, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e) {
            if(e.Parameter == "ChangeButtonProperties") {
                ButtonBorderColor = GetRandomColor();
                ButtonText = GetRandomText();
            }
        }

        // Utils
        private static readonly Random Random = new Random();

        private static Color GetRandomColor() {
            return Color.FromArgb(Random.Next(70, 230), Random.Next(70, 230), Random.Next(70, 230));
        }
        private static string GetRandomText() {
            return "Random Text from Server: " + Random.Next(10000, 65536).ToString();
        }
        private static string ColorToString(Color color) {
            return string.Format("#{0:x2}{1:x2}{2:x2}", color.R, color.G, color.B);
        }
    }
}
