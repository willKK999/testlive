

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OLPixelManager : NSObject

/**
 *  单例
 *
 *  @return 返回单例对象
 */
+ (instancetype)sharedManager;

- (NSString*)getImageFingerString:(UIImage*)image;


- (BOOL)fingerSame:(UIImage *)imageA withImage:(UIImage *)imageB;

- (NSString*)getKeys;

- (NSString*)getKeys:(int)type;

@end
