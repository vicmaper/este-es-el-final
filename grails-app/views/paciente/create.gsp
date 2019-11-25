<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'paciente.label', default: 'Paciente')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#create-paciente" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="Inicio"/></a></li>
                <li><g:link class="list" action="index"><g:message code="Lista de Pacientes" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="create-paciente" class="content scaffold-create" role="main">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
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
             <g:uploadForm action="save" resource="${this.paciente}" >
                        <f:field property="pNombre" label="Nombre: "/>
                        <f:field property="pApPaterno" label="Apellido Paterno: "/>
                        <f:field property="pApMaterno" label="Apellido Materno: "/>
                        <f:field property="pCurp" label="Curp: "/>
                        <f:field property="pDireccion" label="Domicilio: "/>
                        <f:field property="pTelefono" label="Teléfono: "/>
                        <f:field property="pDiagnostico" label="Diagnostico: "/>
                        <label>Fecha de nacimiento: </label><g:datePicker name="pFechaNac" precision="day"  value="${paciente?.pFechaNac}" default="none" noSelection="['': '']"relativeYears="[0..-119]"/>
                <p><label>Ine: <input type="file" name="docIne"required/></label></p>
                <p><label>Comprobante de domicilio: <input type="file" name="docComprobante" label="Comprobante de Domicilio" required/></label></p>
                <p><label>Acta de nacimiento: <input type="file" name="docActa" label="Acta de nacimiento"required/></label></p>
                <input type="submit" name="create" class="create" value="Registrar"/>
            </g:uploadForm>
        </div>
    </body>
</html>
