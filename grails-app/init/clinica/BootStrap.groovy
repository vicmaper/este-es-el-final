package clinica
import ulsa.citasclinica.*
class BootStrap {

    def init = { servletContext ->

    	def rolAdmin = new Rol(authority: 'ROLE_ADMIN').save()
    	def rolUsuario = new Rol(authority: 'ROLE_USUARIO').save()

    	def usuAdmin = new Usuario(username: 'super', password: 'prr123ul').save()
    	def usuSis = new Usuario(username: 'admin', password: 'prr2019ul').save()

    	UsuarioRol.create usuAdmin, rolAdmin
    	UsuarioRol.create usuSis, rolUsuario

    	UsuarioRol.withSession {
    		it.flush()
    		it.clear()
    	}
    }
    def destroy = {
    }
}
