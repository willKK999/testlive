

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OLProgressHUD : NSObject

/*
 loading 加载提示
 */
+ (void)show;

+ (void)showWithStatus:(NSString *)Status;

/*
 纯文字提示
 */
+ (void)showMessage:(NSString *)message;

+ (void)hideHUD;

@end

NS_ASSUME_NONNULL_END
