<%@page import="Model.Curso" %>
<%@page import="Model.Carrera" %>
<%@page import="Model.Materia" %>
<%@page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Curso</title>
<%@include file="Shared/css.jspf" %>
</head>
<body>

<%@include file="Shared/top.jspf" %>


<%
	Curso value = (Curso) request.getAttribute("curs");
	if(value.getId() != 0){
		%>		
			<!-- not responsive yet -->
			<div id="menuActions" >
				  <ul style="" id="main">
				    <li>Acciones
				      <ul class="drop">
				        <div>
				          <li id="matAlmns" onclick="matricularAlumnos(<%= value.getId() %>)">Matricular alumnos</li>
				          <li id="calificarAlmns" >Calificar alumnos</li>
				          <li id="delete">Eliminar</li>
				        </div>
				      </ul>
				    </li>
				    <div id="marker"></div>
				  </ul>
			</div>
		<%
	}
%>

<form id="form" class="form-horizontal" action="/curso" method="post">
  
  <input class="hidden" id="Code" name="Code" value="<%= value.getId() %>">
  
  <div class="form-group">
    <label class="control-label col-sm-2" for="Carrera">Carrera:</label>
    <div class="col-sm-6">
      <select id="Carrera" name="Carrera" class="form-control">
        <option value="Default" selected>Seleccione...</option>
        <%
       		for(Carrera crr : (ArrayList<Carrera>) request.getAttribute("carreras")){
       		%>
    			<option value="<%= crr.getCode() %>"><%= crr.getDescripcion() %></option>		        			
       		<% 
       		}
       	%>
      </select>
      <label id="CarreraValidation" class="text-white hidden" for="Carrera">Debe seleccionar una opcion.</label>
    </div>
  </div>
  
  <div class="form-group">
    <label class="control-label col-sm-2" for="Materia">Materia:</label>
    <div class="col-sm-6">
      <select id="Materia" name="Materia" class="form-control">
        <option value="Default" selected>Seleccione...</option>
        <%
       		for(Materia loc : (ArrayList<Materia>) request.getAttribute("materias")){
       		%>
    			<option value="<%= loc.getCode() %>"><%= loc.getDescripcion() %></option>		        			
       		<% 
       		}
       	%>
      </select>
      <label id="MateriaValidation" class="text-white hidden" for="Materia">Debe seleccionar una opcion.</label>
    </div>
  </div>
  
  <div class="form-group">
    <label class="control-label col-sm-2" for="Semestre">Semestre:</label>
    <div class="col-sm-6">
	    <div class="custom-control custom-radio">
		  <input type="radio" id="rdSem1" name="rdSem1" class="custom-control-input" value="1">
		  <label class="custom-control-label" for="rdSem1">Primero</label>
		</div>
		<div class="custom-control custom-radio">
		  <input type="radio" id="rdSem2" name="rdSem2" class="custom-control-input" value="2">
		  <label class="custom-control-label" for="rdSem2">Segundo</label>
		</div>
		<label id="SemestreValidation" class="text-white hidden">Debe seleccionar una opcion.</label>
    </div>
  </div>
  
  <div class="form-group">
    <label class="control-label col-sm-2" for="year">Año:</label>
    <div class="col-sm-6">
      <input type="number" class="form-control" id="Year" name="Year" placeholder="año" required value="<%= value.getYear() %>">
      <label id="YearValidation" class="text-white hidden">Numero no valido.</label>
    </div>
  </div>
  
   <!-- <div class="form-group">
   <label class="control-label col-sm-5" for="userType">Docente responsable</label>
   <div class="col-sm-10">
      <select id="userType" class="form-control">
        <option selected>Seleccione...</option>
        <option>Docente 1</option>
        <option>Docente 2</option>
      </select>
    </div>
  </div>	 -->
  
  <div class="form-group"> 
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" value="save" class="btn btn-success">Guardar</button>
      <button type="button" onclick="location.href = 'curso?list'" value="cancel" class="btn btn-danger">Cancelar</button>
    </div>
  </div>
</form>

<!-- Modal -->
<div class="modal fade " id="modalAlumnos" tabindex="-1" role="dialog" aria-labelledby="modalAlumnosLabel" aria-hidden="true">
  <div class="modal-dialog " role="document">
    <div class="modal-content" style="width: 600px; max-width: 600px;">
      <div class="modal-header">
        <h5 class="modal-title" id="modalAlumnosLabel">Alumnos disponibles</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table id="tablaAlms" class="table table-striped table-hover">
        	<thead class="thead-dark">
        		<tr><td></td><td>DNI</td><td>Alumno</td></tr>
        	</thead>
        	<tbody>
        		
        	</tbody>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">cerrar</button>
        <button type="button" class="btn btn-sm btn-primary" id="confMatricular">Confirmar matriculacion</button>
      </div>
    </div>
  </div>
</div>


<%@include file="Shared/bottom.jspf" %>

<script type="text/javascript">

var validateSelect = () => {
	var valid = new Array();
	if($('#Carrera').find(":selected").val() == 'Default'){
		$('#Carrera').addClass('border border-danger');
		$('#CarreraValidation').removeClass('hidden');
		valid.push(false);
	}else{
		$('#Carrera').removeClass('border border-danger');
		$('#CarreraValidation').addClass('hidden');
		valid.push(true);
	}
	if($('#Materia').find(":selected").val() == 'Default'){
		$('#Materia').addClass('border border-danger');
		$('#MateriaValidation').removeClass('hidden');
		valid.push(false);
	}else{
		$('#Materia').removeClass('border border-danger');
		$('#MateriaValidation').addClass('hidden');
		valid.push(true);
	}
	/* if($('#userType').find(":selected").val() == 'Default'){
		$('#userType').addClass('border border-danger');
		$('#userTypeValidation').removeClass('hidden');
		valid.push(false);
	}else{
		$('#userType').removeClass('border border-danger');
		$('#userTypeValidation').addClass('hidden');
		valid.push(true);
	} */
	var con = 0;
	valid.forEach((entry) => {
		entry ? con++ : false;
	})
	return con == $('select').length ? true : false;	
}

var validateChecks = () => {
	if(!$('#rdSem1').is(':checked') && !$('#rdSem2').is(':checked')) {
		$('#SemestreValidation').removeClass('hidden')
		return false;
	}
	else{
		$('#SemestreValidation').addClass('hidden');
		return true;
	}
}

var validateYear = () => {
	var curDate = new Date().getFullYear();
	if($('#Year').val() < 0) {
		$('#YearValidation').removeClass('hidden')
		return false;
	}
	else{
		$('#YearValidation').addClass('hidden');
		return true;
	}
}

var matricularAlumnos = (code) => {
	$.post('curso?code='+code, (data) => {
	
	var todo = JSON.parse(data);
		$('#tablaAlms tbody').html('');
		for(var e of todo) {
			//console.log(e);
			var tr = '<tr><td value="' + e.alumnoCode + '">' 
				+ (e.cursoCode == parseInt($('#Code').val()) && e.status == 'A' ? 
						'<input type="checkbox" value="" checked>' : 
						'<input type="checkbox" value="" unchecked>') 
				+ '</td><td value="' + e.alumnoCdoe + '"> ' + e.dni + '</td><td value="' + e.alumnoCode + '">' + e.alumnoDescripcion + 
				'</td></tr>';
			$('#tablaAlms tbody').append(tr);
		}
		$('#tablaAlms').DataTable({
			language: $lang,
			responsive: true,
			ordening: false,
			pageLength: 4,
			lengthChange: false,
			//bFilter: false, 
			bInfo: false,
			autoWidth: true,
		});
		$('#modalAlumnos').modal({backdrop: false, keyboard: false, show: true});
	});
}


$(() => {
	
	user.userType != 1 ? $('#delete').hide() : false;
	user.userType != 1 ? $(':input[type="submit"]').prop('disabled', true) : false;	
	//$('#menuActions').hide()
	<% if(value.getId() != 0) {	
		%>
			$('#Carrera').val(<%= value.getCarrera().getCode() %>);
			$('#Materia').val(<%= value.getMateria().getCode() %>);
			
			//logica para selectar el radio del semeste...
			var sem = '<%= value.getSemestre() %>';
			sem != '' ? sem == '1' ? $('#rdSem1').prop('checked', true) : $('#rdSem2').prop('checked', true) : false;
		<% 
	}%>
	
	
	$('#modalAlumnos').on('hidden.bs.modal', function () {
	    $('#tablaAlms').DataTable().destroy();
	});
	$('#modalAlumnos').on('show.bs.modal', function () {
		
		$('#modalAlumnos').css({
	        //width: '500px',
	        //'max-width': '500px',
// 	        'margin-left': function () {
// 	            return -(($(this).width() + 200) / 2);
// 	        }
		});
		$('#tablaAlms').css('width', '');
	});
	
	$('#form').on('submit', (e) => {
		e.preventDefault();
		
		if(validateSelect() && validateChecks() && validateYear()){
			$.post('curso?save', $('#rdSem1').is(':checked') ? $('#form').serialize().replace('rdSem1', 'Semestre') : $('#form').serialize().replace('rdSem2', 'Semestre'), (e) => {
 				data = JSON.parse(e);
 				if(data.status){
 					alert(data.message);
 					<%-- var retVal = confirm("Asignar alumnos al curso?");
 	                if( retVal == true ) {
 	                   matricularAlumnos(<%= value.getId()%>)
 	                } else --%>
 	                	location.href = 'curso?list=&userCode='+user.useCode+'&userType='+user.userType;
 	                
 				}else
 					alert(data.message);	
 			});	
		}
		
		<%-- if(!validateSelect() || !validateChecks() || !validateYear()){
			$('form').addClass('was-validated');
		}
 		else{
 			$.post('curso?save', $('#rdSem1').is(':checked') ? $('#form').serialize().replace('rdSem1', 'Semestre') : $('#form').serialize().replace('rdSem2', 'Semestre'), (e) => {
 				data = JSON.parse(e);
 				if(data.status){
 					alert(data.message);
 					var retVal = confirm("Asignar alumnos al curso?");
 	                if( retVal == true ) {
 	                   matricularAlumnos(<%= value.getId()%>)
 	                } else
 	                	location.href = 'curso?list';
 	                
 				}else
 					alert(data.message);	
 			});			
 		} --%>
		
	});
	
	$('#rdSem1').click(function() {
		$('#rdSem1').prop('checked', true);
		$('#rdSem2').is(':checked') ?
			$('#rdSem2').prop('checked', false) : false;
	});
	
	$('#rdSem2').click(function() {
		$('#rdSem2').prop('checked', true);
		$('#rdSem1').is(':checked') ?
			$('#rdSem1').prop('checked', false) : false;
	});
	
	$('#calificarAlmns').click(() => {
		location.href = '${pageContext.request.contextPath}/calificacion?list&userCode='+user.useCode+'&userType='+user.userType+'&currentCursoCode=<%= value.getId() %>';
	})
	
	$('#confMatricular').click(() => {
		var rows = $( $('#tablaAlms').DataTable().$('input[type="checkbox"]').map(function () {
			  return $(this).prop("checked") ? $(this).closest('tr') : null;
		}));
		var values = rows.toArray().map((e) => { return $(e).children() });
		
		var rowsUnchecked = $( $('#tablaAlms').DataTable().$('input[type="checkbox"]').map(function () {
			  return !$(this).prop("checked") ? $(this).closest('tr') : null;
		}));
		var valuesUnchecked = rowsUnchecked.toArray().map((e) => { return $(e).children() });
		
		values.forEach((dat) => {
			//console.log(dat[0].getAttribute('value'));
			$.post('alumno?alumnoCurso=&alumnoCode='+ parseInt(dat[0].getAttribute('value')) +'&cursoCode='+ parseInt($('#Code').val()), (e) => {
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
			$.post('alumno?delAlumnoCurso=&alumnoCode='+ parseInt(dat[0].getAttribute('value')) +'&cursoCode='+ parseInt($('#Code').val()), (e) => {
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
	
	$('#delete').click((e) => {		
		$.post('curso?del&Code=<%= value.getId()%>', (e) => {
			data = JSON.parse(e);
			if(data.status){
				alert(data.message);
				location.href = 'curso?list=&userCode='+user.useCode+'&userType='+user.userType;
			}else
				alert(data.message);
		});
	})
	
	<%-- <% if(value.getId() == 0) {	
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
	}%> --%>
	
});

</script>

</body>
</html>