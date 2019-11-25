<!DOCTYPE html>
<html>
<body>
	<h1>Historial de paciente</h1>
	<g:if test="${hist != null}">
	<g:each in="${hist}">
		<p><label>Fecha ${it[1].format("yyyy-MM-dd")}</label></p>
		<p><label>Terapeuta: ${it[0].terapeuta}</label></p>
		<p><label>S: ${it[0].s}</label></p>
		<p><label>O: ${it[0].o}</label></p>
		<p><label>A: ${it[0].a}</label></p>
		<p><label>P: ${it[0].p}</label></p>
	</g:each>
	</g:if>
	<g:if test="${hist == null}">
		<h4>Historial clínico vacio.</h4>
	</g:if>
</body>
</html>