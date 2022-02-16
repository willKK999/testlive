

#import "onelive-Swift.h"
#import "OLLiveDetailVC.h"

@interface OLLiveDetailVC ()

@end

@implementation OLLiveDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    OLLiveItemModel *model = (OLLiveItemModel *) self.live;
    NSLog(@"userid %ld %ld %@",(long)model.userId, model.viewsNumber, model.studioTitle);
}



@end
