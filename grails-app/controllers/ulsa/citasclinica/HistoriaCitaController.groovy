package ulsa.citasclinica
import ulsa.citasclinica.Terapeutas
import ulsa.citasclinica.Cita
import ulsa.citasclinica.Documentos
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN','ROLE_USUARIO'])
@Transactional(readOnly = false)
class HistoriaCitaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond HistoriaCita.list(params), model:[historiaCitaCount: HistoriaCita.count()]
    }


    def download(String url) {
        //println "entro"
        //print url
        redirect(uri:url)
    }


    def visualizacion(String docUrl) {

            String pdf = docUrl   

            File pdfFile =new File(pdf);

            response.contentType  = 'application/pdf' // or whatever content type your resources are
            response.outputStream << pdfFile.getBytes()
            response.outputStream.flush()
        
    }



    def show(HistoriaCita historiaCita) {
        if(historiaCita.id !=null){
            Integer i = (int)(long)historiaCita.id
        if(Documentos.findAll("from Documentos where historiaCita ="+i)!=null){
        List archivos = Documentos.findAll("from Documentos where historiaCita ="+i)
        [archivos: archivos, historiaCita:historiaCita]
        }}
        else {
            respond historiaCita
        }
    }

    

        def terapeutasF() {
        def subCategories=[]
        subCategories = Terapeutas.findAll("from Terapeutas where tStatus like 'Activo'")
        //println subCategories
        

        render text: g.select(id:'tera', name:'terapeutas',
            from:subCategories
        )
    }


    def historiadecita(HistoriaCita historiaCita){
        def citas = Cita.executeQuery("select fecha from Cita where id="+historiaCita.citasId)
        //print citas[0]
        [historiaCita:historiaCita,citas:citas]
    }


    

    def create(Cita cita) {
        if(cita!=null){
            //println cita
            def c = cita.id
            def sub = Terapeutas.findAll("from Terapeutas where t_status like 'Activo'")
            List nombres=[]
            for(Integer i =0;i<sub.size;i++){
                nombres[i]=sub[i].tNombre+" "+sub[i].tApPaterno+" "+sub[i].tApMaterno 
            }
            //println nombres
            [c:c, sub:nombres]
        }
    }

    @Transactional
    def save(HistoriaCita historiaCita) {
        if (historiaCita == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (historiaCita.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond historiaCita.errors, view:'create'
            return
        }
        Cita.executeUpdate(
    "update Cita set status = 'Tomada' where id ="+params.citas)
        historiaCita.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'historiaCita.label', default: 'HistoriaCita'), historiaCita.id])
                redirect historiaCita
            }
            '*' { respond historiaCita, [status: CREATED] }
        }
    }

    def edit(HistoriaCita historiaCita) {
        respond historiaCita
    }

    @Transactional
    def update(HistoriaCita historiaCita) {
        if (historiaCita == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (historiaCita.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond historiaCita.errors, view:'edit'
            return
        }

        historiaCita.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'historiaCita.label', default: 'HistoriaCita'), historiaCita.id])
                redirect historiaCita
            }
            '*'{ respond historiaCita, [status: OK] }
        }
    }

    @Transactional
    def delete(HistoriaCita historiaCita) {

        if (historiaCita == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        historiaCita.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'historiaCita.label', default: 'HistoriaCita'), historiaCita.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'historiaCita.label', default: 'HistoriaCita'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
