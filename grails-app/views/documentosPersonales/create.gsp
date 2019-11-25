<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'documentosPersonales.label', default: 'DocumentosPersonales')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#create-documentosPersonales" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="create-documentosPersonales" class="content scaffold-create" role="main">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.documentosPersonales}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.documentosPersonales}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <!--<g:form resource="${this.documentosPersonales}" method="POST">
                <fieldset class="form">
                    <f:all bean="documentosPersonales"/>
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </fieldset>
            </g:form>-->

           <g:uploadForm action="save" resource="${this.documentosPersonales}" >
                        <f:field property="pacient.id" value="1"/>
                        <f:field property="docUrlIne" value="hola"/>
                        <f:field property="docUrlActa" value="hola2"/>
                        <f:field property="docUrlComprobante" value="hola3"/>
                <input type="file" name="docIne"/>
                <input type="file" name="docComprobante"/>
                <input type="file" name="docActa"/>
                <input type="submit" name="create" class="save"/>
            </g:uploadForm>
        </div>
    </body>
</html>
