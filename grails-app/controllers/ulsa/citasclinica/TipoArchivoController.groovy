package ulsa.citasclinica

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN','ROLE_USUARIO'])
@Transactional(readOnly = true)
class TipoArchivoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TipoArchivo.list(params), model:[tipoArchivoCount: TipoArchivo.count()]
    }

    def show(TipoArchivo tipoArchivo) {
        respond tipoArchivo
    }

    def create() {
        respond new TipoArchivo(params)
    }

    @Transactional
    def save(TipoArchivo tipoArchivo) {
        if (tipoArchivo == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (tipoArchivo.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond tipoArchivo.errors, view:'create'
            return
        }

        tipoArchivo.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'tipoArchivo.label', default: 'TipoArchivo'), tipoArchivo.id])
                redirect tipoArchivo
            }
            '*' { respond tipoArchivo, [status: CREATED] }
        }
    }

    def edit(TipoArchivo tipoArchivo) {
        respond tipoArchivo
    }

    @Transactional
    def update(TipoArchivo tipoArchivo) {
        if (tipoArchivo == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (tipoArchivo.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond tipoArchivo.errors, view:'edit'
            return
        }

        tipoArchivo.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'tipoArchivo.label', default: 'TipoArchivo'), tipoArchivo.id])
                redirect tipoArchivo
            }
            '*'{ respond tipoArchivo, [status: OK] }
        }
    }

    @Transactional
    def delete(TipoArchivo tipoArchivo) {

        if (tipoArchivo == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        tipoArchivo.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'tipoArchivo.label', default: 'TipoArchivo'), tipoArchivo.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'tipoArchivo.label', default: 'TipoArchivo'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
