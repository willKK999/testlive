//
//  PortraitLiveViewController.m
//  onelive
//
//  Created by kevin chen on 2022/1/3.
//
#import "onelive-Swift.h"
#import "PortraitLiveViewController.h"
#import "IQKeyboardManager.h"
#import "CommonManager.h"

@interface PortraitLiveViewController ()

@property (weak, nonatomic) IBOutlet UIView *controlView;
@property (weak, nonatomic) IBOutlet UIImageView *bgHolderImgView;
@property (weak, nonatomic) IBOutlet UIView *playerContainerView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *anchorIconView;
@property (weak, nonatomic) IBOutlet UILabel *anchorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *liveHotLabel;
@property (weak, nonatomic) IBOutlet UIButton *attentBtn;
@property (weak, nonatomic) IBOutlet UIButton *showGoodsBtn;
@property (weak, nonatomic) IBOutlet UITableView *msgTableView;
@property (weak, nonatomic) IBOutlet UIButton *sendMsgBtn;
@property (weak, nonatomic) IBOutlet UIView *rankContainerView;
@property (weak, nonatomic) IBOutlet UILabel *audienceCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *bannedUserListBtn;
@property (weak, nonatomic) IBOutlet UILabel *guardCountLabel;

@property (weak, nonatomic) IBOutlet UIView *pkView;
@property (weak, nonatomic) IBOutlet UIView *pkPlayerView1;
@property (weak, nonatomic) IBOutlet UIView *pkPlayerView2;
@property (weak, nonatomic) IBOutlet UIView *scoreView1;
@property (weak, nonatomic) IBOutlet UIView *scoreView2;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel1;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel2;
@property (weak, nonatomic) IBOutlet UILabel *pkTimerLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scoreView1WidthLC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scoreView2WidthLC;
@property (weak, nonatomic) IBOutlet UIImageView *pkResultImgView1;
@property (weak, nonatomic) IBOutlet UIImageView *pkResultImgView2;
@property (weak, nonatomic) IBOutlet UIImageView *pkResultImgView3;

@property (weak, nonatomic) IBOutlet UIView *pkHolderView;
@property (weak, nonatomic) IBOutlet UIView *pkAnchorView;
@property (weak, nonatomic) IBOutlet UILabel *pkAnchorNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pkAnchorIconView;
@property (weak, nonatomic) IBOutlet UIButton *pkAnchorAttentBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pkAnchorViewLeadingLC;


@property (weak, nonatomic) IBOutlet UIView *explainingGoodsView;
@property (weak, nonatomic) IBOutlet UIImageView *explainingGoodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *explainingGoodsPriceLabel;

@property (strong, nonatomic) UICollectionView *rankUserCollectionView;

@property (weak, nonatomic) IBOutlet UIView *localContainerView;
@property (weak, nonatomic) IBOutlet UIView *localPreviewView;


@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic,assign)  NSInteger timerCount;

@property (nonatomic,assign)NSInteger liveID ;
@end

@implementation PortraitLiveViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    if (!self.timer) {
        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            if (self.timerCount == 60) {
                self.timerCount = 0;
//                [self getLiveInfo];
//                if (self.liveModel.room_type == LiveRoomTypeFee) {
                    //执行扣费
//                    [self doDeduct];
//                }
            }
            self.timerCount ++;
        }];

        [self.timer fire];
    }
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    OLLiveItemModel *model = (OLLiveItemModel *) self.live;
    _liveID = model.studioId;
    NSLog(@"userid %ld %ld %@",(long)model.userId, model.viewsNumber, model.studioTitle);
//    [self loadData];
}

- (instancetype)init{
    if (self = [super init]) {
//        self.StatusBarStyle = UIStatusBarStyleLightContent;
    }
    return self;
}


- (void)loadData{
    [self getLiveInfo];
//    [self getGoodsList];
//    [self checkIsMgr];
//    [self getGuardInfo];
//    [self getGuardianCount];
}

- (void)getLiveInfo{
    
    [CommonManager POST:@"live/pc/v1/getRoomDetail" parameters:@{@"studioNum":@(_liveID)} success:^(id responseObject) {
        if (RESP_SUCCESS(responseObject)) {
            NSDictionary *dataDict = responseObject[@"data"];
//            self.liveModel = [LiveModel yy_modelWithDictionary:dataDict[@"live"]];
//            self.topUserArray = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[IntimacyModel class] json:dataDict[@"contribute"]]];
//            [self.rankUserCollectionView reloadData];
//            [self fillViewLiveData];
        }else{
//            QNAlertView *alertView = [QNAlertView showAlertViewWithType:QNAlertTypeTitle title:@"" contentText:@"本场直播已结束" singleButton:@"确定" buttonClick:^{
//                [self.navigationController popViewControllerAnimated:YES];
//            }];
//            alertView.cancelBackTap = YES;
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
