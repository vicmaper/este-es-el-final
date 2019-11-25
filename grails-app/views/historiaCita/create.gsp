<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'historiaCita.label', default: 'HistoriaCita')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <script>
    document.addEventListener('DOMContentLoaded', function() {
         $.post("${g.createLink(action: 'terapeutasF')}", function(result) {
              $("#tera").replaceWith(result);
          }); 
    )};
    </script>
    <body>
        <a href="#create-historiaCita" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="Inicio"/></a></li>
                 <sec:ifAnyGranted roles='ROLE_ADMIN'>
                <li><g:link class="list" action="index"><g:message code="Listado de Historias" args="[entityName]" /></g:link></li></sec:ifAnyGranted>
            </ul>
        </div>
        <div id="create-historiaCita" class="content scaffold-create" role="main">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.historiaCita}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.historiaCita}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
        

            <g:uploadForm action="save" resource="${this.historiaCita}" >
                        <p><label>S: </label><textarea name="s" required></textarea></p>
                        <p><label>O: </label><textarea name="o" required></textarea></p>
                        <p><label>A: </label><textarea name="a" required></textarea></p>
                        <p><label>P: </label><textarea name="p" required></textarea></p>
                        <p><label>Terapeuta</label><g:select name="terapeuta" id="tera" from="${sub}"/></p>
                        <input type="hidden" name="citas" value="${c}">
                <input type="submit" name="create" class="create" label="Registrar"/>
            </g:uploadForm>
            
        </div>
    </body>
</html>
