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
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#list-paciente" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="Inicio"/></a></li>
                <li><g:link class="create" action="create"><g:message code="Registrar paciente" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <table id="tablita" class="display" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>No. Paciente</th>
                        <th>Nombre</th>
                        <th>Apellido Paterno</th>
                        <th>Apellido Materno</th>
                        <th>Curp</th>
                        <th>Teléfono</th>
                        <th>Status</th>
                        <th>opciones</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${ulsa.citasclinica.Paciente.list()}">
                    <tr>
                        <td>
                            <g:link action="show" params="${[id: it.id]}">
                            ${it.id}
                            </g:link>
                        </td>
                        <td>${it.pNombre}</td>
                        <td>${it.pApPaterno}</td>
                        <td>${it.pApMaterno}</td>
                        <td>${it.pCurp}</td>
                        <td>${it.pTelefono}</td>
                        <td>${it.pStatus}</td>
                        <td>
                            <g:link action="show" params="${[id: it.id]}">
                            Ver
                            </g:link>
                        </td>
                        
                    </tr>
                    </g:each>
                </tbody>
            </table>
        </div>
    </body>
</html>