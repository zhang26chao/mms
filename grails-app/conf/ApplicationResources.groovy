modules = {
    application {
        resource url:'js/application.js'
    }
    datepicker {
        resource url:'css/jquery-ui.css'
        dependsOn 'jquery'
        resource url:'js/jquery-ui-datepicker.js'
    }
}