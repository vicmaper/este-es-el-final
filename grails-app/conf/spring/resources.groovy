import ulsa.citasclinica.UsuarioPasswordEncoderListener
// Place your Spring DSL code here
beans = {
    usuarioPasswordEncoderListener(UsuarioPasswordEncoderListener, ref('hibernateDatastore'))
}
