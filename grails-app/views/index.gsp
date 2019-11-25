<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Fisio historia</title>

    <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
</head>
<body>
    <sec:ifLoggedIn>
    <div id="content" role="main">
        <center><g:img dir="images" file="clinica.jpeg" width="826.8" height="534"/></center>
            <!-- <div id="controllers" role="navigation">
                <h2>Available Controllers:</h2>
                <ul>
                    <g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName } }">
                        <li class="controller">
                            <g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link>
                        </li>
                    </g:each>
                </ul>
            </div> -->
            <br>
            </br>
        </sec:ifLoggedIn>
        <p>
            <sec:ifNotLoggedIn>
            <div align="center">
                <form action="/login" method="POST" id="loginForm" class="cssform" autocomplete="off">
                <h1>INGRESE AQUÍ</h1>
                <p>
                <g:link action="index">
                    <input type="submit" name="ingresar" value="Ingresar"/>
                </g:link>
                </p>
                </form>
            </div>
            </sec:ifNotLoggedIn>
            </p>
        </section>
    </div>
</body>
</html>
