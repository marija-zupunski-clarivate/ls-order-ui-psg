<HEAD>

<script language='JavaScript' src='/ListSales/javascripts/d2w.js'></script>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

</HEAD>

<%@ taglib uri="/taglib/tags.tld" prefix='mytag' %>
<%@ page import="com.thomsonreuters.listsales.beans.*" %>
<%@ page errorPage="/jsp/error.jsp" %>
<img src="../images/LSHeader.gif" width="300" height="20"/>

<%

  //get template name and title from cookies
  String template_name = "";
  Cookie[] cookies = request.getCookies();
  if(cookies != null){
    for (int i = 0; i < cookies.length; i++) {
      if (cookies[i].getName().equals("RetPage"))
        template_name = cookies[i].getValue();
    }
  }
  template_name = (String) session.getAttribute("RetPageSn");
  String editViewFlag = (String) session.getAttribute("editviewflag");
  String co_showMenu=(String)session.getAttribute("co_showMenu");
  if(co_showMenu==null)
  {
    co_showMenu="N";
  }
  log("The template name from session is :" + template_name+" edit view Flag :::"+editViewFlag);
  if(template_name.endsWith("createOrderView.xsl"))
  {
    log("The template is "+ template_name+" accessed from view order summaries ");
  }else if((template_name.endsWith("editOrder.xsl")) && (editViewFlag.equalsIgnoreCase("Y")) && (!co_showMenu.equalsIgnoreCase("Y"))){
    log("The template is in else if block  "+ template_name+" accessed from view order summaries "+editViewFlag);
%>
    <%@include file='/jsp/includeJS.jsp' %>
<%
  } else if((template_name.endsWith("orderResults.xsl")) && (editViewFlag.equalsIgnoreCase("Y")))
  {
    log("The template is in else if block  "+ template_name+" accessed from view order summaries "+editViewFlag);
%>
    <%@include file='/jsp/includeJS.jsp' %>
<%
  }

  else
  {
%>

    <%-- menu bar --%>
    <%@include file='/jsp/menu.jsp' %>
<hr>

<%
  }

  //get records, check possible errors
  String currRecord = (String) request.getAttribute("CurrRecord");
  log("JSP: The currRecord is " + currRecord);
  String custNameStr = "CustomerName";
  if (currRecord != null && !currRecord.equals("")) {
    Record record = (Record) request.getAttribute(currRecord);
     custNameStr = (String) session.getAttribute("custNameStr");
      log("JSP: The record is " + record);
    String errmsg = record.getErrMsg();
    if (errmsg != null) {
          log("JSP: The errmsg is " + errmsg);
      session.setAttribute("ERROR", errmsg);
          log("JSP: commenting the jsp error forward page ");
/*
%>
      <jsp:forward page="/jsp/error.jsp" />
<%
*/
    }
    else
       log("JSP: There is no error message " + errmsg);
    log("JSP: Once again the template_name is " + template_name + " and the record is " + record);
    request.setAttribute("Record_val",record);
%>

<mytag:LoadTemplate name="<%= template_name %>" record="<%= record %>"/>
<%

  }
  //not display records
  else {
    if(!template_name.endsWith(".xsl")) {
%>
      <jsp:include page="<%= template_name %>" flush='true' />
<%

    }
  }
%>
