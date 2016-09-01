<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'report.label', default: 'Report')}"/>
    <title>交易报表</title>
</head>

<body>
<a href="#list-trade" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                            default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
    </ul>
</div>

<div style="padding: 10px;text-align: right;">
    <g:form action="index" onsubmit="return checkForm();">
        <style>
        table.search {
            border: 1px solid #cccccc;
            margin-bottom: 0;
        }

        table.search tr:hover {
            background: none;
        }
        </style>
        <table class="search">
            <tr>
                <td><label for="type">
                    <g:message code="trade.type.label" default="type"/>
                </label><g:select name="type" from="${['充值','消费']}" value="${params.type}"
                                  keys="${['充值','消费']}"
                                  id="type" style="margin-left: 4px;"/></td>
                <td>
                    <label for="date">
                        查询时间
                    </label>
                    <g:datePicker name="date" precision="month" default="none"
                                  relativeYears="[-5..0]" noSelection="['':'']"/>
                    <script>
                        var year = '${params.date_year}';
                        if (year) {
                            month = '${params.date_month}';
                        } else {
                            var date = new Date();
                            year = date.getFullYear();
                            month = date.getMonth() + 1;
                        }
                        document.getElementById('date_year').value = year;
                        document.getElementById('date_month').value = month;
                    </script>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right">
                    <input name="operator" type="submit" value="查询"/>
                </td>
            </tr>
        </table>
    </g:form>
</div>

<div id="list-trade" class="content scaffold-list" role="main" style="padding: 0 10px;">
    <div id="main2" style="height:400px;border: 1px solid #cccccc;"></div>
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="height:400px;border: 1px solid #cccccc;"></div>
    <!-- ECharts单文件引入 -->
    <script src="${resource(dir: 'js/echarts', file: 'echarts.js')}" type="text/javascript"></script>
    <script type="text/javascript">
        function getTitle() {
            var title = document.getElementById('date_year').value + '年';
            var month = document.getElementById('date_month').value;
            if (month) {
                title += month + '月';
            }
            title += document.getElementById('type').value + '报表';
            return title;
        }

        // 路径配置
        require.config({
            paths:{
                echarts:'${resource(dir: 'js/echarts')}'
            }
        });

        // 使用
        require(
                [
                    'echarts',
                    'echarts/chart/bar', // 使用柱状图就加载bar模块，按需加载
                    'echarts/chart/line'
                ],
                function (ec) {
                    // 基于准备好的dom，初始化echarts图表
                    var myChart = ec.init(document.getElementById('main'));
                    var labelList = [];
                    <g:each in="${labelList}" status="i" var="label">
                    labelList.push('${label}');
                    </g:each>
                    var dataList = ${dataList};
                    var option = {
                        title:{
                            text:getTitle(),
                            x:'center'
                        },
                        tooltip:{
                            show:true
                        }, legend:{
                            orient:'vertical',
                            x:'left',
                            data:['${params.type?:"充值"}']
                        },
                        xAxis:[
                            {
                                type:'category',
                                data:labelList,
                                name:'日期'
                            }
                        ],
                        yAxis:[
                            {
                                type:'value',
                                name:'金额(元)'
                            }
                        ],
                        series:[
                            {
                                "name":"${params.type?:"充值"}",
                                "type":"bar",
                                "data":dataList
                            }
                        ],
                        toolbox:{
                            show:true,
                            feature:{
                                dataView:{show:true, readOnly:false},
                                magicType:{show:true, type:['line', 'bar']},
                                restore:{show:true},
                                saveAsImage:{show:true}
                            }
                        }
                    };
                    if (dataList.length > 0) {
                        option.series[0].markPoint = {
                            "data":[
                                {type:'max', name:'最大值'},
                                {type:'min', name:'最小值'}
                            ]
                        };
                        option.series[0].markLine = {
                            "data":[
                                {type:"average", name:"平均值"}
                            ]
                        };
                    }
                    // 为echarts对象加载数据
                    myChart.setOption(option);
                }
        );

        // 使用
        require(
                [
                    'echarts',
                    'echarts/chart/pie',
                    'echarts/chart/funnel'
                ],
                function (ec) {
                    // 基于准备好的dom，初始化echarts图表
                    var myChart = ec.init(document.getElementById('main2'));
//                    myChart.showLoading({
//                        text:"图表数据正在努力加载..."
//                    });
                    var option = {
                        title:{
                            text:'今日充值消费报表',
                            x:'center'
                        },
                        tooltip:{
                            show:true,
                            trigger:'item',
                            formatter:"{a}<br/>{b} : {c} ({d}%)"
                        }, legend:{
                            orient:'vertical',
                            x:'left',
                            data:['充值', '消费']
                        },
                        calculable:true,
                        series:[
                            {
                                "name":"总金额(元)",
                                "type":"pie",
                                radius:'55%',
                                center:['50%', '60%'],
                                "data":${resultList}
                            }
                        ],
                        toolbox:{
                            show:true,
                            feature:{
                                dataView:{show:true, readOnly:false},
                                magicType:{
                                    show:true,
                                    type:['pie', 'funnel'],
                                    option:{
                                        funnel:{
                                            x:'25%',
                                            width:'50%',
                                            funnelAlign:'left',
                                            max:1548
                                        }
                                    }
                                },
                                restore:{show:true},
                                saveAsImage:{show:true}
                            }
                        }
                    };
                    // 为echarts对象加载数据
                    myChart.setOption(option);
//                    myChart.hideLoading();
                }
        );
    </script>
</div>
</body>
</html>
<r:script>
    function checkForm() {
        if (!document.getElementById('date_year').value) {
            alert('请选择查询年份');
            return false;
        }
        return true;
    }
</r:script>