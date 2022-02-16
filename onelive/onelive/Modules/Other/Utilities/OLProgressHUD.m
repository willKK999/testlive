

#import "OLProgressHUD.h"
#import "SVProgressHUD.h"

@implementation OLProgressHUD

+ (void)show {
    [SVProgressHUD show];
}

+ (void)showWithStatus:(NSString *)Status {
    [SVProgressHUD showWithStatus:Status];
}

+ (void)showMessage:(NSString *)message
{
    [self hideHUD];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
//    [SVProgressHUD setCornerRadius:5];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:message];
  
    [SVProgressHUD dismissWithDelay:2];
    
}

+ (void)hideHUD {
    [SVProgressHUD dismiss];
}

@end
