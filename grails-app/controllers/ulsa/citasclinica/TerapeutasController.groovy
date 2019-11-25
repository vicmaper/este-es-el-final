package ulsa.citasclinica

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN','ROLE_USUARIO'])
@Transactional(readOnly = false)
class TerapeutasController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Terapeutas.list(params), model:[terapeutasCount: Terapeutas.count()]
    }

    def show(Terapeutas terapeutas) {
        respond terapeutas
    }

    def create() {
        respond new Terapeutas(params)
    }

    @Transactional
    def save(Terapeutas terapeutas) {
        if (terapeutas == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (terapeutas.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond terapeutas.errors, view:'create'
            return
        }

        terapeutas.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'terapeutas.label', default: 'Terapeutas'), terapeutas.id])
                redirect terapeutas
            }
            '*' { respond terapeutas, [status: CREATED] }
        }
    }

    def edit(Terapeutas terapeutas) {
        respond terapeutas
    }

    @Transactional
    def update(Terapeutas terapeutas) {
        if (terapeutas == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (terapeutas.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond terapeutas.errors, view:'edit'
            return
        }

        terapeutas.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'terapeutas.label', default: 'Terapeutas'), terapeutas.id])
                redirect terapeutas
            }
            '*'{ respond terapeutas, [status: OK] }
        }
    }

    @Transactional
    def delete(Terapeutas terapeutas) {

        if (terapeutas == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        terapeutas.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'terapeutas.label', default: 'Terapeutas'), terapeutas.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'terapeutas.label', default: 'Terapeutas'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
