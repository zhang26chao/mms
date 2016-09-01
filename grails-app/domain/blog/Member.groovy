package blog

class Member {

    String cardNo

    String name

    String sex

    Date birthDay

    String phoneNumber

    int balance

    int grade

    Date dateCreated // 创建时间

    static hasMany = [items: Trade, gifts: MemberGift]

    static mapping = {
        birthDay sqlType: 'date'
    }

    static constraints = {
        cardNo(unique: true, nullable: false, blank: false)
        name(nullable: false, blank: false)
        sex(nullable: true, inList: ["男", "女"])
        birthDay(nullable: true)
        phoneNumber(nullable: true)
        balance(min: 0)
    }
}
