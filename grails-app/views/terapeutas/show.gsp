<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'terapeutas.label', default: 'Terapeutas')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-terapeutas" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="Inicio"/></a></li>
                <li><g:link class="list" action="index"><g:message code="Lista Terapeutas" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="Registrar Terapeuta" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-terapeutas" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>

            <fieldset align="center">
                <f:with bean="terapeutas">

                    <p><b><label>Matricula: </label></b><f:display property="tMatricula"/></p>
                    <p><b><label>Nombre: </label></b><f:display property="tNombre"/></p>
                    <p><b><label>Apellido Paterno:</label></b><f:display property="tApPaterno"/></p>
                    <p><b><label>Apellido Materno:</label></b><f:display property="tApMaterno"/></p>
                    <p><b><label>Teléfono:</label></b><f:display property="tTelefono"/></p>
                    <p><b><label>Status: </label></b><f:display property="tStatus"/></p>
                </f:with>
            </fieldset>



            <g:form resource="${this.terapeutas}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.terapeutas}"><g:message code="Editar Terapeuta"/></g:link>
                    <sec:ifAnyGranted roles='ROLE_ADMIN'>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </sec:ifAnyGranted>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
