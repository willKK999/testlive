

#import "OLKeychain.h"

NSString * const KEY_UDID_INSTEAD = @"com.BoLe.onelive";
@implementation OLKeychain
+(NSString *)getDeviceIDInKeychain
{
    NSString *getUDIDInKeychain = (NSString *)[OLKeychain load:KEY_UDID_INSTEAD];
    NSLog(@"从keychain中获取到的 UDID_INSTEAD %@",getUDIDInKeychain);
    if (!getUDIDInKeychain ||[getUDIDInKeychain isEqualToString:@""]||[getUDIDInKeychain isKindOfClass:[NSNull class]]) {
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);
        NSLog(@"\n \n \n _____重新存储 UUID _____\n \n \n  %@",result);
        [OLKeychain save:KEY_UDID_INSTEAD data:result];
        getUDIDInKeychain = (NSString *)[OLKeychain load:KEY_UDID_INSTEAD];
    }
    NSLog(@"最终 ———— UDID_INSTEAD %@",getUDIDInKeychain);
    return getUDIDInKeychain;
}

#pragma mark - private

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}



+(NSString *)getDeviceInfo{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    // 获取设备标识Identifier

    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];

    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus (A1897)";
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    if ([platform isEqualToString:@"iPhone12,8"]) return @"iPhone SE (2nd generation)";
    if ([platform isEqualToString:@"iPhone13,1"]) return @"iPhone 12 mini";
    if ([platform isEqualToString:@"iPhone13,2"]) return @"iPhone 12";
    if ([platform isEqualToString:@"iPhone13,3"]) return @"iPhone 12 Pro";
    if ([platform isEqualToString:@"iPhone13,4"]) return @"iPhone 12 Pro Max";
    if ([platform isEqualToString:@"iPhone14,4"]) return @"iPhone 13 mini";
    if ([platform isEqualToString:@"iPhone14,5"]) return @"iPhone 13";
    if ([platform isEqualToString:@"iPhone14,2"]) return @"iPhone 13 Pro";
    if ([platform isEqualToString:@"iPhone14,3"]) return @"iPhone 13 Pro Max";


    //iPad
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad (3rd generation)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad (3rd generation)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad (3rd generation)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad (4th generation)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad (4th generation)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad (4th generation)";
    if ([platform isEqualToString:@"iPad6,11"])  return @"iPad (5th generation)";
    if ([platform isEqualToString:@"iPad6,12"])  return @"iPad (5th generation)";
    if ([platform isEqualToString:@"iPad7,5"])   return @"iPad (6th generation)";
    if ([platform isEqualToString:@"iPad7,6"])   return @"iPad (6th generation)";
    if ([platform isEqualToString:@"iPad7,11"])  return @"iPad (7th generation)";
    if ([platform isEqualToString:@"iPad7,12"])  return @"iPad (7th generation)";
    if ([platform isEqualToString:@"iPad11,6"])  return @"iPad (8th generation)";
    if ([platform isEqualToString:@"iPad11,7"])  return @"iPad (8th generation)";


    //iPad Air
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad11,3"])  return @"iPad Air (3rd generation)";
    if ([platform isEqualToString:@"iPad11,4"])  return @"iPad Air (3rd generation)";
    if ([platform isEqualToString:@"iPad13,1"])  return @"iPad Air (4th generation)";
    if ([platform isEqualToString:@"iPad13,2"])  return @"iPad Air (4th generation)";

    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad mini";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad mini";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad mini 1";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad11,1"])  return @"iPad mini 5";
    if ([platform isEqualToString:@"iPad11,2"])  return @"iPad mini 5";

    // iPad Pro
    if ([platform isEqualToString:@"iPad6,3"])    return @"iPad Pro (9.7-inch)";
    if ([platform isEqualToString:@"iPad6,4"])    return @"iPad Pro (9.7-inch)";
    if ([platform isEqualToString:@"iPad6,7"])    return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad6,8"])    return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad7,1"])    return @"iPad Pro (12.9-inch) (2nd generation)";
    if ([platform isEqualToString:@"iPad7,2"])    return @"iPad Pro (12.9-inch) (2nd generation)";
    if ([platform isEqualToString:@"iPad7,3"])  return @"iPad Pro (10.5 inch)";
    if ([platform isEqualToString:@"iPad7,4"])  return @"iPad Pro (10.5-inch)";
    if ([platform isEqualToString:@"iPad8,1"])  return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad8,2"])  return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad8,3"])  return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad8,4"])  return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad8,5"])  return @"iPad Pro (12.9-inch) (3rd generation)";
    if ([platform isEqualToString:@"iPad8,6"])  return @"iPad Pro (12.9-inch) (3rd generation)";
    if ([platform isEqualToString:@"iPad8,7"])  return @"iPad Pro (12.9-inch) (3rd generation)";
    if ([platform isEqualToString:@"iPad8,8"])  return @"iPad Pro (12.9-inch) (3rd generation)";
    if ([platform isEqualToString:@"iPad8,9"])  return @"iPad Pro (11-inch) (2nd generation)";
    if ([platform isEqualToString:@"iPad8,10"])  return @"iPad Pro (11-inch) (2nd generation)";
    if ([platform isEqualToString:@"iPad8,11"])  return @"iPad Pro (12.9-inch) (4th generation)";
    if ([platform isEqualToString:@"iPad8,12"])  return @"iPad Pro (12.9-inch) (4th generation)";

    //iPod Touch
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5";
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPod Touch 6";
    if ([platform isEqualToString:@"iPod9,1"])   return @"iPod Touch 7";

    // Apple Watch
    if ([platform isEqualToString:@"Watch1,1"])   return @"Apple Watch";
    if ([platform isEqualToString:@"Watch1,2"])   return @"Apple Watch";
    if ([platform isEqualToString:@"Watch2,6"])   return @"Apple Watch Series 1";
    if ([platform isEqualToString:@"Watch2,7"])   return @"Apple Watch Series 1";
    if ([platform isEqualToString:@"Watch2,3"])   return @"Apple Watch Series 2";
    if ([platform isEqualToString:@"Watch2,4"])   return @"Apple Watch Series 2";
    if ([platform isEqualToString:@"Watch3,1"])   return @"Apple Watch Series 3";
    if ([platform isEqualToString:@"Watch3,2"])   return @"Apple Watch Series 3";
    if ([platform isEqualToString:@"Watch3,3"])   return @"Apple Watch Series 3";
    if ([platform isEqualToString:@"Watch3,4"])   return @"Apple Watch Series 3";

    // 模拟器
    if ([platform isEqualToString:@"i386"])   return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])  return @"iPhone Simulator";

    return platform;
}

@end
