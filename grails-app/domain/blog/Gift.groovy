package blog

class Gift {

    String no

    String name

    int total

    int grade

    static hasMany = [items: MemberGift]

    static constraints = {
        no(unique: true, nullable: false, blank: false)
        name(nullable: false, blank: false)
        total(nullable: false, blank: false)
        grade(nullable: false, blank: false, min: 1)
    }
}
