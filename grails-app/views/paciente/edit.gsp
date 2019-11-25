<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'paciente.label', default: 'Paciente')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#edit-paciente" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="Inicio"/></a></li>
                <li><g:link class="list" action="index"><g:message code="Lista de Pacientes" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="Registrar Nuevo Paciente" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="edit-paciente" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.paciente}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.paciente}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form resource="${this.paciente}" method="PUT">
                <g:hiddenField name="version" value="${this.paciente?.version}" />
                <fieldset class="form">

                    <p><b><label>Folio: </label></b><f:display  bean="paciente" property="id"/></p>
                    <p><b><label>Nombre: </label></b><f:display bean="paciente" property="pNombre"/></p>
                    <p><b><label>Apellido Paterno:</label></b><f:display bean="paciente" property="pApPaterno"/></p>
                    <p><b><label>Apellido Materno:</label></b><f:display bean="paciente" property="pApMaterno"/></p>
                    <p><f:field property="pDireccion" label="Direccion"/></p>
                    <p><f:field property="pTelefono"label="Teléfono"/></p>
                    <p><f:field property="pDiagnostico" label="Diagnostico"/></p>
                    <center><label>Status:</label><select name="pStatus"><option>Activo</option><option>Baja</option></select></center>
                </fieldset>
                <fieldset class="buttons">
                    <input class="save" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
