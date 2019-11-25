package ulsa.citasclinica

class Cita {
	Paciente paciente
	Date fecha
	String hora
	String status
    static constraints = {
    	fecha nullable:true
    	status nullable:true
    }
}
