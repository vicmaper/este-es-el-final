package ulsa.citasclinica
import ulsa.citasclinica.StatusCit
import ulsa.citasclinica.Ocupadas
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import java.text.SimpleDateFormat;
import java.util.Date;
import java.time.format.DateTimeFormatter;  
import java.time.LocalDateTime;   
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN','ROLE_USUARIO'])
@Transactional(readOnly = false)
class CitaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        List citasA = Cita.findAll("from Cita where status like 'Agendada'")
        respond citasA
    }

    def tcitas(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Cita.list(params), model:[citaCount: Cita.count()]
    }

    def show(Cita cita) {
        if(cita.id !=null){
            Integer i = (int)(long)cita.id
        if(HistoriaCita.findAll("from HistoriaCita where citas ="+i)!=null){
        List hcitas = HistoriaCita.findAll("from HistoriaCita where citas ="+i)
        [hcitas: hcitas, cita:cita]
        }}
        else {
            respond cita
        }
    }

    def create() {
        respond new Cita(params)
    }


    def limpiar(Date fecha) {
        def s = Cita.findAll("from Cita where fecha < current_date")
        for(Integer i=0;i<s.size;i++){
        Cita.executeUpdate(
        "update Cita set status = 'Cancelada' where id ="+s[i].id)
        }
        return 0
    }

    def categoryChanged(String categoryId) {
        String category = categoryId
        def subCategories = []  
        List evaluador= ["08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00"]
        List evaluadorS=["08:00","09:00","10:00","11:00","12:00","13:00"]


        
        Date dia = new SimpleDateFormat("yyyy-MM-dd").parse(category)
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(dia);
        def day = calendar.get(Calendar.DAY_OF_WEEK);


       def map=[
       1:"Domingo",
       2:"Lunes",
       3:"Martes",
       4:"Miercoles",
       5:"Jueves",
       6:"Viernes",
       7:"Sabado"]


       if(map[day]!="Sabado" && map[day]!="Domingo"){
        List qe  = Cita.executeQuery("select hora from Cita where fecha='"+categoryId+"' and status like 'Agendada'")
        if (qe!=null){
            for(Integer i = 0;i<qe.size;i++){
                for(Integer j = 0;j<evaluador.size;j++){
                  if(qe[i]==evaluador[j]){
                    def el = qe[i]
                    evaluador.removeAll{it==el}
                  }  
                }
            }
        }
        subCategories = evaluador
        }
        if(map[day]=="Sabado"){
            List qe  = Cita.executeQuery("select hora from Cita where fecha='"+categoryId+"' and status like 'Agendada'")
            if (qe!=null){
                for(Integer i = 0;i<qe.size;i++){
                    for(Integer j = 0;j<evaluadorS.size;j++){
                      if(qe[i]==evaluadorS[j]){
                        def el = qe[i]
                        evaluadorS.removeAll{it==el}
                      }  
                    }
                }
            }
            subCategories = evaluadorS
        }
        render text: g.select(id:'hora', name:'hora',
            from:subCategories
        )
    }


    @Transactional
    def save(Cita cita) {
        String fecha=params.an+"-"+params.mes+"-"+params.dia
        
        Date date1=new SimpleDateFormat("yyyy-MM-dd").parse(fecha); 
        if (cita == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (cita.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond cita.errors, view:'create'
            return
        }
        cita.paciente=Paciente.get(params.paciente)
        cita.fecha=date1
        cita.hora=params.hora
        cita.status="Agendada"
        cita.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'cita.label', default: 'Cita'), cita.id])
                redirect cita
            }
            '*' { respond cita, [status: CREATED] }
        }
    }

    def edit(Cita cita) {
        respond cita
    }

    @Transactional
    def update(Cita cita) {
        if (cita == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (cita.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond cita.errors, view:'edit'
            return
        }

        cita.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'cita.label', default: 'Cita'), cita.id])
                redirect cita
            }
            '*'{ respond cita, [status: OK] }
        }
    }

    @Transactional
    def delete(Cita cita) {

        if (cita == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        cita.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'cita.label', default: 'Cita'), cita.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'cita.label', default: 'Cita'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
