<%@page import="Model.Alumno" %>
<%@page import="Model.Localidad" %>
<%@page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Alumno</title>
<%@include file="Shared/css.jspf" %>
</head>
<body>

<%@include file="Shared/top.jspf" %>

<%
	Alumno value = (Alumno) request.getAttribute("almn");
	if(value.getCode() != 0){
		%>		
		<!-- not responsive yet -->
		<div>
			  <ul style="" id="main">
			    <li>Acciones
			      <ul class="drop">
			        <div>
			          <li id="matAlmn" >Matricular en curso</li>
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

<form class="form-horizontal" id="form" action="../alumno" method="post">
  <!-- <div class="form-group"> -->
  
  <div class="form-group">
  	<input class="hidden" id="code" name="code" value="<%= value.getCode() %>">
  	
    <label class="control-label col-sm-2" for="DNI">DNI:</label>
    <div class="col-sm-6">
      <input type="number" class="form-control" id="DNI" name="DNI" placeholder="DNI" required value="<%= value.getDNI() %>">
      <span id="DNIValidation" class="text-white" for="DNI"></span>
    </div>
  </div>
  
  <div class="form-group">
    <label class="control-label col-sm-1" for="Nombre">Nombre:</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" id="Nombre" name="Nombre" placeholder="Nombre" required value="<%= value.getNombre() %>">
    </div>
  </div>
  
  <div class="form-group">
    <label class="control-label col-sm-1" for="Apellido">Apellido:</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" id="Apellido" name="Apellido" placeholder="Apellido" required value="<%= value.getApellido() %>">
    </div>
  </div>
  
  <div class="form-group">
    <label class="control-label col-sm-5" for="FechaNacSelected">Fecha de nacimiento:</label>
    <div class="col-sm-6">
      <input type="date" class="form-control" name="FechaNacSelected" id="FechaNacSelected" placeholder="" required>
      <input type="text" class="hidden" name="FechaNac" id="FechaNac" required value="<%= value.getFechaNac().toGMTString() %>">
      <span id="FechaNacValidation" class="text-white hidden" for="FechaNacSelected"></span>
    </div>
  </div>
  
  <div class="form-group">
    <label class="control-label col-sm-2" for="Sex">Sexo:</label>
    <div class="col-sm-6">
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
    <div class="col-sm-6">
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
    <div class="col-sm-6">
      <input type="text" class="form-control" name="Direccion" id="Direccion" placeholder="Direccion" required value="<%= value.getDireccion() %>">
    </div>
  </div>

  <div class="form-group"> 
    <div class="col-sm-offset-2 col-sm-10">
      <button type="button" class="btn btn-success" value="save" id="btnSave">Guardar</button>
      <button type="button" onclick="location.href = 'alumno?list'" value="cancel" class="btn btn-danger">Cancelar</button>
    </div>
  </div>
</form>

<!-- Modal -->
<div class="modal fade bd-example-modal-lg" id="modalMatricular" tabindex="-1" role="dialog" aria-labelledby="modalMatricularLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalMatricularLabel">Cursos disponibles</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table id="tablaCursos" class="table table-striped table-hover">
        	<thead class="thead-dark">
        		<tr><td></td><td>Materia</td><td>Carrera</td><td>Semestre</td><td>Ciclo lect.</td></tr>
        	</thead>
        	<tbody>
        		
        	</tbody>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">cerrar</button>
        <button type="button" class="btn btn-sm btn-primary" id="matricular">guardar cambios</button>
      </div>
    </div>
  </div>
</div>

<%@include file="Shared/bottom.jspf" %>

<script type="text/javascript">

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
	var con = 0;
	valid.forEach((entry) => {
		entry ? con++ : false;
	})
	return con == $('select').length ? true : false;	
}

var matricularCursos = (code) => {
	//console.log(code);
	$.post('alumno?getMatriculacion&code='+code+'&userCode='+user.useCode+'&userType='+user.userType, (data) => {
		var todo = JSON.parse(data);
		$('#tablaCursos tbody').html('');
		
		if(!todo.status)
			alert(todo.message);
		else{
			for(var e of todo.list) {
				//console.log(e);
				var tr = '<tr><td value="' + e.CursoCode + '">' + (e.AlumnoCode == parseInt($('#code').val()) && e.status == 'A' ? '<input type="checkbox" value="" checked>' : '<input type="checkbox" value="" unchecked>') + '</td><td value="' + e.MateriaCode + '">' + e.MateriaDescripcion + 
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
			$('#modalMatricular').modal({backdrop: false, keyboard: false, show: true}); 
		}
	});
};

var postValues = () => {
	if(!validateSelect() || !$('#DNIValidation').hasClass('hidden')){
		$('form').addClass('was-validated');
	}
	else{
		var qs =  $('#form input[name!=FechaNacSelected]').serialize()+'&Localidad='+$('#Localidad').val()+'&Sex='+$('#Sex').val();
		$.post('alumno?save&'+qs, (e) => {
			data = JSON.parse(e);
			if(data.status){
				alert(data.message);
				<%-- var retVal = confirm("Matricular en curso al alumno?");
                if( retVal == true ) {
                   matricularCursos(<%= value.getCode()%>)
                } else --%>
                	location.href = 'alumno?list';
                
			}else
				alert(data.message);
		});			
	}
}

$(() => {
	
	user.userType != 1 ? $('#delete').hide() : false;
	user.userType != 1 ? $(':input[type="submit"]').prop('disabled', true) : false;
	user.userType != 1 ? $('#btnSave').prop('disabled', true) : false;
	
	<% if(value.getCode() != 0) {	
		%>
			$('#Localidad').val(<%= value.getLocalidad().getCode() %>);
			$('#Sex').val("<%= value.getSexo() %>");		
			var date = new Date($('#FechaNac').val()).format('yyyy-mm-dd');
			$('#FechaNacSelected').val(date);
		<% 
	}%>
	
	$('#FechaNacSelected').change((e) => {
		var fecha = new Date($('#FechaNacSelected').val());
		fecha.setMinutes(fecha.getMinutes() + fecha.getTimezoneOffset());
		$('#FechaNac').val(fecha.format('yyyy-mm-dd'));
	});
	
	$('#modalMatricular').on('hidden.bs.modal', function () {
		$('#tablaCursos').DataTable().destroy();
	});
	
	$('#matAlmn').click(() => {
		matricularCursos($('#code').val());
	});
	
	$('#matricular').click(() => {
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
			$.post('alumno?alumnoCurso=&alumnoCode='+ parseInt($('#code').val()) +'&cursoCode='+ parseInt(dat[0].getAttribute('value')), (e) => {
				data = JSON.parse(e);
				if(data.status){
					alert(data.message);
					//$('#modalCursos').modal('hide');
				}
				else
					alert(data.message);
			});
		});
		
		valuesUnchecked.forEach((dat) => {
			//console.log(dat[0].getAttribute('value'));
			$.post('alumno?delAlumnoCurso=&alumnoCode='+ parseInt($('#code').val()) +'&cursoCode='+ parseInt(dat[0].getAttribute('value')), (e) => {
				if(e != ''){
					data = JSON.parse(e);
					if(data.status){
						alert(data.message);
						//$('#modalCursos').modal('hide');
					}
					else
						alert(data.message);					
				}
			});
		});
	});
	
	$('#btnSave').click((e) => { 
		e.preventDefault();
		postValues();
		//$('#form').submit(); 
	});
	
	$('#form').on('submit', (e) => {
		e.preventDefault();
		
		//postValues();
		
	});
	
	$('#delete').click((e) => {		
		$.post('alumno?del&code=<%= value.getCode()%>', (e) => {
			data = JSON.parse(e);
			if(data.status){
				alert(data.message);
				location.href = 'alumno?list';
			}else
				alert(data.message);
		});
	});
	
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
						
						$.post('./alumno?validateExistDNI='+$('#DNI').val(), (e) => {
							if(e == 'true'){						
								$('#DNI').addClass('border border-danger');
								//$('#DNI').css('background-color', 'pink');
								$('#DNIValidation').removeClass('hidden').text('Ya existe un alumno con ese DNI, verificar por favor...');
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