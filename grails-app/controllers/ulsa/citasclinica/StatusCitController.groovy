package ulsa.citasclinica

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN','ROLE_USUARIO'])
@Transactional(readOnly = false)
class StatusCitController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond StatusCit.list(params), model:[statusCitCount: StatusCit.count()]
    }

    def show(StatusCit statusCit) {
        respond statusCit
    }

    def create() {
        respond new StatusCit(params)
    }

    @Transactional
    def save(StatusCit statusCit) {
        if (statusCit == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (statusCit.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond statusCit.errors, view:'create'
            return
        }

        statusCit.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'statusCit.label', default: 'StatusCit'), statusCit.id])
                redirect statusCit
            }
            '*' { respond statusCit, [status: CREATED] }
        }
    }

    def edit(StatusCit statusCit) {
        respond statusCit
    }

    @Transactional
    def update(StatusCit statusCit) {
        if (statusCit == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (statusCit.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond statusCit.errors, view:'edit'
            return
        }

        statusCit.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'statusCit.label', default: 'StatusCit'), statusCit.id])
                redirect statusCit
            }
            '*'{ respond statusCit, [status: OK] }
        }
    }

    @Transactional
    def delete(StatusCit statusCit) {

        if (statusCit == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        statusCit.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'statusCit.label', default: 'StatusCit'), statusCit.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'statusCit.label', default: 'StatusCit'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
