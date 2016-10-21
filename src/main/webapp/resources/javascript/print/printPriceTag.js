$(function(){
    $.pad = function(v, n){
        n = n || 2;
        v = v+'';
        while(v.length<n) v = '0'+v;
        return v;
    };
    var date_pad = $.pad;
    var date = $.date = function(v, f, op){
        v = date.toObj(v);
        if(!v) return '';
        if(op) v = new Date(v*1+op);
        return date.format(v, f);
    };
    var date_regInt=/^[0-9]+$/, date_regSep = /-/g, date_regFormat=/\[[a-z]{1,2}\]/gi, date_repZero=/(^|\/)[0]+(\/|$)/g;
// toDate:1441667165004   s20150908070605004    2015-09-8 07:6:5.004    2015/9/08 7:06:05.004    2015-09-08T07:06:5.004Z
    date.toObj = function(v){
        if(!v && v!==0) return null;
        if(v === true) return new Date();
        if(v instanceof Date) return v;
        if(date_regInt.test(v+'')) return new Date(v*1);
        if(v.charAt(0)!='s') v = v.replace('T', ' ').replace('Z','').replace(date_regSep, '/');
        else{
            var x = v.substr(1), n = x.length;
            if(n<4 || !date_regInt.test(x)) return null;
            v = x.substr(0, 4) + (n<6?'':'/'+x.substr(4,2)+ (n<8?'':'/'+x.substr(6,2)+
                (n<10?'':' '+x.substr(8,2)+ (n<12?'':':'+x.substr(10,2)+ (n<14?'':':'+x.substr(12,2)+
                (n<17?'':'.'+x.substr(14,3)))))));
        }
        v = v.replace(date_repZero, "$11$2");
        if(v.length<6) v += '/1/1';  else if(v.length<8) v += '/1'; // <=IE8
        v = v.split('.'); // <=IE11 毫秒
        if(v[0].indexOf(' ')>0 && v[0].indexOf(':')<0) v[0] += ':0';// 有时无分
        return v[1] ? new Date(new Date(v[0])*1+parseInt(v[1])) : new Date(v[0]);
    };
    date.format = function(v, f){
        if(f == 'o') return v;
        if(f == 'u') return v*1;
        if(!f) f = 'n';
        f = date.inlayDateFormat[f] || f;
        return f.replace(date_regFormat, function(k){
            k = k.substr(1, k.length-2);
            switch(k){
                case 'Y' : return v.getFullYear();                              // 年 4位 eg:2015
                case 'M' : return date_pad(v.getMonth()+1,2);                   // 月 eg: 01/12
                case 'mc': return date.monthCh[v.getMonth()];                   // 月 汉语 eg: 一/十二
                case 'D' : return date_pad(v.getDate(),2);                      // 日 eg 01/31
                case 'wc': return date.weekCh[v.getDay()];                      // 星期 汉语 eg:一/日
                case 'H' : return date_pad(v.getHours(),2);                     // 时 24小时格式 eg:00/23
                case 'N' : return date_pad(v.getMinutes(),2);                   // 分 eg:00/59
                case 'S' : return date_pad(v.getSeconds(),2);                   // 秒 eg:00/59
                case 'I' : return date_pad(v.getMilliseconds(),3);              // 毫秒 eg:000/999
                //case 'y' : return (v.getFullYear()+'').substr(2);               // 年 2位 eg:15
                //case 'm' : return v.getMonth()+1;                               // 月 eg: 1/12
                //case 'ME': return date.monthEn[v.getMonth()];                   // 月 英语全拼 eg:January/December
                //case 'me': return date.monthEn[v.getMonth()].substr(0,3);       // 月 英语简写 eg:Jan/Dec
                //case 'd' : return v.getDate();                                  // 日 eg 1/31
                //case 'dy': return date.dayInYear(v);                            // 年内第几天 eg:1/365     1开始
                //case 'DY': return date_pad(date.dayInYear(v),3);                // 年内第几天 eg:001/365   1开始
                //case 'w' : return v.getDay();                                   // 星期 数字 eg:1/0   (0为星期日)
                //case 'WE': return date.weekEn[v.getDay()];                      // 星期 英语全拼 eg:Monday/Sunday
                //case 'we': return date.weekShort[v.getDay()];                   // 星期 英语简写 eg:Mon/Sun
                //case 'wy': return date.weekInYear(v);                           // 年内第几周 eg:1/11   1开始
                //case 'WY': return date_pad(date.weekInYear(v),2);               // 年内第几周 eg:01/11   1开始
                //case 'h' : return v.getHours();                                 // 时 24小时格式 eg:0/23
                //case 'ha': return (k=v.getHours()||24)>12?k-12:k;               // 时 12小时格式 eg:1/12
                //case 'HA': return date_pad((k=v.getHours()||24)>12?k-12:k,2);   // 时 12小时格式 eg:01/12
                //case 'n' : return v.getMinutes();                               // 分 eg:0/59
                //case 's' : return v.getSeconds();                               // 秒 eg:0/59
                //case 'i' : return v.getMilliseconds();                          // 毫秒 eg:0/999
                //case 'a' : return v.getHours()>12?'pm':'am';                    // 上下午 eg:am/pm
                //case 'A' : return v.getHours()>12?'PM':'AM';                    // 上下午 eg:AM/PM
                //case 'ac': return v.getHours()>12?'上午':'下午';                // 上下午 汉语 eg:上午/下午
                //case 'bc':  // 每日时间段 午夜[0,1) 凌晨[1,6) 早上[6,9) 上午[9,12) 中午[12,13) 下午[13,18) 傍晚[18,19) 晚上[19,22) 深夜[22,0)
                //    return (k=v.getHours())<1?'午夜':(k<6?'凌晨':(k<9?'早上':(k<12?'上午':(k<13?'中午':(k<18?'下午':(k<19?'傍晚':(k<22?'晚上':'深夜')))))));
                default : return '['+k+']';
            }
        });
    };
    date.inlayDateFormat = { // o:对象 u:时间戳
        n: '[Y]-[M]-[D] [H]:[N]'
        ,b: '[Y]-[M]-[D] [H]:[N]:[S]'
        ,d: '[Y]-[M]-[D]'
        ,m: '[Y]-[M]'
        ,M: '[Y]年[M]月'
        //i : '[Y]-[M]-[D]T[H]:[N]:[S].[I]Z'
        //g : '[we], [M] [me] [Y] [H]:[N]:[S] GMT',
        //S : '[Y][M][D][H][N][S][I]',
        //s : '[Y][M][D][H][N][S]'
    };
    date.monthCh = ['一','二','三','四','五','六','七','八','九','十','十一','十二'];
    date.weekCh = ['日','一','二','三','四','五','六'];

    $.fixed = function(v, n, p, t){
        // v:要转化的数字   n:小数位数   p:是否补位    t:0(四舍五入,默认),-1(向下取整),1(向上取整)
        n = n || 2;
        var x = ('1'+(new Array(n+1)).join('0'))*1;
        v = Math[t==-1?'floor':(t==1?'ceil':'round')](v*x)/x;
        if(p){
            v = (v+'').split('.');
            x = v[1] ? v[1].length : 0;
            x = (v[1]||'')+(new Array(n-x+1)).join('0');
            v = v[0]+'.'+x;
        }
        return v;
    };

    $.mathMul = function(a, b, argN){ // 乘法
        var v=arguments[0];
        for(var len=arguments.length,i=1,x,n; i<len; i++){
            x = (v+'').split('.');
            n = x[1] ? x[1].length : 0;
            x = (arguments[i]+'').split('.');
            if(x[1]) n += x[1].length;
            v = (v+'').replace('.', '') * (arguments[i]+'').replace('.', '')/Math.pow(10, n);
        }
        return v;
    };
    $.mathDiv = function(a, b){ // 除法
        var an, bn;
        a = a+'';
        b = b+'';
        an = a.split('.');
        an = an[1] ? an[1].length : 0;
        bn = b.split('.');
        bn = bn[1] ? bn[1].length : 0;
        return $.mathMul(a.replace('.','')/b.replace('.',''), Math.pow(10, bn-an));
    };
    $.mathAdd = function(a ,b, argN){ // 加法/减法
        var v=arguments[0];
        for(var len=arguments.length,i=1,x,n; i<len; i++){
            x = (v+'').split('.');
            n = x[1] ? x[1].length : 0;
            x = (arguments[i]+'').split('.');
            n = Math.max(n, x[1]?x[1].length:0);
            x = Math.pow(10, n);
            v = $.mathMul($.mathMul(v, x)+$.mathMul(arguments[i], x), Math.pow(10, -n));
        }
        return v;
    };

    // 前加'0'补位
    var pad = function(v, n){
        v = v+'';
        n = n || 2;
        while(v.length<n) v = '0'+v;
        return v;
    };

    // parse uDate
    var uDate = function(v, rtLen){
        if(!v) return '';
        v = v+'';
        v = v.length==10 ? v*1000 : v*1;
        v = new Date(v);
        v = v.getFullYear()+'-'+pad(v.getMonth()+1)+'-'+pad(v.getDate())+' '+pad(v.getHours())+':'+pad(v.getMinutes());
        return rtLen ? v.substr(0, rtLen) : v;
    };

    $(".PrintBtn").on("click", function(){
        window.print();
    });

    $(".ChangeBind").on("change input", function(){
        var className = "." + $(this).attr("id").replace("Action", "");
        var val = $(this).val();
        $(className).text(val);
        var maxlength = $(this).attr("maxlength");
        var leftWord = maxlength - val.length;
        if (leftWord < 0) {
            leftWord = 0;
        }
        $($(this).data("notice")).find("span").text(leftWord);
    });
    $(".ChangeBind").each(function(){
        var className = "." + $(this).attr("id").replace("Action", "");
        $(this).val($(className).text());
    });
    $(".ChangeBind").trigger("change");

    var calcFirstPay = function(tot){
        var loanMoney = $.mathMul(
            Math.floor($.mathDiv($.mathMul(tot, 0.7), 1000)),
            1000
        );
        return $.fixed($.mathAdd(tot, -loanMoney));
    };
    $(".FormatDate").each(function(){
        $(this).text($.date('s' + $(this).text(), 'M'));
    });
    $(".FormatUDate").each(function(){
        $(this).text(uDate($(this).text, 10).replace("-", "年").replace("-", "月"));
    });
});

