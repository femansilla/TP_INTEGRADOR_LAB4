<%@page import="Model.Curso" %>
<%@page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Calificaciones</title>
<%@include file="Shared/css.jspf" %>
</head>
<body>


<%@include file="Shared/top.jspf" %>

	
   <div class="form-group">
   <label class="control-label col-sm-2" for="userType">Curso</label>
   <div class="col-sm-12">
      <select id="cursoSelected" class="form-control">
        <option value="default" selected>Seleccione...</option>
        <%
     		for(Curso crs : (ArrayList<Curso>) request.getAttribute("listCurs")){
     			String semestre = crs.getSemestre() == 1 ? "Primer semestre" : "Segundo semestre";
     		%>
    				<option value="<%= crs.getId() %>"><%= String.format("%s - %s - %s - %s", crs.getCarrera().getDescripcion(), crs.getMateria().getDescripcion(), semestre, crs.getYear()) %></option>		        			
     		<% 
     		}
       	%>
      </select>
    </div>
  </div>	
<br>
<style>
#myTable input, #myTable select	{
  font-size:14px;
  padding:5px 5 5px 5px;
  display:block;
  color: black;
  width:100%;
  border:none;
  background: transparent;
  
}

#myTable input:focus,#myTable select:focus	{ outline:none; border-bottom:1px solid #757575;}
.wrapper{
   	position:relative;
}
input{
	padding-left:17px;
}
.wrapper-icon{
  	position:absolute;
    left: 70%;
	top: calc(50% - 0.5em);
}

</style>
<table id="myTable" class="display table table-striped table-hover"></table>

<!-- <div>
<button id="saveCalificacion" class="btn btn-sm btn-default hidden" title="guardar">               
    <span class="fa fa-save"></span>                                                                                                          
</button>     
<button id="editCalificacion" class="btn btn-sm btn-default " title="editar" onclick="EditEstado(' + i + ', true)">
	<span class="fa fa-pen"></span>
</button>                                                                                                                                                  
   <button id="cancelCalificacion" class="btn btn-sm btn-default hidden" title="cancelar" onclick="verPanelNuevoEstado(false)">
	<span class="fa fa-eraser"></span>                                                                                                                                                        
</button>  
</div> -->


<%@include file="Shared/bottom.jspf" %>

<script type="text/javascript">

var postValue = (value, element) => {
	if(typeof element.value != 'undefined'){
		var key = element.getAttribute('id').split('_');
		var value = element.value == '' ? 0 : element.value;
		value = element.value == 'default' ? 'null' : element.value;
		/*if(key[0] == 'estado')
			validateEstado(); */
		
		$.post('calificacion?postValue&alumnoCodeModify='+key[1]+'&cursocode='+$('#cursoSelected').val()+'&keyModify='+key[0]+'&valueModify='+value, (e) => {
			
			//debugger;
			var value = !JSON.parse(e).status;
			if(value){
				alert(JSON.parse(e).message);
				$(element.parentElement.lastElementChild).addClass('fas fa-times');
				$(element.parentElement.lastElementChild).css('color', '#FF9696');
			}else{
				$(element.parentElement.lastElementChild).addClass('fas fa-check');
				$(element.parentElement.lastElementChild).css('color', '#28a745');
			} 
		});			
	}else{
		$(element.parentElement.lastElementChild).removeClass('fas fa-check');
		//$(element.parentElement.lastElementChild).css('color', '#28a745');
		$(element.parentElement.lastElementChild).removeClass('fas fa-times');
		//$(element.parentElement.lastElementChild).css('color', '#FF9696');
	}
}

$(() => {
	var almsEstds = [];
	$.post('alumno?estados', (data) => almsEstds = JSON.parse(data).list.map((d)=> { return d }));
	
	$('#cursoSelected').change((e) => {
		var table = $('#myTable').DataTable();
		table.clear().draw();
		if(e.target.value != 'default'){
			$.post('alumno?alumnosPorCurso&cursoCode='+e.target.value, (e) => {
				var data = JSON.parse(e);
				if(data.status){
					data.list.length != 0 ?
						table.rows.add(data.list).draw() : false;					
				}else
					alert(data.message);
			});
		}
	});
	
	/* $('#editCalificacion').click(() => {
		$('#readOnly1_1').hide()
		$('#editCalificacion').hide()
		
		$('#saveCalificacion').show()
		$('#cancelCalificacion').show()
		$('#examen1_1').show()
		//$('#estado_1').show()
	});
	
	$('#cancelCalificacion').click(() => {
		$('#readOnly1_1').show()
		$('#editCalificacion').show()
		
		$('#saveCalificacion').hide()
		$('#cancelCalificacion').hide()
		$('#examen1_1').hide()
	}); */
	
	$('#myTable').DataTable({
		language: $lang,
		responsive: true,
		ordering: false,
		pageLength: 6,
		lengthChange: false,
		//bFilter: false, 
		bInfo: false,
		data: [],
		columns: [
			/*{ title: "code", 
			  data: "alumnoCode", 
			  render: (data, type, full) => {
				  if(type === 'display'){
					  var $data = $("<span></span>", { "id": 'code_' + full.alumnoCode, "value": data, text: data });
					  return $data.prop("outerHTML");					  
				  }
				  return data;
           	  }
			},*/
            { title: "Alumno", data: "alumnoDescripcion", render: (data, type, full) => {
				  if(type === 'display'){
					  var $data = $("<span></span>", { "id": 'descripcion_' + full.alumnoCode, "value": data, text: data });
					  return $data.prop("outerHTML");					  
				  }
				  return data;
           	  }
            },
            { title: "Par. 1", data: "parcial1", render: (data, type, full) => {
				  if(type === 'display'){
					  var $data = $("<div class='wrapper'><input type='number' min='1' max='10' id='parcial1_" + full.alumnoCode + "' onchange='postValue(1, this)' value='"+(data == 0 ? '' : data)+"'></input><i class='wrapper-icon' ></i></div>");
					  return $data.prop("outerHTML");					  
				  }
				  return data;
           	  }
            },
            { title: "Rec. 1", data: "recuperatorio1", render: (data, type, full) => {
				  if(type === 'display'){
					  var $data = $("<div class='wrapper'><input type='number' min='1' max='10' id='recuperatorio1_" + full.alumnoCode + "' onchange='postValue(2, this)' value='"+(data == 0 ? '' : data)+"'></input><i class='wrapper-icon' ></i></div>");
					  return $data.prop("outerHTML");					  
				  }
				  return data;
           	  } 
            },
            { title: "Par. 2", data: "parcial2", render: (data, type, full) => {
				  if(type === 'display'){
					  var $data = $("<div class='wrapper'><input type='number' min='1' max='10' id='parcial2_" + full.alumnoCode + "' onchange='postValue(3, this)' value='"+(data == 0 ? '' : data)+"'></input><i class='wrapper-icon' ></i></div>");
					  return $data.prop("outerHTML");					  
				  }
				  return data;
           	  } 
            },
            { title: "Rec. 2", data: "recuperatorio2", render: (data, type, full) => {
				  if(type === 'display'){
					  var $data = $("<div class='wrapper'><input type='number' min='1' max='10' id='recuperatorio2_" + full.alumnoCode + "' onchange='postValue(4, this)' value='"+(data == 0 ? '' : data)+"'></input><i class='wrapper-icon' ></i></div>");
					  return $data.prop("outerHTML");					  
				  }
				  return data;
           	  } 
            },
            { title: "Estado", data: "estadoCode", render: (data, type, full) => {
				  if(type === 'display'){
					  var $select = $("<select id='estado_" + full.alumnoCode +"' onchange='postValue(5, this)'></select>");
					  var $option = $("<option></option>", { "text": 'Seleccione...', "value": 'default' });
			  		  $select.append($option);
					  $.each(almsEstds, function(i,val){
						var $option = $("<option></option>", { "text": val.descripcion, "value": val.code });
						(data === val.code) ? $option.attr("selected", "selected") : false;
					    $select.append($option);
						});
	                    return "<div class='wrapper'>" + $select.prop("outerHTML") + "<i class='wrapper-icon'></i></div>";				  
				  }
				  return data;
           	  } 
            },
        ]
	});
	
	$('#myTable thead').addClass('thead-light');
	
	'<%= request.getAttribute("cursoCodeSelected") %>' != 'null' ? $('#cursoSelected').val(<%= request.getAttribute("cursoCodeSelected") %>).trigger('change') : false;
	
});
</script>

</body>
</html>