<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'terapeutas.label', default: 'Terapeutas')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
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
    </head>
    <body>
        <a href="#list-terapeutas" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="Inicio"/></a></li>
                <li><g:link class="create" action="create"><g:message code="Registar Terapeuta" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-terapeutas" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table id="tablita" class="display" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>Matricula</th>
                        <th>Nombre</th>
                        <th>Apellido P</th>
                        <th>Apellido M</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${ulsa.citasclinica.Terapeutas.list()}">
                    <tr>
                        <td>
                            <g:link action="show" params="${[id: it.id]}">
                            ${it.tMatricula}
                            </g:link>
                        </td>
                        <td>${it.tNombre}</td>
                        <td>${it.tApPaterno}</td>
                        <td>${it.tApMaterno}</td>
                        <td>${it.tStatus}</td>    
                    </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="pagination">
                <g:paginate total="${terapeutasCount ?: 0}" />
            </div>
        </div>
    </body>
</html>