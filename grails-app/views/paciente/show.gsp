<!DOCTYPE html>
<html>
    <head>
           <script type="text/javascript">
        $(document).ready(function() {
            $('#tablita').DataTable({
                "language": {
            "sProcessing":     "Procesando...",
                "sLengthMenu":     "Mostrar _MENU_ registros",
                "sZeroRecords":    "No se encontraron resultados",
                "sEmptyTable":     "Ningún dato disponible en esta tabla =(",
                "sInfo":           "Registro de _START_ al _END_ de un total de _TOTAL_ registros",
                "sInfoEmpty":      "No hay registros",
                "sInfoFiltered":   "(filtrado de _MAX_ registros)",
                "sInfoPostFix":    "",
                "sSearch":         "Buscar:",
                "sUrl":            "",
                "sInfoThousands":  ",",
                "sLoadingRecords": "Cargando...",
                "oPaginate": {
                    "sFirst":    "Primero",
                    "sLast":     "Último",
                    "sNext":     "Siguiente",
                    "sPrevious": "Anterior"
                },
                "oAria": {
                    "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
                    "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                },
                "buttons": {
                    "copy": "Copiar",
                    "colvis": "Visibilidad"
                }
        }
            });
        });
    </script>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'paciente.label', default: 'Paciente')}" />
        <title><g:message code="Perfil paciente" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-paciente" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><g:link class="list" action="index"><g:message code="Lista de pacientes" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="Registrar nuevo paciente" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-paciente" class="content scaffold-show" role="main">
            <h1><g:message code="Datos del paciente" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <fieldset align="center">
                <f:with bean="paciente">

                    <p><b><label>Folio: </label></b><f:display property="id"/></p>
                    <p><b><label>Nombre: </label></b><f:display property="pNombre"/></p>
                    <p><b><label>Apellido Paterno:</label></b><f:display property="pApPaterno"/></p>
                    <p><b><label>Apellido Materno:</label></b><f:display property="pApMaterno"/></p>
                    <p><b><label>Fecha de Nacimiento:</label></b><g:formatDate format="yyyy-MM-dd" date="${paciente.pFechaNac}"/></p>
                    <p><b><label>Curp: </label></b><f:display property="pCurp"/></p>
                    <p><b><label>Dirección: </label></b><f:display property="pDireccion"/></p>
                    <p><b><label>Teléfono: </label></b><f:display property="pTelefono"/></p>
                    <p><b><label>Diagnostico: </label></b><f:display property="pDiagnostico"/></p>
                    <p><b><label>Ine</label></b><g:link action="visualizacion" params="${[docUrl: paciente.urlIne]}" target="_blank" property="${urlIne}">Ver Documento
                            </g:link></p>
                    <p><b><label>Comprobante de Domicilio: </label></b><g:link action="visualizacion" params="${[docUrl: paciente.urlComp]}" target="_blank" property="${urlComp}">Ver Documento
                            </g:link></p>
                    <p><b><label>Acta de Nacimiento: </label></b><g:link action="visualizacion" params="${[docUrl: paciente.urlActa]}" target="_blank" property="${urlActa}">Ver Documento
                            </g:link></p>
                    <b><label>Status:</label></b><f:display property="pStatus"/>
                </f:with>
            </fieldset>

            
            <g:form resource="${this.paciente}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.paciente}"><g:message code="Modificar Datos del Paciente" /></g:link>
                    <sec:ifAnyGranted roles='ROLE_ADMIN'>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    </sec:ifAnyGranted>
                    <g:link action="historialpaciente" resource="${this.paciente}" target="_blank">Ver historias</g:link>
                </fieldset>
           </g:form>
        </div>
    <table id="tablita" class="display" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>No. id</th>
                        <th>fecha</th>
                        <th>hora</th>
                        <th>status</th>
                        <th>opcion</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${citas}">
                    <tr>
                        <td>
                            <g:link controller="cita" action="show" params="${[id: it.id]}">
                            ${it.id}
                            </g:link>
                        </td>
                        <td>${it.fecha.format("yyyy-MM-dd")}</td>
                        <td>${it.hora}</td>
                        <td>${it.status}</td>
                        <td>
                            <g:if test="${it.status== 'Agendada'}">
                                <g:link controller="historiaCita" action="create" params="${[id: it.id]}">
                                Tomar cita
                                </g:link>
                            </g:if>
                            <g:if test="${it.status== 'Tomada'}">
                                 <g:link controller="cita" action="show" params="${[id: it.id]}">
                                Ver cita
                                </g:link>
                            </g:if>
                        </td>
                    </tr>
                    </g:each>
                </tbody>
            </table>    

    </body>
</html>
