<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<link rel="stylesheet" href="../Content/css/Login.css" type="text/css">

<%@include file="Shared/css.jspf" %>
</head>
<body>

<%@include file="Shared/top.jspf" %>

<br><br>

<div class="body text-center">
	<form action="../usuario" method="POST" id='loginForm' class="form-signin">
	  <img class="mb-4" src="../Resources/Images/account.png" alt="" width="150px" height="150px">
	  <label for="inputUser" class="sr-only">Usuario</label>
	  <input name="inputUser" type="text" id="inputUser" class="form-control" placeholder="Usuario" required="" autofocus>
	  <label for="inputPassword" class="sr-only">Contraseña</label>
	  <input name="inputPassword" type="password" id="inputPassword" class="form-control" placeholder="Contraseña" required="">
	  
	  <div id="errorMsg" class="text-danger hidden">Usuario o contraseña invalido, verifique por favor</div>
	  <div class="checkbox mb-3">
	    <!-- <label>
	      <input type="checkbox" value="remember-me"> Recordarme
	    </label> -->
	  </div>
	  <button id="btnAceptar" name="btnAceptar" value="Aceptar" class="btn btn-lg btn-info btn-block" type="button">Ingresar</button>
	</form>
</div>

<%@include file="Shared/bottom.jspf" %>


	
	<script type="text/javascript">
		if('${sessionScope.valid}' != ''){
			if('${sessionScope.valid}' == 'true'){
				$('#errorMsg').removeClass('hidden');				
			}			
		}
	</script>


<script>

$(() => {
	window.location.pathname.includes('Login') ? $('.header').hide() : false;
	
	'<%= request.getAttribute("valid") %>' == 'fasle' ? $('#errorMsg').removeClass('hidden') : false;
	
	$('#form').on('submit', (e) => {
		
	});
	
	$(document).keypress((e) => {
		e.keyCode == 13 ? $('#btnAceptar').click() : false;
	});
		
	$('#btnAceptar').click((e) => {
 		$.post('../usuario?btnAceptar&inputUser='+$('#inputUser').val()+'&inputPassword='+$('#inputPassword').val() , (data) => {
			var a = JSON.parse(data);
			!a.valid ?  $('#errorMsg').removeClass('hidden') : location.href = '../Vistas/Home.jsp';
 		});	
	})
})

</script>

</body>

</html>