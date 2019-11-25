package ulsa.citasclinica

class Paciente {
	String pNombre
	String pApPaterno
	String pApMaterno
	String pCurp
	String pDireccion
	String pTelefono
	String pDiagnostico
	String pStatus
	Date pFechaNac
	String urlIne
	String urlComp
	String urlActa
    static constraints = {
    	urlIne nullable:true
    	urlComp nullable:true
    	urlActa nullable:true
    	pStatus nullable:true
    }
    public String toString() {
        return pNombre + " "+ pApPaterno +" "+ pApMaterno;
    }
}
