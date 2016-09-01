package blog

import org.springframework.dao.DataIntegrityViolationException
import org.springframework.validation.ObjectError

class MemberController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        if (params.operator == '导出') {
            export()
            return
        }
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        params.sort = "dateCreated"
        params.order = "desc"
        def memberInstanceList = Member.createCriteria().list(params, {
            if (params.cardNo) {
                eq('cardNo', params.cardNo)
            }
            if (params.name) {
                like('name', "${params.name}%")
            }
        })
        [memberInstanceList: memberInstanceList, memberInstanceTotal: memberInstanceList.totalCount]
    }

    def export() {
        params.max = 50000
        params.sort = "dateCreated"
        params.order = "desc"
        def memberInstanceList = Member.createCriteria().list(params, {
            if (params.cardNo) {
                eq('cardNo', params.cardNo)
            }
            if (params.name) {
                like('name', "${params.name}%")
            }
        })
        response.contentType = 'text/csv'
        response.setHeader("Content-disposition", "attachment; filename=${DateUtil.dateToStr(new Date(), DateUtil.DATE_FORMAT_FULL_SHORT)}.csv")
        response.getOutputStream().write("会员卡号,姓名,性别,生日,手机号码,余额(元),创建时间\r\n".getBytes("gbk"))
        memberInstanceList.each {
            def birthDay = it.birthDay ? DateUtil.dateToStr(it.birthDay, DateUtil.DATE_FORMAT_DATE_NORMAL) : ''
            response.getOutputStream().write("\t${it.cardNo},${it.name},${it.sex ?: ''},\t${birthDay},\t${it.phoneNumber ?: ''},${it.balance},\t${DateUtil.dateToStr(it.dateCreated, DateUtil.DATE_FORMAT_FULL_NORMAL)}\r\n".getBytes("gbk"))
        }
        response.getOutputStream().flush()
    }

    def create() {
        [memberInstance: new Member(params)]
    }

    def save() {
        def memberInstance = new Member(params)
        //1元1个积分，自动换算
        memberInstance.grade = memberInstance.balance
        def tradeInstance = new Trade()
        tradeInstance.type = "充值"
        tradeInstance.money = memberInstance.balance
        tradeInstance.member = memberInstance
        memberInstance.addToItems(tradeInstance)
        if (!memberInstance.save(flush: true)) {
            render(view: "create", model: [memberInstance: memberInstance])
            return
        }
        flash.message = message(code: 'default.created.message', args: [message(code: 'member.label', default: 'Member'), memberInstance.id])
        redirect(action: "show", id: memberInstance.id)
    }

    def show() {
        def memberInstance = Member.get(params.id)
        if (!memberInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'member.label', default: 'Member'), params.id])
            redirect(action: "list")
            return
        }

        [memberInstance: memberInstance]
    }

    def edit() {
        def memberInstance = Member.get(params.id)
        if (!memberInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'member.label', default: 'Member'), params.id])
            redirect(action: "list")
            return
        }

        [memberInstance: memberInstance]
    }

    def update() {
        def memberInstance = Member.get(params.id)
        if (!memberInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'member.label', default: 'Member'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (memberInstance.version > version) {
                memberInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'member.label', default: 'Member')] as Object[],
                        "Another user has updated this Member while you were editing")
                render(view: "edit", model: [memberInstance: memberInstance])
                return
            }
        }

        memberInstance.properties = params

        if (!memberInstance.save(flush: true)) {
            render(view: "edit", model: [memberInstance: memberInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'member.label', default: 'Member'), memberInstance.id])
        redirect(action: "show", id: memberInstance.id)
    }

    def delete() {
        def memberInstance = Member.get(params.id)
        if (!memberInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'member.label', default: 'Member'), params.id])
            redirect(action: "list")
            return
        }

        try {
            memberInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'member.label', default: 'Member'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'member.label', default: 'Member'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def recharge() {
        def tradeInstance = new Trade(params)
        tradeInstance.type = "充值"
        tradeInstance.member = Member.get(params.id as Long)
        [tradeInstance: tradeInstance]
    }

    def consume() {
        def tradeInstance = new Trade(params)
        tradeInstance.type = "消费"
        tradeInstance.member = Member.get(params.id as Long)
        [tradeInstance: tradeInstance]
    }

    def trade() {
        def tradeInstance = new Trade(params)
        if (!tradeInstance.validate()) {
            def view = params.type == "充值" ? "recharge" : "consume"
            render(view: view, model: [tradeInstance: tradeInstance])
            return
        }
        def balance = tradeInstance.member.balance
        def money = params.money as int
        //校验消费金额
        if (params.type == "消费" && balance < money) {
            def error = new ObjectError('money', message(code: 'trade.money.insufficient.balance'))
            tradeInstance.errors.addError(error)
            render(view: "consume", model: [tradeInstance: tradeInstance])
            return
        }
        if (params.type == "充值") {
            tradeInstance.member.balance = balance + money
            //充值积分累加
            tradeInstance.member.grade += money
        } else {
            tradeInstance.member.balance = balance - money
        }
        //tradeInstance.member.balance = (params.type == "充值") ? balance + money : balance - money
        if (!tradeInstance.save(flush: true)) {
            def view = params.type == "充值" ? "recharge" : "consume"
            render(view: view, model: [tradeInstance: tradeInstance])
            return
        }
        flash.message = message(code: '会员[{0}]{1}成功,{1}金额[{2}]元', args: [tradeInstance.member.cardNo, tradeInstance.type, tradeInstance.money])
        redirect(action: "list")
    }

    def doImport() {
        try {
            def f = request.getFile("file")
            if (f.isEmpty()) {
                flash.message = "文件不能为空!"
                redirect(uri: "/member/import")
                return
            }
            int successCount = 0
            int failureCount = 0
            def failureCareNo = new StringBuilder()
            int index = 0
            f.getInputStream().splitEachLine(",", "gbk") {  fields ->
                index++
                if (saveMember(fields)) {
                    successCount++
                } else {
                    failureCount++
                    if (failureCareNo.length() > 0) {
                        failureCareNo.append(",")
                    }
                    failureCareNo.append(index)
                }
            }
            flash.message = message(code: '导入完成,成功[{0}]条,失败[{1}]条,失败记录[{2}]', args: [successCount, failureCount, failureCareNo])
        } catch (Exception e) {
            e.printStackTrace()
            flash.message = message(code: '导入发生异常,原因[{0}]', args: [e.getMessage()])
        }
        redirect(uri: "/member/import")
    }

    private saveMember(def fields) {
        if (fields.size() < 6) {
            return false
        }
        try {
            def memberInstance = new Member()
            memberInstance.cardNo = fields[0].trim()
            memberInstance.name = fields[1].trim()
            memberInstance.sex = fields[2].trim()
            memberInstance.birthDay = DateUtil.strToDate(fields[3].trim(), DateUtil.DATE_FORMAT_DATE_NORMAL)
            memberInstance.phoneNumber = fields[4].trim()
            memberInstance.balance = fields[5].trim() as int
            memberInstance.grade = memberInstance.balance
            def tradeInstance = new Trade()
            tradeInstance.type = "充值"
            tradeInstance.money = memberInstance.balance
            tradeInstance.member = memberInstance
            memberInstance.addToItems(tradeInstance)
            return memberInstance.save(flush: true)
        } catch (Exception e) {
            e.printStackTrace()
        }
        return false
    }

    def exchangeList() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        params.sort = "dateCreated"
        params.order = "desc"
        def memberGiftInstanceList = MemberGift.createCriteria().list(params, {
            if (params.id) {
                member {
                    eq('id', params.id as long)
                }
            }
        })
        [memberGiftInstanceList: memberGiftInstanceList, memberGiftInstanceTotal: memberGiftInstanceList.totalCount]
    }

    def exportGift() {
        params.max = 50000
        params.sort = "dateCreated"
        params.order = "desc"
        def memberGiftInstanceList = MemberGift.createCriteria().list(params, {
            if (params.id) {
                member {
                    eq('id', params.id as long)
                }
            }
        })
        response.contentType = 'text/csv'
        response.setHeader("Content-disposition", "attachment; filename=${DateUtil.dateToStr(new Date(), DateUtil.DATE_FORMAT_FULL_SHORT)}.csv")
        response.getOutputStream().write("会员卡号,会员姓名,礼品卡号,礼品名称,兑换数量,兑换时间\r\n".getBytes("gbk"))
        memberGiftInstanceList.each {
            response.getOutputStream().write("\t${it.member.cardNo},${it.member.name},\t${it.gift.no},${it.gift.name},${it.num},\t${DateUtil.dateToStr(it.dateCreated, DateUtil.DATE_FORMAT_FULL_NORMAL)}\r\n".getBytes("gbk"))
        }
        response.getOutputStream().flush()
    }
}
