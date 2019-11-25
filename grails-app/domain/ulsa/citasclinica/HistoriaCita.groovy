package ulsa.citasclinica

class HistoriaCita {
	Cita citas
	String s
	String o
	String a
	String p
	String terapeuta
    static constraints = {
    }
    static mapping = {
   s type: 'text'
   o type: 'text'
   a type: 'text'
   p type: 'text'
}
}
