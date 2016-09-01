package blog

import org.springframework.dao.DataIntegrityViolationException

class GiftController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def giftInstanceList = Gift.createCriteria().list(params, {
            if (params.no) {
                eq('no', params.no)
            }
            if (params.name) {
                like('name', "${params.name}%")
            }
            if (params.grade) {
                def max = 0, min = 0
                if (params.grade == '0') {
                    ge('grade', 0)
                    lt('grade', 100)
                } else if (params.grade == '1') {
                    ge('grade', 100)
                    lt('grade', 500)
                } else if (params.grade == '2') {
                    ge('grade', 500)
                    lt('grade', 1000)
                } else if (params.grade == '3') {
                    ge('grade', 1000)
                    lt('grade', 5000)
                } else {
                    ge('grade', 5000)
                }
            }
            if (params.status) {
                if (params.status == '0') {
                    eq('total', 0)
                } else {
                    gt('total', 0)
                }
            }
        })
        [giftInstanceList: giftInstanceList, giftInstanceTotal: giftInstanceList.totalCount]
    }

    def create() {
        [giftInstance: new Gift(params)]
    }

    def save() {
        def giftInstance = new Gift(params)
        if (!giftInstance.save(flush: true)) {
            render(view: "create", model: [giftInstance: giftInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'gift.label', default: 'Gift'), giftInstance.id])
        redirect(action: "show", id: giftInstance.id)
    }

    def show() {
        def giftInstance = Gift.get(params.id)
        if (!giftInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'gift.label', default: 'Gift'), params.id])
            redirect(action: "list")
            return
        }

        [giftInstance: giftInstance]
    }

    def edit() {
        def giftInstance = Gift.get(params.id)
        if (!giftInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'gift.label', default: 'Gift'), params.id])
            redirect(action: "list")
            return
        }

        [giftInstance: giftInstance]
    }

    def update() {
        def giftInstance = Gift.get(params.id)
        if (!giftInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'gift.label', default: 'Gift'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (giftInstance.version > version) {
                giftInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'gift.label', default: 'Gift')] as Object[],
                        "Another user has updated this Gift while you were editing")
                render(view: "edit", model: [giftInstance: giftInstance])
                return
            }
        }

        giftInstance.properties = params

        if (!giftInstance.save(flush: true)) {
            render(view: "edit", model: [giftInstance: giftInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'gift.label', default: 'Gift'), giftInstance.id])
        redirect(action: "show", id: giftInstance.id)
    }

    def delete() {
        def giftInstance = Gift.get(params.id)
        if (!giftInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'gift.label', default: 'Gift'), params.id])
            redirect(action: "list")
            return
        }

        try {
            giftInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'gift.label', default: 'Gift'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'gift.label', default: 'Gift'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def exchange() {
        def memberGift = new MemberGift()
        memberGift.gift = Gift.get(params.id)
        [memberGift: memberGift]
    }

    def doExchange() {
        def memberGift = new MemberGift()
        def gift = Gift.get(params.id)
        memberGift.gift = gift
        //检查礼品数量
        if (gift.total == 0) {
            flash.message = '礼品数量为0,无法兑换!'
            render(view: "exchange", model: [memberGift: memberGift])
            return
        }
        //检查会员是否存在
        def memberList = Member.findAllByCardNo(params.cardNo)
        if (memberList.size() == 0) {
            flash.message = message(code: '卡号[{0}]不存在!', args: [params.cardNo])
            render(view: "exchange", model: [memberGift: memberGift])
            return
        }
        def num = params.num as int
        // 兑换数量不能超过礼品数量
        if (num > gift.total) {
            flash.message = '兑换数量不能超过礼品数量为!'
            render(view: "exchange", model: [memberGift: memberGift])
            return
        }
        //检查会员积分
        if (memberList.get(0).grade < num * gift.grade) {
            flash.message = '会员积分不够兑换!'
            render(view: "exchange", model: [memberGift: memberGift])
            return
        }
        memberGift.member = memberList.get(0)
        memberGift.num = num
        if (!memberGift.save(flush: true)) {
            render(view: "exchange", model: [memberGift: memberGift])
            return
        }
        //核减礼品数量
        gift.total -= num
        gift.save(flush: true)
        //核减会员积分
        memberGift.member.grade -= num * gift.grade
        memberGift.member.save(flush: true)
        flash.message = '兑换成功!'
        redirect(action: "list")
    }

    def exchangeList() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        params.sort = "dateCreated"
        params.order = "desc"
        def memberGiftInstanceList = MemberGift.createCriteria().list(params, {
            if (params.id) {
                gift {
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
                gift {
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
