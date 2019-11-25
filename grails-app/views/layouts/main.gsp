<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
 <g:layoutTitle default="Grails"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <asset:stylesheet src="application.css"/>
    <asset:stylesheet src="bootstrap.css"/>
    <asset:stylesheet src="datatables.css"/>
    
    <asset:javascript src="jquery-1.12.4.js"/>
    <asset:javascript src="popper.min.js"/>
    <asset:javascript src="bootstrap.min.js"/>
    <asset:javascript src="miLibreria.js"/>
    <asset:javascript src="datatables.js"/>
    <g:layoutHead/>
    <style>
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
</head>
<body>
        <sec:ifLoggedIn>
        
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
                        <a href="/logoff">Salir</a>
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
                        <a href="/logoff">Salir</a>
                    </li>
            </ul>

    </sec:ifAnyGranted>
    </sec:ifLoggedIn>
    <g:layoutBody/>

    <sec:ifLoggedIn>
    <footer class="page-footer font-small blue pt-4 mt-4"><center>Desarrollado en la universidad la Salle Oaxaca</center></footer>
    </sec:ifLoggedIn>
</body>
</html>
