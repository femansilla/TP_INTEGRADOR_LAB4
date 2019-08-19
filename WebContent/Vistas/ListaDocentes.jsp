<%@page import="Model.Docente" %>
<%@page import="java.util.ArrayList" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Docentes/Usuarios</title>
<%@include file="Shared/css.jspf" %>
</head>
<body>

<link rel="stylesheet" href="${pageContext.request.contextPath}/Content/css/ListaUsuarios.css" type="text/css">
<%@include file="Shared/top.jspf" %>

	<!-- not responsive yet -->
	<div>
		  <ul style="" id="main">
		    <li>Acciones
		      <ul class="drop">
		        <div>
		          <li id="newUser">Nuevo</li>
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
	         	 <th class="hidden hide"></th>
				 <th>ID</th>
	             <th>Docente</th>
	             <th>DNI</th>
	             <th>Sexo</th>
	             <th>Localidad</th>
	             <th>Direccion</th>
	             <th>Usuario</th>
	             <th>Tipo de usuario</th>
	         </tr>
     	</thead>

		<%
		if(request.getAttribute("listDocs") != null){
			for(Docente doc : (ArrayList<Docente>) request.getAttribute("listDocs")){
				%>
				<tr>
					<td><input type="checkbox" value="<%= doc.getCode() %>"></td>
					<td class="hidden hide"><%= doc.getId() %></td>
		            <td><a href="${pageContext.request.contextPath}/docente?edit=<%= doc.getCode() %>"><%= doc.getCode() %></a></td>
		            <td><%= String.format("%s, %s",doc.getNombre(), doc.getApellido()) %></td>
		            <td><%= doc.getDNI() %></td>
		            <td><%= doc.getSexo() %></td>
		            <td><%= doc.getLocalidad().getDescripcion() %></td>
		            <td><%= doc.getDireccion() %></td>
		            <td><%= doc.getUsername() %></td>
		            <td><%= doc.getUsertype().getDescripcion() %></td>	
		        </tr>
				<%
			}
		}
		%>     	
     	
</table>


<%@include file="Shared/bottom.jspf" %>

<script type="text/javascript">

$(() => {
	
	$('#myTable').DataTable({
		language: $lang,
		responsive: true,
		ordering: false,
		pageLength: 6,
		lengthChange: false,
		//bFilter: false, 
		bInfo: false,
	});
	
	$('#newUser').click((e) => {
		e.preventDefault();
		window.location = '${pageContext.request.contextPath}/docente?new'
	})
	
	$('#delete').click((e) => {
		e.preventDefault();
		var rows = $( $('#myTable').DataTable().$('input[type="checkbox"]').map(function () {
			  return $(this).prop("checked") ? $(this).closest('tr') : null;
		}));
		var values = rows.toArray().map((e) => { return $(e).children() });
		
		values.forEach((dat) => {
			//console.log(dat[0].getAttribute('value'));
			$.post('docente?del&doc='+ parseInt($(dat[0]).children()[0].value) +'&usr='+ parseInt($(dat[1]).text()), (e) => {
				data = JSON.parse(e);
				if(data.status){
					alert(data.message);
					location.href = 'docente?list';
				}
				else
					alert(data.message);
			})
		});
	});
	
})
</script>

</body>
</html>