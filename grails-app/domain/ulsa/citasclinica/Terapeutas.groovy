package ulsa.citasclinica

class Terapeutas {
	String tMatricula
	String tNombre
	String tApPaterno
	String tApMaterno
	String tTelefono
	String tStatus
    static constraints = {
    }
    public String toString() {
        return tNombre + " "+ tApPaterno +" "+ tApMaterno;
    }
}
