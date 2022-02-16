//
//  URLMacros.h
//  yun_7
//
//  Created by xhx on 2017/5/18.
//  Copyright © 2017年 xhx. All rights reserved.
//



#ifndef URLMacros_h
#define URLMacros_h


//内部版本号 每次发版递增
#define KVersionCode 1
/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

#define DevelopSever    1
#define TestSever       0
#define ProductSever    0

#if DevelopSever
/**开发服务器*/

#define URL_DOMAIN @"http://54.180.119.120:4040/"
#define URL_SOCKET @"ws://192.168.0.66:7272"
//#define URL_DOMAIN @"https://api.spirit.nasinet.com/"
//#define URL_SOCKET @"wss://api.spirit.nasinet.com/wss"
#elif TestSever
/**测试服务器*/
#define URL_DOMAIN @"https://dev.live.nasinet.com/"
#define URL_SOCKET @"ws://192.168.0.66:7272"

#elif ProductSever
/**生产服务器*/
#define URL_DOMAIN @"https://api.live.nasinet.com/"
/**socket服务器*/
#define URL_SOCKET @"ws://192.168.0.66:7272"

#endif

#define  appKey   @"1"

#pragma mark - ——————— 接口地址 ————————

//测试接口
#define URL_Test @"/api/cast/home/start"
#define API(str) [NSString stringWithFormat:@"%@api/%@",URL_DOMAIN,str]
#define H5_href(str) [NSString stringWithFormat:@"%@h5/%@",URL_DOMAIN,str]

#define HREF_RegistProtocol [NSString stringWithFormat:@"%@/h5/privacy/1",[configManager appConfig].site_domain]
#define HREF_UserProtocol [NSString stringWithFormat:@"%@/h5/privacy/2",[configManager appConfig].site_domain]
#define HREF_About [NSString stringWithFormat:@"%@/h5/about",[configManager appConfig].site_domain]

#endif /* URLMacros_h */
