package ulsa.citasclinica

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.converters.JSON
import ulsa.citasclinica.Cita
import java.text.SimpleDateFormat
import java.util.Date
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN','ROLE_USUARIO'])
@Transactional(readOnly = false)
class OcupadasController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
    def map=[
       1:"Domingo",
       2:"Lunes",
       3:"Martes",
       4:"Miercoles",
       5:"Jueves",
       6:"Viernes",
       7:"Sabado"]
       
        //List ocupadasList = FechasCal.list()
        if(Cita.executeQuery("select distinct(fecha) from Cita where status like 'Agendada'")!=null){
            List ocupadasList  = Cita.executeQuery("select distinct(fecha) from Cita where status like 'Agendada'")
            def ocupadasValidacion = []
            Integer ov = 0
            for(Integer i=0;i<ocupadasList.size;i++){
                def criteria = Cita.createCriteria()
                def result = criteria.list {

                projections {
                    count()
                }
                eq ('fecha', ocupadasList[i])
                eq ('status', "Agendada")
                }
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(ocupadasList[i]);
                def day = calendar.get(Calendar.DAY_OF_WEEK);


                if(map[day]!="Sabado" && map[day]!="Domingo"){
                    if(result[0]==12){
                        ocupadasValidacion[ov]=ocupadasList[i]
                        ov++
                    }
                }
                if(map[day]=="Sabado"){
                     if(result[0]==6){
                        ocupadasValidacion[ov]=ocupadasList[i]
                        ov++
                    }
                }

            }
            if (ocupadasValidacion!=null){
                List ocu = ocupadasValidacion.collect {comp -> return [title: "Sin Disponibilidad", start: comp.format('yyyy-MM-dd')]}
                render ocu as JSON
            }else{
                //println "ocupadasValidacion vacia"
            }
        }else{
            //println "tabla vacia"
        }    
    }

    def show(Ocupadas ocupadas) {
        respond ocupadas
    }

    def create() {
        respond new Ocupadas(params)
    }

    @Transactional
    def save(Ocupadas ocupadas) {
        if (ocupadas == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (ocupadas.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond ocupadas.errors, view:'create'
            return
        }

        ocupadas.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'ocupadas.label', default: 'Ocupadas'), ocupadas.id])
                redirect ocupadas
            }
            '*' { respond ocupadas, [status: CREATED] }
        }
    }

    def edit(Ocupadas ocupadas) {
        respond ocupadas
    }

    @Transactional
    def update(Ocupadas ocupadas) {
        if (ocupadas == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (ocupadas.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond ocupadas.errors, view:'edit'
            return
        }

        ocupadas.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ocupadas.label', default: 'Ocupadas'), ocupadas.id])
                redirect ocupadas
            }
            '*'{ respond ocupadas, [status: OK] }
        }
    }

    @Transactional
    def delete(Ocupadas ocupadas) {

        if (ocupadas == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        ocupadas.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ocupadas.label', default: 'Ocupadas'), ocupadas.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'ocupadas.label', default: 'Ocupadas'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
