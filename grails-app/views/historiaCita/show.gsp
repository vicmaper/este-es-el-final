<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'historiaCita.label', default: 'HistoriaCita')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-historiaCita" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="Inicio"/></a></li>
                <li><g:link class="list" action="index"><g:message code="Lista de Historiales" args="[entityName]" /></g:link></li>
                <sec:ifAnyGranted roles='ROLE_ADMIN'>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li></sec:ifAnyGranted>
            </ul>
        </div>
        <div id="show-historiaCita" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <fieldset class="form">
                <label>Terapeuta</label><f:display bean="historiaCita" property="terapeuta"/>
                <p><label>S: </label><f:display bean="historiaCita" property="s"/></p>
                <p><label>O: </label><f:display bean="historiaCita" property="o"/></p>
                <p><label>A: </label><f:display bean="historiaCita" property="a"/></p>
                <p><label>P: </label><f:display bean="historiaCita" property="p"/></p>
            </fieldset>
            <g:form resource="${this.historiaCita}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.historiaCita}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <sec:ifAnyGranted roles='ROLE_ADMIN'>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </sec:ifAnyGranted>
                    <g:link action="historiadecita" resource="${this.historiaCita}" target="_blank">Ver</g:link>
                    <g:link controller="documentos" action="create" params="${[historiaCita: this.historiaCita.id]}">Agregar documentos</g:link>
                </fieldset>
            </g:form>
        </div>
        <div>
            <table id="tablita" class="display" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>Documento</th>
                        <th>Tipo</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${archivos}">
                    <tr><td>
                        <g:link action="visualizacion" params="${[docUrl: it.docUrl]}" target="_blank">
                            Ver Documento
                            </g:link></td>
                        <td>${it.tipoArchivo}</td>
                    </tr>
                    </g:each>
                </tbody>
            </table>
        </div>
    </body>
</html>
