//
//  CommonManager.m
//  JYZC
//
//  Created by yun_7 on 2018/8/15.
//  Copyright © 2018年 yun_7. All rights reserved.
//

#import "onelive-Swift.h"
#import "CommonManager.h"

@interface CommonManager(){
//    QNActivityIndicatorView *qnAcHud;
}

@end

@implementation CommonManager

SINGLETON_FOR_CLASS(CommonManager);

+ (NSURLSessionTask *)POST:(NSString *)api
                parameters:(id)parameters
                   success:(QNHttpRequestSuccess)success
                   failure:(QNHttpRequestFailed)failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    if (userManager.curUserInfo) {
//        params[@"uid"] = @(userManager.curUserInfo.userid);
//        params[@"token"] = userManager.curUserInfo.token;
//    }

    return [QNNetworkHelper POST:API(api) parameters:params success:^(id responseObject) {
        NSLog(@"srnetwork %@\n%@",API(api),responseObject);
        if (RESP_LOGINTIMEOUT(responseObject)) {
          
          
            success ? success(responseObject) : nil;
        }else{
            success ? success(responseObject) : nil;
        }
    } failure:^(NSError *error) {
        NSLog(@"srnetwork %@\n%@",API(api),error);
        failure ? failure(error) : nil;
    }];
}


+(NSString *)getNowTimeTimestamp3{

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];

    return timeSp;
}
+(NSString *)getRandom{
    int num =  arc4random() % 10000 + 1 ;
    
    return NSStringFormat(@"%d",num);
}

+(NSString *)getAppKey {
    
    switch ([appKey intValue]) {
        case 1:
            return @"c1kgVioySoUVimtw";
            break;
        case 2:
            return @"f2kgVioykoURWmtg";
            break;
        case 3:
            return @"e3kgGioydoURWmtf";
            break;
        case 4:
            return @"b9rtFfoydoURnjtp";
            break;
        case 5:
            return @"t6rtTfmcdoURnjth";
            break;
            
        default:
            return @"c1kgVioySoUVimtw";
            break;
    }
}
@end
