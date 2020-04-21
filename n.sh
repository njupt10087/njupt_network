#!/bin/bash
logger "【Dr.COM网页认证】开始定时检测"
curl http://p.njupt.edu.cn> drcom.html
#获取本机ip地址 
arIpAddress4 () {
ifconfig eth2.2|grep inet|awk '{print $2}'|tr -d "addr:"
}
wanip=$(arIpAddress4)
#echo $wanip
check_status=`grep "Dr.COMWebLoginID_0.htm" drcom.html`
if [[ $check_status != "" ]]
then
    #尚未登录
    logger "【Dr.COM网页认证】上网登录窗尚未登录"


curl -X POST "http://p.njupt.edu.cn:801/eportal/?c=ACSetting&a=Login&protocol=http:&hostname=p.njupt.edu.cn&iTermType=1&wlanuserip=${wanip}&wlanacip=null&wlanacname=SPL_ME60&mac=00-00-00-00-00-00&ip=$wanip&enAdvert=0&queryACIP=0&loginMethod=1" -H "Connection: keep-alive" -H "Cache-Control: max-age=0" -H "Origin: http://p.njupt.edu.cn" -H "Upgrade-Insecure-Requests: 1" -H "DNT: 1" -H "Content-Type: application/x-www-form-urlencoded" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3" -H "Referer: http://p.njupt.edu.cn/a70.htm?wlanuserip=${wanip}&wlanacip=null&wlanacname=SPL_ME60&vlanid=0&ip=${wanip}&ssid=null&areaID=null&mac=00-00-00-00-00-00" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7" -H "Cookie: program=2; vlan=0; ssid=null; areaID=null; ip=${wanip}; ISP_select=@cmcc; md5_login2=用户名; PHPSESSID=id信息，抓包获取" --data "DDDDD=用户名&upass=密码&R1=0&R2=0&R3=0&R6=0&para=00&0MKKey=123456&buttonClicked=&redirect_url=&err_flag=&username=&password=&user=&cmd=&Login=&v6ip=" --compressed --insecure -o Sxinfo.txt

    logger "【Dr.COM网页认证】上网登录窗未登录，现已登录"
else
    #已经登录
    logger "【Dr.COM网页认证】上网登录窗之前已登录"
fi
logger "【Dr.COM网页认证】结束定时检测"
