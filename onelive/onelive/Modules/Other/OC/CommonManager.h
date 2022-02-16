//
//  CommonManager.h
//  JYZC
//
//  Created by yun_7 on 2018/8/15.
//  Copyright © 2018年 yun_7. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLMacros.h"
#import "UtilsMacros.h"
#import "QNNetworkHelper.h"

#define commonManager [CommonManager sharedCommonManager]

@interface CommonManager : NSObject

//单例
SINGLETON_FOR_HEADER(CommonManager)
@property (nonatomic,copy)NSString *token ;

/** 请求成功的Block */
typedef void(^QNHttpRequestSuccess)(id responseObject);

/** 请求失败的Block */
typedef void(^QNHttpRequestFailed)(NSError *error);

+ (NSURLSessionTask *)POST:(NSString *)api
                parameters:(id)parameters
                   success:(QNHttpRequestSuccess)success
                   failure:(QNHttpRequestFailed)failure;

+(NSString *)getNowTimeTimestamp3;
+(NSString *)getRandom ;
+(NSString *)getAppKey ;

@end
