package blog

class MemberGift {

    static belongsTo = [member: Member, gift: Gift]

    int num

    Date dateCreated // 创建时间

    static constraints = {
        num(min: 1)
    }
}
