package ulsa.citasclinica

class Documentos {
	String docUrl
	String tipoArchivo
	HistoriaCita historiaCita
    static constraints = {
    	docUrl nullable:true
    }
}
