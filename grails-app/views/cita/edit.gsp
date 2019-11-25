<!DOCTYPE html>
<html>
    <head>
        
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cita.label', default: 'Cita')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#edit-cita" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="Inicio"/></a></li>
                <li><g:link class="list" action="index"><g:message code="Ver Citas" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="Agendar Cita" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="edit-cita" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.cita}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.cita}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form resource="${this.cita}" method="PUT">
                <g:hiddenField name="version" value="${this.cita?.version}" />
                <fieldset class="form">
                    <p><b><label>Paciente: </label></b><f:display bean="cita" property="paciente"/></p>
                    <p><b><label>Fecha:</label></b><g:formatDate bean="cita" format="yyyy-MM-dd" date="${cita.fecha}"/></p>
                    <p><b><label>Hora:</label></b><f:display bean="cita" property="hora"/></p>
                    <b><label>Status:</label></b><select name="status"><option>Agendada</option><option>Cancelada</option><option>Tomada</option></select>
                </fieldset>
                <fieldset class="buttons">
                    <input class="save" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
