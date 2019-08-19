<%@page import="Model.Curso" %>
<%@page import="java.util.ArrayList" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cursos</title>
<%@include file="Shared/css.jspf" %>
</head>
<body>

<%@include file="Shared/top.jspf" %>

	<!-- not responsive yet -->
	<div>
		  <ul style="" id="main">
		    <li>Acciones
		      <ul class="drop">
		        <div>
		          <li id="newCurso">Nuevo</li>
		          <li id="delete">Eliminar</li>
		          
		        </div>
		      </ul>
		    </li>
		    <div id="marker"></div>
		  </ul>
	</div>
<br>
	<table id="myTable" class="display table table-striped table-hover">
		<thead class="thead-light">
	         <tr>
	         	 <th></th>
	         	 <th>ID</th>
	             <th>Carrera</th>
	             <th>Materia</th>
	             <th>Semestre</th>
	             <th>Año</th>
	         </tr>
     	</thead>
     	<%
		if(request.getAttribute("listCurs") != null){
			for(Curso doc : (ArrayList<Curso>) request.getAttribute("listCurs")){
				%>
			     	<tr>
			     		<td><input type="checkbox" value="<%= doc.getId() %>"></td>
			     		<td><a href="${pageContext.request.contextPath}/curso?edit=<%= doc.getId() %>"><%= doc.getId() %></a></td>
			            <td><%= doc.getCarrera().getDescripcion() %></td> 
			            <td><%= doc.getMateria().getDescripcion() %></td>
			            <td><% if(doc.getSemestre() == 1) { %>Primer semestre <%} else { %> Segundo semestre <% } %></td>
			            <td><%= doc.getYear() %></td>
			        </tr>
        		<%
			}
		}
		%>     	
</table>


<%@include file="Shared/bottom.jspf" %>

<script type="text/javascript">

$(() => {
	
	user.userType != 1 ? $('#main').hide() : false;
	
	$('#myTable').DataTable({
		language: $lang,
		responsive: true,
		ordering: false,
		pageLength: 6,
		lengthChange: false,
		//bFilter: false, 
		bInfo: false,
		iDisplayLength: 15,
	});
	
	$('#newCurso').click((e) => {
		e.preventDefault();
		window.location = '${pageContext.request.contextPath}/curso?new'
	});
	
	$('#delete').click((e) => {
		e.preventDefault();
		var rows = $( $('#myTable').DataTable().$('input[type="checkbox"]').map(function () {
			  return $(this).prop("checked") ? $(this).closest('tr') : null;
		}));
		var values = rows.toArray().map((e) => { return $(e).children() });
		
		values.forEach((dat) => {
			//console.log(dat[0].getAttribute('value'));
			$.post('curso?del&Code='+ parseInt($(dat[0]).children()[0].value), (e) => {
				data = JSON.parse(e);
				if(data.status){
					alert(data.message);
					//$('#modalCursos').modal('hide');
				}
				else
					alert(data.message);
			});
		});
		location.href = 'curso?list=&userCode='+user.useCode+'&userType='+user.userType;
	});
	
	
})
</script>

</body>
</html>