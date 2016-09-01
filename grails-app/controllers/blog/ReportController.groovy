package blog

import grails.converters.JSON

class ReportController {

    def index() {
        def list = null
        if (params.date) {
            //统计某个月
            def endTime = DateUtil.addMonth(params.date, 1)
            list = Trade.executeQuery("select DATE_FORMAT(dateCreated,'%Y-%m-%d') ,sum(money) from Trade where dateCreated >= ? and dateCreated < ? and type = ? group by DATE_FORMAT(dateCreated,'%Y-%m-%d')", [params.date, endTime, params.type])
        } else if (params.date_year) {
            //统计年
            def startTime = DateUtil.strToDate("${params.date_year}-01-01 00:00:00", DateUtil.DATE_FORMAT_FULL_NORMAL)
            def endTime = DateUtil.addYear(startTime, 1)
            list = Trade.executeQuery("select DATE_FORMAT(dateCreated,'%Y-%m') ,sum(money) from Trade where dateCreated >= ? and dateCreated < ? and type = ? group by DATE_FORMAT(dateCreated,'%Y-%m')", [startTime, endTime, params.type])
        } else {
            //默认统计当前月
            def startTime = DateUtil.getCurMonthFirstDate()
            def endTime = DateUtil.addMonth(startTime, 1)
            list = Trade.executeQuery("select DATE_FORMAT(dateCreated,'%Y-%m-%d') ,sum(money) from Trade where dateCreated >= ? and dateCreated < ? and type = ? group by DATE_FORMAT(dateCreated,'%Y-%m-%d')", [startTime, endTime, "充值"])
        }
        def labelList = []
        def dataList = []
        list.each {
            labelList << it[0]
            dataList << it[1]
        }
        def startTime = DateUtil.strToDate(DateUtil.dateToStr(new Date(), DateUtil.DATE_FORMAT_DATE_NORMAL),DateUtil.DATE_FORMAT_DATE_NORMAL)
        def endTime = DateUtil.addDate(startTime, 1)
        def todayList = Trade.executeQuery("select type as name,sum(money) as value from Trade where dateCreated >= ? and dateCreated < ? group by type", [startTime, endTime])
        def resultList = []
        todayList.each {
            def map = [:]
            map.name = it[0]
            map.value = it[1]
            resultList << map
        }
        [labelList: labelList, dataList: dataList,resultList:resultList as JSON]
    }

    def member() {
        def list = null
        if (params.date) {
            //统计某个月
            def endTime = DateUtil.addMonth(params.date, 1)
            list = Member.executeQuery("select DATE_FORMAT(dateCreated,'%Y-%m-%d') ,count(*) from Member where dateCreated >= ? and dateCreated < ? group by DATE_FORMAT(dateCreated,'%Y-%m-%d')", [params.date, endTime])
        } else if (params.date_year) {
            //统计年
            def startTime = DateUtil.strToDate("${params.date_year}-01-01 00:00:00", DateUtil.DATE_FORMAT_FULL_NORMAL)
            def endTime = DateUtil.addYear(startTime, 1)
            list = Member.executeQuery("select DATE_FORMAT(dateCreated,'%Y-%m') ,count(*) from Member where dateCreated >= ? and dateCreated < ? group by DATE_FORMAT(dateCreated,'%Y-%m')", [startTime, endTime])
        } else {
            //默认统计当前月
            def startTime = DateUtil.getCurMonthFirstDate()
            def endTime = DateUtil.addMonth(startTime, 1)
            list = Member.executeQuery("select DATE_FORMAT(dateCreated,'%Y-%m-%d') ,count(*) from Member where dateCreated >= ? and dateCreated < ? group by DATE_FORMAT(dateCreated,'%Y-%m-%d')", [startTime, endTime])
        }
        def labelList = []
        def dataList = []
        list.each {
            labelList << it[0]
            dataList << it[1]
        }
        [labelList: labelList, dataList: dataList]
    }
}
