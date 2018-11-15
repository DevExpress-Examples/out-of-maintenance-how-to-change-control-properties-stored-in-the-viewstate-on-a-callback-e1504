<!-- default file list -->
*Files to look at*:

* [Default.aspx](./CS/Default.aspx) (VB: [Default.aspx](./VB/Default.aspx))
* [Default.aspx.cs](./CS/Default.aspx.cs) (VB: [Default.aspx](./VB/Default.aspx))
<!-- default file list end -->
# How to change control properties stored in the ViewState on a callback


<p>In various situations it may be necessary to change some control properties on a callback.  The problem is that the view state isn't being updated on regular callbacks, so all your changes made on a callback won't be persisted to the client, and the next time you send a post to the server, you'll get the old property values.</p><p>There are several solutions to this problem: The easiest solution is simply to use asp:UpdatePanel (when asp:UpdatePanel sends callbacks, the view state is being updated). However, if you don't want to use UpdatePanel or your page's architecture make its use undesirable, you can use the approach described in this example.</p><p>The general idea is to store the properties we want to change on a callback in an ASPxHiddenField and synchronize its state with states of controls whose properties you'd like to change.</p>

<br/>


