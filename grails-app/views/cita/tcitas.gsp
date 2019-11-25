<!DOCTYPE html>
<html>
    <head>
            <script type="text/javascript">
        $(document).ready(function() {
            var t = $('#tablita').DataTable({
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
        <g:set var="entityName" value="${message(code: 'cita.label', default: 'Cita')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#list-cita" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
        </div>
        <table id="tablita" class="display" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>id</th>
                        <th>No. Paciente</th>
                        <th>Fecha</th>
                        <th>Hora</th>
                        <th>opciones</th>
                        <th>status</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${ulsa.citasclinica.Cita.list()}">
                    <tr>
                        <td>
                            <g:link action="show" params="${[id: it.id]}">
                            ${it.id}
                            </g:link>
                        </td>
                        <td>${it.paciente}</td>
                        <td>${it.fecha.format("yyyy-MM-dd")}</td>
                        <td>${it.hora}</td>
                        <td>${it.status}</td>
                        
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