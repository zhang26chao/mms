package blog

import org.springframework.dao.DataIntegrityViolationException

class TradeController {

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
        def tradeInstanceList = Trade.createCriteria().list(params, {
            if (params.type) {
                eq('type', params.type)
            }
            if (params.beginDate) {
                ge('dateCreated', params.date('beginDate', 'yyyy-MM-dd'))
            }
            if (params.endDate) {
                lt('dateCreated', DateUtil.addDate(params.date('endDate', 'yyyy-MM-dd'),1))
            }
            if (params.cardNo) {
                member {
                    eq('cardNo', params.cardNo)
                }
            }
        })
        [tradeInstanceList: tradeInstanceList, tradeInstanceTotal: tradeInstanceList.totalCount]
    }

    def export() {
        params.max = 50000
        params.sort = "dateCreated"
        params.order = "desc"
        def tradeInstanceList = Trade.createCriteria().list(params, {
            if (params.type) {
                eq('type', params.type)
            }
            if (params.beginDate) {
                ge('dateCreated', params.date('beginDate', 'yyyy-MM-dd'))
            }
            if (params.endDate) {
                lt('dateCreated', DateUtil.addDate(params.date('endDate', 'yyyy-MM-dd'),1))
            }
            if (params.cardNo) {
                member {
                    eq('cardNo', params.cardNo)
                }
            }
        })
        response.contentType = 'text/csv'
        response.setHeader("Content-disposition", "attachment; filename=${DateUtil.dateToStr(new Date(),DateUtil.DATE_FORMAT_FULL_SHORT)}.csv")
        response.getOutputStream().write("交易类型,交易金额(元),交易时间,会员卡号\r\n".getBytes("gbk"))
        tradeInstanceList.each {
            response.getOutputStream().write("${it.type},${it.money},\t${DateUtil.dateToStr(it.dateCreated,DateUtil.DATE_FORMAT_FULL_NORMAL)},${it.member.cardNo}\r\n".getBytes("gbk"))
        }
        response.getOutputStream().flush()
    }

//    def create() {
//        [tradeInstance: new Trade(params)]
//    }
//
//    def save() {
//        def tradeInstance = new Trade(params)
//        tradeInstance.member = Member.get(params.memberId as Long)
//        if (!tradeInstance.save(flush: true)) {
//            render(view: "create", model: [tradeInstance: tradeInstance])
//            return
//        }
//
//        flash.message = message(code: 'default.created.message', args: [message(code: 'trade.label', default: 'Trade'), tradeInstance.id])
//        redirect(action: "show", id: tradeInstance.id)
//    }
//
//    def show() {
//        def tradeInstance = Trade.get(params.id)
//        if (!tradeInstance) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'trade.label', default: 'Trade'), params.id])
//            redirect(action: "list")
//            return
//        }
//
//        [tradeInstance: tradeInstance]
//    }
//
//    def edit() {
//        def tradeInstance = Trade.get(params.id)
//        if (!tradeInstance) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'trade.label', default: 'Trade'), params.id])
//            redirect(action: "list")
//            return
//        }
//
//        [tradeInstance: tradeInstance]
//    }
//
//    def update() {
//        def tradeInstance = Trade.get(params.id)
//        if (!tradeInstance) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'trade.label', default: 'Trade'), params.id])
//            redirect(action: "list")
//            return
//        }
//
//        if (params.version) {
//            def version = params.version.toLong()
//            if (tradeInstance.version > version) {
//                tradeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
//                        [message(code: 'trade.label', default: 'Trade')] as Object[],
//                        "Another user has updated this Trade while you were editing")
//                render(view: "edit", model: [tradeInstance: tradeInstance])
//                return
//            }
//        }
//
//        tradeInstance.properties = params
//
//        if (!tradeInstance.save(flush: true)) {
//            render(view: "edit", model: [tradeInstance: tradeInstance])
//            return
//        }
//
//        flash.message = message(code: 'default.updated.message', args: [message(code: 'trade.label', default: 'Trade'), tradeInstance.id])
//        redirect(action: "show", id: tradeInstance.id)
//    }
//
//    def delete() {
//        def tradeInstance = Trade.get(params.id)
//        if (!tradeInstance) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'trade.label', default: 'Trade'), params.id])
//            redirect(action: "list")
//            return
//        }
//
//        try {
//            tradeInstance.delete(flush: true)
//            flash.message = message(code: 'default.deleted.message', args: [message(code: 'trade.label', default: 'Trade'), params.id])
//            redirect(action: "list")
//        }
//        catch (DataIntegrityViolationException e) {
//            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'trade.label', default: 'Trade'), params.id])
//            redirect(action: "show", id: params.id)
//        }
//    }
}
