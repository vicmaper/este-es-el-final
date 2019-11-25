package ulsa.citasclinica

import grails.test.mixin.*
import spock.lang.*

@TestFor(TipoArchivoController)
@Mock(TipoArchivo)
class TipoArchivoControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null

        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
        assert false, "TODO: Provide a populateValidParams() implementation for this generated test suite"
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.tipoArchivoList
            model.tipoArchivoCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.tipoArchivo!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def tipoArchivo = new TipoArchivo()
            tipoArchivo.validate()
            controller.save(tipoArchivo)

        then:"The create view is rendered again with the correct model"
            model.tipoArchivo!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            tipoArchivo = new TipoArchivo(params)

            controller.save(tipoArchivo)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/tipoArchivo/show/1'
            controller.flash.message != null
            TipoArchivo.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def tipoArchivo = new TipoArchivo(params)
            controller.show(tipoArchivo)

        then:"A model is populated containing the domain instance"
            model.tipoArchivo == tipoArchivo
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def tipoArchivo = new TipoArchivo(params)
            controller.edit(tipoArchivo)

        then:"A model is populated containing the domain instance"
            model.tipoArchivo == tipoArchivo
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/tipoArchivo/index'
            flash.message != null

        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def tipoArchivo = new TipoArchivo()
            tipoArchivo.validate()
            controller.update(tipoArchivo)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.tipoArchivo == tipoArchivo

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            tipoArchivo = new TipoArchivo(params).save(flush: true)
            controller.update(tipoArchivo)

        then:"A redirect is issued to the show action"
            tipoArchivo != null
            response.redirectedUrl == "/tipoArchivo/show/$tipoArchivo.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/tipoArchivo/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def tipoArchivo = new TipoArchivo(params).save(flush: true)

        then:"It exists"
            TipoArchivo.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(tipoArchivo)

        then:"The instance is deleted"
            TipoArchivo.count() == 0
            response.redirectedUrl == '/tipoArchivo/index'
            flash.message != null
    }
}
