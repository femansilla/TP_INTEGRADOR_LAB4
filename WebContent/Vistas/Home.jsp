
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/Content/css/Home.css" type="text/css">

<%@include file="Shared/css.jspf" %>
</head>
<body>

<%@include file="Shared/top.jspf" %>

<div class="container">
	<div class="container-fluid">
	
	<div class="row no-gutters">
		<div class="col-3">
			<div class="card" id='cardAlumnos'>
		        <div class="card-block">
		            <div class="img-box orange" id="ListaAlumnosHome">
		                <i class="iconHome fa fa-user-graduate" aria-hidden="true"></i>
		            </div>
		            <div class="col-8 offset-4 text-right">
		                <p class="title">
		                    
		                </p>
		                <p class="value">
		                    
		                </p>
		            </div>
		        </div>
		        <div class="card-footer">
                    Alumnos
                </div>
		    </div>
		</div>
		
		<div class="col-3">
			<div class="card" id='cardCursos'>
		        <div class="card-block">
		            <div class="img-box orange">
		                <i class="iconHome fa fa-file-signature" aria-hidden="true"></i>
		            </div>
		            <div class="col-8 offset-4 text-right">
		                <p class="title">
		                    
		                </p>
		                <p class="value">
		                    
		                </p>
		            </div>
		        </div>
		        <div class="card-footer">
                   Cursos
               </div>
		    </div>
		</div>
		
		<!-- <div class="col-3">
			<div class="card">
		        <div class="card-block">
		            <div class="img-box orange">
		                <i class="iconHome fas fa-book-open" aria-hidden="true"></i>
		            </div>
		            <div class="col-8 offset-4 text-right">
		                <p class="title">
		                    
		                </p>
		                <p class="value">
		                    
		                </p>
		            </div>
		        </div>
		        <div class="card-footer">
                    Carreras
                </div>
		    </div>
		</div> -->
		
		<div class="col-3">
			<div class="card" id='cardCalificaciones'>
		        <div class="card-block">
		            <div class="img-box orange">
		                <i class="iconHome fa fa-award" aria-hidden="true"></i>
		            </div>
		            <div class="col-8 offset-4 text-right">
		                <p class="title">
		                    
		                </p>
		                <p class="value">
		                    
		                </p>
		            </div>
		        </div>
		        <div class="card-footer">
                    Calificaciones
                </div>
		    </div>
		</div>
		
		<div class="col-3">
	         <div class="card" id='cardDocentes'>
	             <div class="card-block">
	                 <div class="img-box blue">
	                     <i class="iconHome fa fa-address-card" aria-hidden="true"></i>
	                 </div>
	                 <div class="col-8 offset-4 text-right">
	                     <p class="title">
	                     </p>
	                     <p class="value">
	                         
	                     </p>
	                 </div>
	             </div>
	             <div class="card-footer">
	                 Docentes
	             </div>
	         </div>
	     </div>
	     
	</div>
	
	
    
    <!-- <div class="row no-gutters">
    <div class="col-3">
            <div class="card">
                <div class="card-block">
                    <div class="img-box green">
                        <i class="iconHome fa fa-calendar" aria-hidden="true"></i>
                    </div>
                    <div class="col-8 offset-4 text-right">
                        <p class="title">
                        </p>
                        <p class="value">
                            148
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-3">
            <div class="card">
                <div class="card-block">
                    <div class="img-box green">
                        <i class="iconHome fa fa-calendar" aria-hidden="true"></i>
                    </div>
                    <div class="col-8 offset-4 text-right">
                        <p class="title">
                        </p>
                        <p class="value">
                            148
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-3">
            <div class="card">
                <div class="card-block">
                    <div class="img-box green">
                        <i class="iconHome fa fa-calendar" aria-hidden="true"></i>
                    </div>
                    <div class="col-8 offset-4 text-right">
                        <p class="title">
                        </p>
                        <p class="value">
                            148
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-3">
            <div class="card">
                <div class="card-block">
                    <div class="img-box green">
                        <i class="iconHome fa fa-calendar" aria-hidden="true"></i>
                    </div>
                    <div class="col-8 offset-4 text-right">
                        <p class="title">
                        </p>
                        <p class="value">
                            148
                        </p>
                    </div>
                </div>
            </div>
        </div>
    
    
    </div> -->
    
    <!-- <div class="row no-gutters">   
         <div class="col-3">
            <div class="card">
                <div class="card-block">
                    <div class="img-box red">
                        <i class="iconHome fa fa-times" aria-hidden="true"></i>
                    </div>
                    <div class="col-8 offset-4 text-right">
                        <p class="title">
                        </p>
                        <p class="value">
                            87
                        </p>
                    </div>
                </div>
            </div>
        </div> 
    </div> -->
    
</div>

</div>

<%@include file="Shared/bottom.jspf" %>

</body>

<script type="text/javascript">
$(document).ready(() => {
	
})
</script>

</html>