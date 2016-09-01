package blog

class GlobalController {

    def springSecurityService

    def passwordEncoder

    def index() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        params.sort = "dateCreated"
        params.order = "desc"
        render(view: '/index', model: [noticeInstanceList: Notice.list(params), noticeInstanceTotal: Notice.count()])
    }

    def detail() {
        def noticeInstance = Notice.get(params.id)
        [noticeInstance: noticeInstance]
        render(view: '/detail', model: [noticeInstance: noticeInstance])
    }

    def password() {
        render(view: '/password')
    }

    def modifyPwd = {
        def userInstance = User.findByUsername(springSecurityService.authentication.name)
        //验证旧密码是否正确
        def isPasswordValid = passwordEncoder.isPasswordValid(userInstance.password, params.oldPwd, null)
        if (!isPasswordValid) {
            flash.message = "${message(code: 'default.pwdModify.error.message', default: '旧密码不正确')}"
            redirect(action: "password")
            return
        }
        userInstance.password = params.newPwd
        if (userInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.pwdModify.success.message', default: '密码修改成功')}"
        } else {
            flash.message = "${message(code: 'default.pwdModify.failure.message', default: '密码修改失败')}"
        }
        redirect(action: "password")
    }
}
