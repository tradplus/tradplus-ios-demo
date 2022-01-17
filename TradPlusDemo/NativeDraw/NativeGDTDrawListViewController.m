//
//  NativeGDTDrawListViewController.m
//  fluteSDKSample
//
//  Created by xuejun on 2021/12/31.
//  Copyright © 2021 TradPlus. All rights reserved.
//

#import "NativeGDTDrawListViewController.h"
#import "GDTUnifiedNativeAd.h"
#import "GDTUnifiedNativeAdDataObject.h"
#import "NativeGDTDrawView.h"

@interface NativeGDTDrawListViewController ()<UITableViewDelegate,UITableViewDataSource,GDTUnifiedNativeAdViewDelegate>

@property (nonatomic,weak)IBOutlet UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *viewList;
@end

@implementation NativeGDTDrawListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewList = [[NSMutableArray alloc] init];
    id customObject = self.nativeObject.customObject;
    if([customObject isKindOfClass:[NSArray class]])
    {
        for(id item in customObject)
        {
            if([item isKindOfClass:[GDTUnifiedNativeAdDataObject class]])
            {
                NativeGDTDrawView *drawView = [[NSBundle mainBundle] loadNibNamed:@"NativeGDTDrawView" owner:self options:nil].lastObject;
                drawView.delegate = self;
                drawView.viewController = self;
                drawView.frame = [UIScreen mainScreen].bounds;
                [drawView setupWithObject:item];
                [drawView layoutIfNeeded];
                [self.viewList addObject:drawView];
            }
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.myTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen mainScreen].bounds.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIView *adView = self.viewList[indexPath.row];
    [cell.contentView addSubview:adView];
    return cell;
}

#pragma mark - GDTUnifiedNativeAdViewDelegate

- (void)gdt_unifiedNativeAdViewWillExpose:(GDTUnifiedNativeAdView *)unifiedNativeAdView
{
    //调用TP的回调及埋点 展示
    [self.nativeObject.adapter AdShowNoLimit];
}


- (void)gdt_unifiedNativeAdViewDidClick:(GDTUnifiedNativeAdView *)unifiedNativeAdView
{
    //调用TP的回调及埋点 点击
    [self.nativeObject.adapter AdClick];
}


- (void)gdt_unifiedNativeAdDetailViewClosed:(GDTUnifiedNativeAdView *)unifiedNativeAdView
{
    //调用TP的回调及埋点 关闭
    [self.nativeObject.adapter AdClose];
}
@end
