<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'terapeutas.label', default: 'Terapeutas')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#create-terapeutas" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="Inicio"/></a></li>
                <li><g:link class="list" action="index"><g:message code="Lista de Terapeutas" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="create-terapeutas" class="content scaffold-create" role="main">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.terapeutas}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.terapeutas}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form resource="${this.terapeutas}" method="POST">
                <fieldset class="form">
                        <f:field property="tNombre" label="Nombre: "/>
                        <f:field property="tApPaterno" label="Apellido Paterno: "/>
                        <f:field property="tApMaterno" label="Apellido Materno: "/>
                        <f:field property="tMatricula" label="Matricula: "/>
                        <f:field property="tTelefono" label="Teléfono: "/>
                        <input type="hidden" name="tStatus" value="Activo"/>
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
