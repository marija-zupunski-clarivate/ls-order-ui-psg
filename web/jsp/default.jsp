<%@ taglib uri="../taglib/tags.tld" prefix='mytag' %>
<%@ page import="com.thomsonreuters.listsales.beans.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="/jsp/error.jsp" %>
<img src="/ListSales/images/LSHeader.gif" width="300" height="20"/>
<% 
  //get template name and title from cookies
  String template_name = "";
  Cookie[] cookies = request.getCookies();
    log("The cookie in jsp is " + cookies);
  if(cookies != null){
    for (int i = 0; i < cookies.length; i++) {
      if (cookies[i].getName().equals("RetPage"))
      {
        template_name = cookies[i].getValue();
        }
        log("The info is " + cookies[i].getName() + " = " + (String)cookies[i].getValue());
    }
  }

  template_name = (String) session.getAttribute("RetPageSn");
     log("The template name from session is :" + template_name);

    Enumeration enum1 = null; 
    enum1 = request.getParameterNames();
    Enumeration enum2 = null; 
    enum2 = request.getAttributeNames();
    while(enum1.hasMoreElements())
     log("The parameter is " + enum1.nextElement());

    while(enum2.hasMoreElements())
     log("The Atrrb is " + enum2.nextElement());

     log("The template name is" + template_name);
    if(template_name == null) 
  {
     template_name = "/html/login.html";
     log("The template was null here");

    }

  //get records, check possible errors
  String currRecord = (String) request.getAttribute("CurrRecord");
  if (currRecord != null && !currRecord.equals("")) {
    Record record = (Record) request.getAttribute(currRecord);
    String errmsg = record.getErrMsg();
    if (errmsg != null) {
      session.setAttribute("ERROR", errmsg);
%>
      <jsp:forward page="/jsp/error.jsp" />
<%
    }
     log("step 1...");
%>
<mytag:LoadTemplate name="<%= template_name %>" record="<%= record %>"/>
<%
     log("step 2...");
  } 
  //not display records
  else {
%>
    <jsp:include page="<%= template_name %>" flush='true' />
<%
     log("step 3");
  }
%>
