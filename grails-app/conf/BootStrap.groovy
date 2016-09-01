import blog.Role
import blog.User
import blog.UserRole

class BootStrap {

    def grailsApplication

    def init = { servletContext ->
        def adminAuthority = grailsApplication.config.role.admin.authority
        def operatorAuthority = grailsApplication.config.role.operator.authority
        def adminRole = new Role(authority: adminAuthority).save(flush: true)
        def userRole = new Role(authority: operatorAuthority).save(flush: true)
        def adminUser = new User(username: 'admin', enabled: true, password: 'admin!@#$')
        adminUser.save(flush: true)
        UserRole.create(adminUser, adminRole, true)
        def operator = new User(username: 'operator', enabled: true, password: 'app@1234')
        operator.save(flush: true)
        UserRole.create(operator, userRole, true)
    }
    def destroy = {
    }
}
