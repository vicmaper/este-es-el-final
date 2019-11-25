package ulsa.citasclinica
import ulsa.citasclinica.Paciente
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN','ROLE_USUARIO'])
@Transactional(readOnly = true)
class DocumentosPersonalesController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DocumentosPersonales.list(params), model:[documentosPersonalesCount: DocumentosPersonales.count()]
    }

    def show(DocumentosPersonales documentosPersonales) {
        respond documentosPersonales
    }

    def create() {
        respond new DocumentosPersonales(params)
    }

    def upload() {
    def f = request.getFile('docUrlIne')
    if (f.empty) {
        flash.message = 'file cannot be empty'
        render(view: 'uploadForm')
        return
    }

    f.transferTo(new File('C:/Users/Victor/Desktop/documentosp/nuevo.pdf'))
    response.sendError(200, 'Done')
}

    @Transactional
    def save(DocumentosPersonales documentosPersonales) {
       
       if (documentosPersonales == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (documentosPersonales.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond documentosPersonales.errors, view:'create'
            return
        }

        def f = request.getFile('docIne')
        def fa = request.getFile('docActa')
        def fc = request.getFile('docComprobante')
        if (f.empty || f == null) {
            flash.message = 'Ingrese pdf de Ine'
            //println f + "falla"
            return
        }
        if (fa.empty || fa == null){
            flash.message = "Ingrese acta"
            //println fa + "falla"
            return
        }
        if (fc.empty || fc == null){
            flash.message="ingrese comprobante"
            //println fc + "falla"
            return
        }

        f.transferTo(new File('/home/ingenierias/proyecto_fisioterapia/nuevoine.pdf'))
        fa.transferTo(new File('/home/ingenierias/proyecto_fisioterapia/nuevoacta.pdf'))
        fc.transferTo(new File('/home/ingenierias/proyecto_fisioterapia/nuevocomprobante.pdf'))


        
        documentosPersonales.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'documentosPersonales.label', default: 'DocumentosPersonales'), documentosPersonales.id])
                redirect documentosPersonales
            }
            '*' { respond documentosPersonales, [status: CREATED] }
        }
    }

    def edit(DocumentosPersonales documentosPersonales) {
        respond documentosPersonales
    }

    @Transactional
    def update(DocumentosPersonales documentosPersonales) {
        if (documentosPersonales == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (documentosPersonales.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond documentosPersonales.errors, view:'edit'
            return
        }

        documentosPersonales.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'documentosPersonales.label', default: 'DocumentosPersonales'), documentosPersonales.id])
                redirect documentosPersonales
            }
            '*'{ respond documentosPersonales, [status: OK] }
        }
    }

    @Transactional
    def delete(DocumentosPersonales documentosPersonales) {

        if (documentosPersonales == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        documentosPersonales.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'documentosPersonales.label', default: 'DocumentosPersonales'), documentosPersonales.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'documentosPersonales.label', default: 'DocumentosPersonales'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
