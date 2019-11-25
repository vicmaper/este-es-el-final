package ulsa.citasclinica
import ulsa.citasclinica.TipoArchivo
import ulsa.citasclinica.HistoriaCita
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN','ROLE_USUARIO'])
@Transactional(readOnly = false)

class DocumentosController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]


    def download(String url) {
        render file: new File (url)
    }

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Documentos.list(params), model:[documentosCount: Documentos.count()]
    }

    def show(Documentos documentos) {
        respond documentos
    }

    def create(HistoriaCita historiaCita) {
        //println params.historiaCita
        if(params.historiaCita!=null){
            //println params.historiaCita
            def c = params.historiaCita
            [c:c]
        }
    }

    @Transactional
    def save(Documentos documentos) {


        if (documentos == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (documentos.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond documentos.errors, view:'create'
            return
        }
        def f = request.getFile('docS')
        Integer n = 1
        Integer o = 0
        //String urr = "C:/Users/Victor/Desktop/clinica/documentosCita/"

        //String urlB = servletContext.getRealPath("/")
        String urlB = "/home/ingenierias/proyecto_fisioterapia/archivos/"
        String docs = urlB +"archivosCitas\\"+ params.historiaCita.toString() + "d1.pdf"
        def l = Documentos.findAll("from Documentos where historiaCita ="+params.historiaCita)
        //println docs
        String doc = urlB+"archivosCitas\\" + params.historiaCita.toString() + "d1.pdf"

        for(Integer g=0;g<l.size;g++){
            if(l[g].docUrl==doc){
                n++
                //println "url = " +l[g].docUrl
                doc = urlB +"archivosCitas\\"+ params.historiaCita.toString() +"d"+n+ ".pdf"
                //println doc
            }
        }
        f.transferTo(new File(doc))
        //print doc
        documentos.docUrl=doc
        documentos.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'documentos.label', default: 'Documentos'), documentos.id])
                redirect documentos
            }
            '*' { respond documentos, [status: CREATED] }
        }
    }

    def edit(Documentos documentos) {
        respond documentos
    }

    @Transactional
    def update(Documentos documentos) {
        if (documentos == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (documentos.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond documentos.errors, view:'edit'
            return
        }

        documentos.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'documentos.label', default: 'Documentos'), documentos.id])
                redirect documentos
            }
            '*'{ respond documentos, [status: OK] }
        }
    }

    @Transactional
    def delete(Documentos documentos) {

        if (documentos == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        documentos.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'documentos.label', default: 'Documentos'), documentos.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'documentos.label', default: 'Documentos'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
