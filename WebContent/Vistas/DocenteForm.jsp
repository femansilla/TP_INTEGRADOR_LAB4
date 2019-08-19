<%@page import="Model.Docente" %>
<%@page import="Model.Localidad" %>
<%@page import="Model.UserType" %>
<%@page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Usuario</title>
<%@include file="Shared/css.jspf" %>
</head>
<body>
<%@include file="Shared/top.jspf" %>

<%
	Docente value = (Docente) request.getAttribute("user");
	if(value.getCode() != 0){
		%>		
			<!-- not responsive yet -->
			<div id="menuActions" >
				  <ul style="" id="main">
				    <li>Acciones
				      <ul class="drop">
				        <div>
				          <li id="assignCurso" onclick="asignarCursos(user.userType == 1 ? 0 : user.userCode)">Asignar curso</li>
				          <li id="delete" >Eliminar</li>
				          
				        </div>
				      </ul>
				    </li>
				    <div id="marker"></div>
				  </ul>
			</div>
		<%
	}
%>


<form id="form" class="form-horizontal" action="/docente" method="post">
	<input class="hidden" id="docenteCode" name="docenteCode" value="<%= value.getCode() %>">
	<input class="hidden" id="userCode" name="userCode" value="<%= value.getId() %>">
  <div class="form-group">
    <label class="control-label col-sm-1" for="Nombre">Nombre:</label>
    <div class="col-sm-5">
      <input type="text" class="form-control" id="Nombre" name="Nombre" placeholder="Nombre" required="Este campo no puede esta vacio" value="<%= value.getNombre() %>">
    </div>
  </div>
  
  <div class="form-group">
    <label class="control-label col-sm-1" for="Apellido">Apellido:</label>
    <div class="col-sm-5">
      <input type="text" class="form-control" id="Apellido" name="Apellido" placeholder="Apellido" required="Este campo no puede esta vacio" value="<%= value.getApellido() %>">
    </div>
  </div>
  
  <div class="form-group">
    <label class="control-label col-sm-2" for="DNI">DNI:</label>
    <div class="col-sm-5">
      <input type="number" class="form-control" id="DNI" name="DNI" placeholder="DNI" required="Este campo no puede esta vacio" value="<%= value.getDNI() %>">
      <span id="DNIValidation" class="text-white hidden" for="DNI"></span>
    </div>
  </div>
  
  <div class="form-group">
    <label class="control-label col-sm-2" for="Sex">Sexo:</label>
    <div class="col-sm-5">
	    <select id="Sex" name="Sex" class="form-control" required>
	        <option value="Default" selected>Seleccione...</option>
	        <option value="M" >Masculino</option>
	        <option value="F" >Femenino</option>
	     </select>
	     <label id="SexValidation" class="text-white hidden" for="Sex">Debe seleccionar una opcion.</label>
    </div>
  </div>
  
  <div class="form-group">
    <label class="control-label col-sm-2" for="Localidad">Localidad:</label>
    <div class="col-sm-5">
	    <select id="Localidad" name="Localidad" class="form-control" required>
	        <option value="Default" selected>Seleccione...</option>
	        <%
        		for(Localidad loc : (ArrayList<Localidad>) request.getAttribute("localidades")){
        		%>
       				<option value="<%= loc.getCode() %>"><%= loc.getDescripcion() %></option>		        			
        		<% 
        		}
        	%>    
        </select>
        <label id="LocalidadValidation" class="text-white hidden" for="Localidad">Debe seleccionar una opcion.</label>
    </div>
  </div>
  
  <div class="form-group">
    <label class="control-label col-sm-2" for="Direccion">Direccion:</label>
    <div class="col-sm-5">
      <input type="text" class="form-control" name="Direccion" id="Direccion" placeholder="Direccion" required="Este campo no puede esta vacio" value="<%= value.getDireccion() %>">
    </div>
  </div>
  
  <div class="form-group">
   <label class="control-label col-sm-2" for="userType">Tipo</label>
   <div class="col-sm-5">
      <select id="userType" name="userType" class="form-control" required>
        	<option value="Default" selected>Seleccione...</option>
        	<%
        		for(UserType type : (ArrayList<UserType>) request.getAttribute("userTypes")){
        		%>
       				<option value="<%= type.getCode() %>"><%= type.getDescripcion() %></option>		        			
        		<% 
        		}
        	%>
      </select>
      <span id="userTypeValidation" class="text-white hidden" for="userType">Debe seleccionar una opcion.</span>
    </div>
  </div>	
  
 <div class="form-group"> 
   <div class="col-sm-offset-2 col-sm-10">
     <button type="submit" value="save" class="btn btn-success">Guardar</button>
     <button type="button" onclick="location.href = 'docente?list'" value="cancel" class="btn btn-danger">Cancelar</button>
   </div>
 </div>
</form>

<!-- Modal -->
<div class="modal fade bd-example-modal-lg" id="modalCursos" tabindex="-1" role="dialog" aria-labelledby="modalCursosLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalCursosLabel">Cursos disponibles</h5>
        <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button> -->
      </div>
      <div class="modal-body">
        <table id="tablaCursos" class="table table-striped table-hover">
        	<thead class="thead-dark">
        		<tr><td></td><td>Curso</td><td>Carrera</td><td>Semestre</td><td>Ciclo lect.</td></tr>
        	</thead>
        	<tbody>
        		
        	</tbody>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">cerrar</button>
        <button type="button" class="btn btn-sm btn-primary" id="saveAsignacion">guardar cambios</button>
      </div>
    </div>
  </div>
</div>

<%@include file="Shared/bottom.jspf" %>

<script>

var validateSelect = () => {
	var valid = new Array();
	if($('#Sex').find(":selected").val() == 'Default'){
		$('#Sex').addClass('border border-danger');
		$('#SexValidation').removeClass('hidden');
		valid.push(false);
	}else{
		$('#Sex').removeClass('border border-danger');
		$('#SexValidation').addClass('hidden');
		valid.push(true);
	}
	if($('#Localidad').find(":selected").val() == 'Default'){
		$('#Localidad').addClass('border border-danger');
		$('#LocalidadValidation').removeClass('hidden');
		valid.push(false);
	}else{
		$('#Localidad').removeClass('border border-danger');
		$('#LocalidadValidation').addClass('hidden');
		valid.push(true);
	}
	if($('#userType').find(":selected").val() == 'Default'){
		$('#userType').addClass('border border-danger');
		$('#userTypeValidation').removeClass('hidden');
		valid.push(false);
	}else{
		$('#userType').removeClass('border border-danger');
		$('#userTypeValidation').addClass('hidden');
		valid.push(true);
	}
	var con = 0;
	valid.forEach((entry) => {
		entry ? con++ : false;
	})
	return con == $('select').length ? true : false;	
}

var asignarCursos = (code) => {
	
	$.post('docente?code='+parseInt($('#docenteCode').val()), (data) => {
		var todo = JSON.parse(data);
		$('#tablaCursos tbody').html('');
		for(var e of todo) {
			//console.log(e);
			var tr = '<tr><td value="' + e.CursoCode + '">' + (e.DocenteCode == parseInt($('#docenteCode').val()) && e.status == 'A' ? '<input type="checkbox" value="" checked>' : '<input type="checkbox" value="" unchecked>') + '</td><td value="' + e.MateriaCode + '">' + e.MateriaDescripcion + 
			'</td><td value="' + e.CarrraCdoe + '"> ' + e.CarreraDescripcion + '</td><td>' + (e.Semestre == 1 ? 'Primero' : 'Segundo') + '</td><td>' + e.year + '</td></tr>';
			$('#tablaCursos tbody').append(tr);
		}
		$('#tablaCursos').DataTable({
			language: $lang,
			responsive: true,
			ordering: false,
			pageLength: 4,
			lengthChange: false,
			//bFilter: false, 
			bInfo: false,
		})
		$('#modalCursos').modal({backdrop: false, keyboard: false, show: true}); 
	})
}


$(() => {
	//$('#menuActions').hide()
	<% if(value.getCode() != 0) {	
		%>
			$('#Localidad').val(<%= value.getLocalidad().getCode() %>);
			$('#userType').val(<%= value.getUsertype().getCode() %>);
			$('#Sex').val("<%= value.getSexo() %>");		
		<% 
	}%>
	
	$('#modalCursos').on('hidden.bs.modal', function () {
	    // do something…
	    $('#tablaCursos').DataTable().destroy();
	});
	
	$('#form').on('submit', (e) => {
		e.preventDefault();
		
		if(!validateSelect() || !$('#DNIValidation').hasClass('hidden')){
			$('form').addClass('was-validated');
		}
 		else{
 			$.post('docente?save', $('#form').serialize(), (e) => {
 				data = JSON.parse(e);
 				if(data.status){
 					alert(data.message);
//  					var retVal = confirm("Asignar curso al docente?");
//  	                if( retVal == true ) {
//  	                   asignarCursos(user.userType == 1 ? 0 : user.userCode)
//  	                } else
 	                	location.href = 'docente?list';
 	                
 				}else
 					alert(data.message);	
 			});			
 		}
		
	});
	
	$('#saveAsignacion').click(() => {
		var rows = $( $('#tablaCursos').DataTable().$('input[type="checkbox"]').map(function () {
			  return $(this).prop("checked") ? $(this).closest('tr') : null;
		}));
		var values = rows.toArray().map((e) => { return $(e).children() });
		
		var rowsUnchecked = $( $('#tablaCursos').DataTable().$('input[type="checkbox"]').map(function () {
			  return !$(this).prop("checked") ? $(this).closest('tr') : null;
		}));
		var valuesUnchecked = rowsUnchecked.toArray().map((e) => { return $(e).children() });
		
		values.forEach((dat) => {
			//console.log(dat[0].getAttribute('value'));
			$.post('docente?docenteCurso=&docenteCode='+ parseInt($('#docenteCode').val()) +'&cursoCode='+ parseInt(dat[0].getAttribute('value')), (e) => {
				data = JSON.parse(e);
				if(data.status){
					alert(data.message);
					//$('#modalCursos').modal('hide');
				}
				else
					alert(data.message);
			})
		});
		
		valuesUnchecked.forEach((dat) => {
			//console.log(dat[0].getAttribute('value'));
			$.post('docente?delDocenteCurso=&docenteCode='+ parseInt($('#docenteCode').val()) +'&cursoCode='+ parseInt(dat[0].getAttribute('value')), (e) => {
				data = JSON.parse(e);
				if(data.status){
					alert(data.message);
					//$('#modalCursos').modal('hide');
				}
				else
					alert(data.message);
			})
		})
			    
	});
	
	$('#delete').click((e) => {		
		$.post('docente?del&doc=<%= value.getCode()%>&usr=<%= value.getId()%>', (e) => {
			data = JSON.parse(e);
			if(data.status){
				alert(data.message);
				location.href = 'docente?list';
			}else
				alert(data.message);
				//alert('El docente que intenta eliminar tiene uno o mas cursos a cargo todavia, no se puede realizar la accion.')
			
		});
	})
	
	<% if(value.getCode() == 0) {	
		%>
			$('#DNI').on('focusout', (e) => {
		 		if($('#DNI').val() != ''){
					if(!/^\d{8}(?:[-\s]\d{4})?$/.test($('#DNI').val())){
						$('#DNI').addClass('border border-danger');
						$('#DNIValidation').removeClass('hidden').text('DNI erroneo, formato no valido');
					}else{
						$('#DNI').removeClass('border border-danger');
						$('#DNIValidation').addClass('hidden');
						
						$.post('./docente?validateExistDNI='+$('#DNI').val(), (e) => {
							if(e == 'true'){						
								$('#DNI').addClass('border border-danger');
								$('#DNIValidation').removeClass('hidden').text('Ya existe un docente con ese DNI, verificar por favor...');
							}else{
								$('#DNI').removeClass('border border-danger');
								$('#DNIValidation').addClass('hidden');
							}					
						})					
					}		 			
		 		}
				  
			})		
		<% 
	}%>
	
});

</script>

</body>
</html>