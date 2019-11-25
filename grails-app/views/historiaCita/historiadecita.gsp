<!DOCTYPE html>
<html>
<body>
	<h1>Historia de cita</h1>
	<g:if test="${historiaCita!= null}">
	<g:each in="${historiaCita}">
		<p><label>Fecha: ${citas[0].format("yyyy-MM-dd")}</label>
		<p><label>Terapeuta: ${it.terapeuta}</label></p>
		<p><label>S: ${it.s}</label></p>
		<p><label>O: ${it.o}</label></p>
		<p><label>A: ${it.a}</label></p>
		<p><label>P: ${it.p}</label></p>
	</g:each>
	</g:if>
</body>
</html>