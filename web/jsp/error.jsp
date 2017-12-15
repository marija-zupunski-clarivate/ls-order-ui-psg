<%@ page isErrorPage="true" %>

<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="/ListSales/theme/Master.css" />
<TITLE>List Sales Error Page</TITLE>
</HEAD>
<BODY>
<H1>D2W Error Page</H1>

<h4>Sorry, session expired or fatal errors occurred.</h4>
<%
  String errmsg = (String) session.getAttribute("ERROR");
  out.println("<h4>Error: " + errmsg + "</h4>");
  session.invalidate();
%>
  <h4>Please go back to the login page:</h4>

    <center><a href='/ListSales/servlet/Driver'>D2W Web Site</a></center>

</BODY>
</HTML>
