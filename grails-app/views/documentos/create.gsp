<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'documentos.label', default: 'Documentos')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <sec:ifAnyGranted roles='ROLE_ADMIN'>
        <a href="#create-documentos" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a></sec:ifAnyGranted>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="Inicio"/></a></li>
                <li><g:link class="list" action="index"><g:message code="Lista de Documentos" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="create-documentos" class="content scaffold-create" role="main">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.documentos}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.documentos}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            

            <g:uploadForm action="save" resource="${this.documentos}" >
                        <label>Tipo de documento: </label>
                        <select name="tipoArchivo" required>
                            <option>Receta</option>
                            <option>Radiografia</option>
                            <option>Otros</option>
                        </select>
                        <input name="historiaCita" value="${c}" type="hidden" required>
                        <p><label>Seleccione documento: <input type="file" name="docS" required/></label></p>
                <input type="submit" name="create" class="create" label="Registrar"/>
            </g:uploadForm>

        </div>
    </body>
</html>
