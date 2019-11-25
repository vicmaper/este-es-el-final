package ulsa.citasclinica

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import ulsa.citasclinica.Cita
import ulsa.citasclinica.HistoriaCita
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN','ROLE_USUARIO'])
@Transactional(readOnly = false)
class PacienteController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Paciente.list(params), model:[pacienteCount: Paciente.count()]
    }


     def historialpaciente(Paciente paciente){
        
        if(paciente!=null){
            def hist=[]
            def fechas=[]
            Integer n=0
            def citas = Cita.findAll("from Cita where paciente="+paciente.id+" and status like 'Tomada'")
            for(Integer i=0;i<citas.size;i++){
                if(HistoriaCita.findAll("from HistoriaCita where citas="+citas[i].id)!=null){
                    hist[n]=HistoriaCita.findAll("from HistoriaCita where citas="+citas[i].id)+ citas[i].fecha
                    //println hist[n]
                    n++

                }
            }
            [hist:hist]
        }
    }




    def show(Paciente paciente) {
       // def n = Cita.findAllWhere(paciente: "1")
        //def n = Cita.executeQuery("select * from Cita where Paciente=1")
        
        //def con=Cita.findAllByPaciente(pa)
        //[elementos:n]
        if(paciente.id !=null){
            Integer i = (int)(long)paciente.id
        if(Cita.findAll("from Cita where paciente ="+i)!=null){
        List citas = Cita.findAll("from Cita where paciente ="+i)
        [citas: citas, paciente:paciente]
        }}
        else {
            respond paciente
        }
    }

    def create() {
        respond new Paciente(params)
    }



    @Transactional
    def save(Paciente paciente) {
        def er = 0
        if (paciente == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            er=1
            return
        }else{
            er=0
        }

        if (paciente.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond paciente.errors, view:'create'
            er=1
            return
        }else{
            er=0
        }

        if(er==0){
        def f = request.getFile('docIne')
        def fa = request.getFile('docActa')
        def fc = request.getFile('docComprobante')
        
        //String urlB = servletContext.getRealPath("/")
        //String ine = "C:/Users/Victor/Desktop/clinica/ine/" + params.pCurp +"Ine.pdf"
        //String comprobante = "C:/Users/Victor/Desktop/clinica/comprobante/" + params.pCurp + "Comprobante.pdf"
        //String acta = "C:/Users/Victor/Desktop/clinica/acta/" + params.pCurp + "Acta.pdf"
        
        //String ine = urlB+"archivosPacientes\\ine\\" + params.pNombre + params.pApPaterno + params.pApMaterno + ".pdf"
        //String comprobante = urlB+"archivosPacientes\\comprobante\\" + params.pNombre + params.pApPaterno + params.pApMaterno + ".pdf"
        //String acta = urlB+ "archivosPacientes\\acta\\" + params.pNombre + params.pApPaterno + params.pApMaterno + ".pdf"
        
        String ine = "/home/ingenierias/proyecto_fisioterapia/archivos/documentos_personales/ine/" + params.pCurp +"Ine.pdf"
        String comprobante = "/home/ingenierias/proyecto_fisioterapia/archivos/documentos_personales/comprobante/" + params.pCurp + "Comprobante.pdf"
        String acta = "/home/ingenierias/proyecto_fisioterapia/archivos/documentos_personales/acta/" + params.pCurp + "Acta.pdf"
        

        f.transferTo(new File(ine))
        fa.transferTo(new File(acta))
        fc.transferTo(new File(comprobante))


        
        paciente.pNombre=params.pNombre
        paciente.pApPaterno=params.pApPaterno
        paciente.pApMaterno=params.pApMaterno
        paciente.pCurp=params.pCurp
        paciente.pDireccion=params.pDireccion
        paciente.pTelefono=params.pTelefono
        paciente.pDiagnostico=params.pDiagnostico
        paciente.pStatus="Activo"
        paciente.pFechaNac=params.pFechaNac
        paciente.urlIne=ine
        paciente.urlComp=comprobante
        paciente.urlActa=acta

    

        paciente.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'paciente.label', default: 'Paciente'), paciente.id])
                redirect paciente
            }
            '*' { respond paciente, [status: CREATED] }
        }
        }
    }

    def edit(Paciente paciente) {
        respond paciente
    }

    @Transactional
    def update(Paciente paciente) {
        if (paciente == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (paciente.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond paciente.errors, view:'edit'
            return
        }


        paciente.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'paciente.label', default: 'Paciente'), paciente.id])
                redirect paciente
            }
            '*'{ respond paciente, [status: OK] }
        }
    }

    def visualizacion(String docUrl) {

            String pdf = docUrl   

            File pdfFile =new File(pdf);

            response.contentType  = 'application/pdf' 
            response.outputStream << pdfFile.getBytes()
            response.outputStream.flush()
        
    }

    @Transactional
    def delete(Paciente paciente) {

        if (paciente == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        paciente.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'paciente.label', default: 'Paciente'), paciente.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'paciente.label', default: 'Paciente'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
