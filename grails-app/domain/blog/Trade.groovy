package blog

class Trade {

    String type

    int money

    Date dateCreated // 创建时间

    static belongsTo = [member: Member]

    static constraints = {
        type(nullable: false,inList: ["充值","消费"])
        money(min: 1)
    }
}
