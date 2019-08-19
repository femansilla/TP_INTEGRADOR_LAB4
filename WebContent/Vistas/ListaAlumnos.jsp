<%@page import="Model.Alumno" %>
<%@page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Alumnos</title>
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
		          <li id="newAlumno">Nuevo</li>
		          <li id="delete">Eliminar</li>
		          <li id="matAlmn" class="hide hidden" >Matricular en curso</li>
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
	         	 <th>Legajo</th>
	             <th>Alumno</th>
	             <th>DNI</th>
	             <th>Fecha nacimiento</th>
	             <th>Sexo</th>
	             <th>Localidad</th>
	             <th>Direccion</th>
	             
	         </tr>
     	</thead>
     	
     	<%
		if(request.getAttribute("listAlmmns") != null){
			for(Model.Alumno almn : (ArrayList<Model.Alumno>) request.getAttribute("listAlmmns")){
				%>
				<tr>
					<td><input type="checkbox" value="<%= almn.getCode() %>"></td>
		            <td><a href="${pageContext.request.contextPath}/alumno?edit=<%= almn.getCode() %>"><%= almn.getCode() %></a></td>
		            <td><%= String.format("%s, %s", almn.getNombre(), almn.getApellido()) %></td>
		            <td><%= almn.getDNI() %></td>
		            <td style="text-align:center" ><%= almn.getFechaNac().toLocaleString().substring(0, 10) %></td>
		            <td><%= almn.getSexo() %></td>
		            <td><%= almn.getLocalidad().getDescripcion() %></td>
		            <td><%= almn.getDireccion() %></td>	
		        </tr>
				<%
			}
		}
		%>     	
     	
</table>

<%@include file="Shared/bottom.jspf" %>

<script type="text/javascript">

$(() => {
	$('#matAlmn').hide();
	user.userType != 1 ? $('#main').hide() : false;
	user.userType != 1 ? $('#newAlumno').hide() : false;
	user.userType != 1 ? $('#delete').hide() : false;
	
	$('#myTable').DataTable({
		language: $lang,
		responsive: true,
		pageLength: 6,
		lengthChange: false,
		"ordering": false,
		bFilter: true, 
		bInfo: false,
	});
	
	$('#newAlumno').click((e) => {
		e.preventDefault();
		location.href = '${pageContext.request.contextPath}/alumno?new'
	})
	
	$('#delete').click((e) => {
		e.preventDefault();
		var rows = $( $('#myTable').DataTable().$('input[type="checkbox"]').map(function () {
			  return $(this).prop("checked") ? $(this).closest('tr') : null;
		}));
		var values = rows.toArray().map((e) => { return $(e).children() });
		
		values.forEach((dat) => {
			//console.log(dat[0].getAttribute('value'));
			$.post('alumno?del&code='+ parseInt($(dat[0]).children()[0].value), (e) => {
				data = JSON.parse(e);
				if(data.status){
					alert(data.message);
					location.href = 'alumno?list';
				}
				else
					alert(data.message);
			})
		});
	})
	
})
</script>

</body>
</html>