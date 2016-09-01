package blog

class Notice {
    
    String title
    
    String content

    Date dateCreated // 创建时间

    static constraints = {
        title(nullable: false,blank: false)
        content(nullable: false,blank: false)
    }

    static mapping = {
        content sqlType: 'LONGTEXT'
    }
}
