<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <g:set var="entityName" value="${message(code: 'cita.label', default: 'Cita')}" />
        <title><g:message code="Agendar cita" args="[entityName]" /></title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:javascript src="application.js"/>
    <asset:stylesheet src="application.css"/>
    
    <asset:stylesheet src="all.css"/>
    <asset:stylesheet src="fullcalendar/core/main.css"/>
    <asset:stylesheet src="fullcalendar/daygrid/main.css"/>
    
    <asset:javascript src="jquery-1.12.4.js"/>
    <asset:javascript src="fullcalendar/core/main.js" />
    <asset:javascript src="fullcalendar/daygrid/main.js" />



    <style>
      span .fc-icon{
        color:white;
      }
        body {
            background: #E6E6E6;
        }
        footer {
            background: #1B1464;
        }
        nav {
            background: #1B1464;
            color: #008000;
        }
        .fc-scroller{
          overflow-y: hidden !important;
        }
        #se{
            padding: left;    
        }

        #b {
         padding: 0;
         margin: 0;
         
             background-color: #1B1464;
        }
        #b li {
         display: inline-block;
         }
             #b li a {
             font-family: Arial;
             font-size: 11px;
             text-decoration: none;
             float: left;
             padding: 10px;
             background-color: #1B1464;
             color: #fff;
         }
         #b li a:hover {
         background-color: #1B1464;
         margin-top: -2;
         padding-bottom: 12px;]
         }

    </style>

    <script type="text/javascript">
 
    document.addEventListener('DOMContentLoaded', function() {


  var calendarEl = document.getElementById('calendar');


  var calendar = new FullCalendar.Calendar(calendarEl, {
    plugins: [ 'dayGrid' ],
    defaultView: 'dayGridMonth',
    height: "auto", locale: 'es',
    eventColor: 'red', aspectRatio: 4,
    eventSources: [

    // your event source
    {
      url: '/ocupadas/index', // use the `url` property
    }

    // any other sources...

  ]
  });

  calendar.render();
  $('.fc-today-button').text('Hoy');

  $('span.fc-icon-chevron-left').text('<');
  $('span.fc-icon-chevron-left').removeClass('fc-icon-chevron-left');
  
  $('span.fc-icon-chevron-right').text('>');
  $('span.fc-icon-chevron-right').removeClass('fc-icon-chevron-right');
});


    </script>


    </head>
    <body>

                <sec:ifAnyGranted roles='ROLE_ADMIN'>
            <ul id="b">
                <li>
                    <a href="${createLink(uri: '/Cita')}">Citas</a>
                </li>
                <li >
                    <a href="${createLink(uri: '/Documentos')}">Documentos</a>
                </li>
                <li>
                    <a href="${createLink(uri: '/HistoriaCita')}">Historia Cita</a>
                </li>
                  <li>
                        <a href="${createLink(uri: '/Paciente')}">Paciente</a>
                    </li>
                    <li>
                        <a href="${createLink(uri: '/Terapeutas')}">Terapeutas</a>
                    </li>
                <li>
                        <a href="${createLink(uri: '/')}">Inicio</a>
                    </li>
                     <li>
                        <a href="logoff">Salir</a>
                    </li>
            </ul>
    </sec:ifAnyGranted>
    <sec:ifAnyGranted roles='ROLE_USUARIO'>
            <ul id="b">
                <li>
                    <a href="${createLink(uri: '/Cita')}">Citas</a>
                </li>
                  <li>
                        <a href="${createLink(uri: '/Paciente')}">Paciente</a>
                    </li>
                    <li>
                        <a href="${createLink(uri: '/Terapeutas')}">Terapeutas</a>
                    </li>
                <li>
                        <a href="${createLink(uri: '/')}">Inicio</a>
                    </li>
                     <li>
                        <a href="logoff">Salir</a>
                    </li>
            </ul>

    </sec:ifAnyGranted>

    


        <center><div id='calendar' style="width: 80%; display: inline-block;"></div></center>

        <a href="#create-cita" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><g:link class="list" action="index"><g:message code="Lista de citas" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="create-cita" class="content scaffold-create" role="main">
            <h1><g:message code="Datos de la cita" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.cita}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.cita}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:uploadForm action="save" resource="${this.agendar}">
                        <table>
                        <thead>
                        <tr>
                        <th>Paciente
                        </th>
                        <th>
                          Fecha
                        </th>
                      </tr>
                      </thead>
                      <tbody>
                        <td>
                        <label>Folio del paciente</label><input type="text" name="paciente"/>
                        </td>
                        <td>
                        <label>Dia</label><select id="dia" name="dia" onchange="categoryChanged()">
                          <option value="01">01</option>
                          <option value="02">02</option>
                          <option value="03">03</option>
                          <option value="04">04</option>
                          <option value="05">05</option>
                          <option value="06">06</option>
                          <option value="07">07</option>
                          <option value="08">08</option>
                          <option value="09">09</option>
                          <option value="10">10</option>
                          <option value="11">11</option>
                          <option value="12">12</option>
                          <option value="13">13</option>
                          <option value="14">14</option>
                          <option value="15">15</option>
                          <option value="16">16</option>
                          <option value="17">17</option>
                          <option value="18">18</option>
                          <option value="19">19</option>
                          <option value="20">20</option>
                          <option value="21">21</option>
                          <option value="22">22</option>
                          <option value="23">23</option>
                          <option value="24">24</option>
                          <option value="25">25</option>
                          <option value="26">26</option>
                          <option value="27">27</option>
                          <option value="28">28</option>
                          <option value="29">29</option>
                          <option value="30">30</option>
                          <option value="31">31</option>
                        </select>
                        <label>Mes</label><select id="mes" name="mes" onchange="categoryChanged()">
                          <option value="01">Enero</option>
                          <option value="02">Febrero</option>
                          <option value="03">Marzo</option>
                          <option value="04">Abril</option>
                          <option value="05">Mayo</option>
                          <option value="06">Junio</option>
                          <option value="07">Julio</option>
                          <option value="08">Agosto</option>
                          <option value="09">Septiembre</option>
                          <option value="10">Octubre</option>
                          <option value="11">Noviembre</option>
                          <option value="12">Diciembre</option>
                        </select>
                        <label>Año</label><select id="an" name="an" onchange="categoryChanged()">
                          <option value="2019">2019</option>
                          <option value="2020">2020</option>
                        </select>
                        <!--<g:datePicker id=
                        "fecha" name="fecha" precision="day"  value="${agendar?.fecha}" default="none"  relativeYears="[0..2]"/>-->

                        <label>Hora: </label><g:select name="hora" id="hora" from=""/>
                      </td>
                      <td>
                        <input type="submit" name="create" class="create" value="Registrar cita" align="center"/>
                
                      </td>
                    </tbody>
                       </table>
              </table>
            </g:uploadForm>
        </div>
         <footer class="page-footer font-small blue pt-4 mt-4"><center>Desarrollado en la universidad la Salle Oaxaca</center></footer>
        <script type="text/javascript">
         


          function categoryChanged(){
            var x = document.getElementById("dia").value
                  var y = document.getElementById("mes").value
                  var z = document.getElementById("an").value
                  var fecha = z+"-"+y+"-"+x 
          $.post("${g.createLink(action: 'categoryChanged')}", {categoryId: fecha}, function(result) {
              $("#hora").replaceWith(result);
          }); 
        }


        </script>
    </body>
</html>
