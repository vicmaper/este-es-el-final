<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cita.label', default: 'Cita')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-cita" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="Inicio"/></a></li>
                <li><g:link class="list" action="index"><g:message code="Ver Citas" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="Agendar Cita" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-cita" class="content scaffold-show" role="main">
            <h1><g:message code="Detalle de cita" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
              <fieldset align="center">
                <f:with bean="cita">
                    <p><b><label>Paciente: </label></b><f:display property="paciente"/></p>
                    <p><b><label>Fecha:</label></b><g:formatDate format="yyyy-MM-dd" date="${cita.fecha}"/></p>
                    <p><b><label>Hora:</label></b><f:display property="hora"/></p>
                    <b><label>Status:</label></b><f:display property="status"/>
                </f:with>
            </fieldset>
            <g:form resource="${this.cita}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.cita}"><g:message code="Modificar cita" default="Modificar Cita" /></g:link>
                    <g:each in="${hcitas}">
                    <g:link controller="historiaCita" action="show" params="${[id: it.id]}">Ver historia</g:link>
                </g:each>
                <sec:ifAnyGranted roles='ROLE_ADMIN'>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </sec:ifAnyGranted>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
