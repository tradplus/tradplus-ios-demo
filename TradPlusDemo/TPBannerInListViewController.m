//
//  TPBannerInListViewController.m
//  TradPlusDemo
//

#import "TPBannerInListViewController.h"
#import <TradPlusAds/TradPlusAdBanner.h>

static const NSInteger kBannerAdInterval = 8;
static const NSInteger kTotalRowCount = 50;
static const CGFloat kBannerRowHeight = 50;
static const CGFloat kContentRowHeight = 60;
static const NSInteger kInvalidRow = -1;

@interface TPBannerContentCell : UITableViewCell
@property (nonatomic, strong) UILabel *indexLabel;
@end

@implementation TPBannerContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.indexLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.indexLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.indexLabel.textAlignment = NSTextAlignmentCenter;
        self.indexLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.indexLabel];
        [NSLayoutConstraint activateConstraints:@[
            [self.indexLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16],
            [self.indexLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16],
            [self.indexLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor]
        ]];
    }
    return self;
}

@end

@interface TPBannerAdCell : UITableViewCell
@property (nonatomic, strong) UIView *bannerContainer;
@end

@implementation TPBannerAdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1];

        self.bannerContainer = [[UIView alloc] initWithFrame:CGRectZero];
        self.bannerContainer.translatesAutoresizingMaskIntoConstraints = NO;
        self.bannerContainer.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.bannerContainer];

        [NSLayoutConstraint activateConstraints:@[
            [self.bannerContainer.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
            [self.bannerContainer.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
            [self.bannerContainer.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
            [self.bannerContainer.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor]
        ]];
    }
    return self;
}

@end

@interface TPBannerInListViewController ()<UITableViewDelegate, UITableViewDataSource, TradPlusADBannerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *logLabel;
@property (nonatomic, strong) TradPlusAdBanner *banner;
/// Banner 当前挂载在哪一行
@property (nonatomic, assign) NSInteger attachedRow;
/// 当前行已成功展现过（避免重复 show 闪烁）
@property (nonatomic, assign) NSInteger shownRow;
/// 当前 load 对应哪一行，kInvalidRow 表示未在加载
@property (nonatomic, assign) NSInteger loadingRow;
@end

@implementation TPBannerInListViewController

- (BOOL)isAdRowAtIndex:(NSInteger)index
{
    return index > 0 && index % kBannerAdInterval == 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"列表中展示横幅";
    self.view.backgroundColor = [UIColor whiteColor];
    self.attachedRow = kInvalidRow;
    self.shownRow = kInvalidRow;
    self.loadingRow = kInvalidRow;

    self.banner = [[TradPlusAdBanner alloc] init];
    [self.banner setAdUnitID:@"6008C47DF1201CC875F2044E88FCD287"];
    self.banner.delegate = self;
    self.banner.autoShow = NO;

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerClass:[TPBannerContentCell class] forCellReuseIdentifier:@"TPBannerContentCell"];
    [self.tableView registerClass:[TPBannerAdCell class] forCellReuseIdentifier:@"TPBannerAdCell"];
    [self.view addSubview:self.tableView];

    self.logLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.logLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.logLabel.textAlignment = NSTextAlignmentCenter;
    self.logLabel.font = [UIFont systemFontOfSize:13];
    self.logLabel.textColor = [UIColor darkGrayColor];
    self.logLabel.numberOfLines = 2;
    self.logLabel.text = [NSString stringWithFormat:@"每 %ld 行插入一条 Banner", (long)kBannerAdInterval];
    [self.view addSubview:self.logLabel];

    UILayoutGuide *safeArea = self.view.safeAreaLayoutGuide;
    [NSLayoutConstraint activateConstraints:@[
        [self.logLabel.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor constant:12],
        [self.logLabel.trailingAnchor constraintEqualToAnchor:safeArea.trailingAnchor constant:-12],
        [self.logLabel.topAnchor constraintEqualToAnchor:safeArea.topAnchor constant:8],
        [self.logLabel.heightAnchor constraintEqualToConstant:36],

        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.tableView.topAnchor constraintEqualToAnchor:self.logLabel.bottomAnchor constant:8],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self refreshBannerForVisibleAdRow];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kTotalRowCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self isAdRowAtIndex:indexPath.row] ? kBannerRowHeight : kContentRowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isAdRowAtIndex:indexPath.row])
    {
        return [tableView dequeueReusableCellWithIdentifier:@"TPBannerAdCell" forIndexPath:indexPath];
    }

    TPBannerContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TPBannerContentCell" forIndexPath:indexPath];
    cell.indexLabel.text = [NSString stringWithFormat:@"内容行 %ld", (long)(indexPath.row + 1)];
    return cell;
}

#pragma mark - Banner in list

- (nullable NSIndexPath *)firstVisibleAdIndexPath
{
    NSArray<NSIndexPath *> *visibleRows = [self.tableView.indexPathsForVisibleRows sortedArrayUsingComparator:^NSComparisonResult(NSIndexPath *obj1, NSIndexPath *obj2) {
        return [@(obj1.row) compare:@(obj2.row)];
    }];
    for (NSIndexPath *indexPath in visibleRows)
    {
        if ([self isAdRowAtIndex:indexPath.row])
        {
            return indexPath;
        }
    }
    return nil;
}

- (void)refreshBannerForVisibleAdRow
{
    NSIndexPath *indexPath = [self firstVisibleAdIndexPath];
    if (indexPath == nil)
    {
        return;
    }

    TPBannerAdCell *cell = (TPBannerAdCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil)
    {
        return;
    }

    [self attachBannerToCell:cell atRow:indexPath.row];
}

- (void)attachBannerToCell:(TPBannerAdCell *)cell atRow:(NSInteger)row
{
    BOOL alreadyInContainer = (self.banner.superview == cell.bannerContainer);
    if (self.attachedRow == row && alreadyInContainer)
    {
        return;
    }

    if (self.attachedRow != row)
    {
        self.shownRow = kInvalidRow;
    }

    if (!alreadyInContainer)
    {
        [cell layoutIfNeeded];
        [self.banner removeFromSuperview];
        self.banner.frame = cell.bannerContainer.bounds;
        self.banner.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [cell.bannerContainer addSubview:self.banner];
    }
    self.attachedRow = row;

    if (self.banner.isAdReady)
    {
        [self showBannerIfNeededForRow:row];
        return;
    }

    if (self.loadingRow != kInvalidRow)
    {
        self.loadingRow = row;
        self.logLabel.text = [NSString stringWithFormat:@"第 %ld 行等待 Banner 加载", (long)(row + 1)];
        return;
    }

    self.loadingRow = row;
    self.logLabel.text = [NSString stringWithFormat:@"第 %ld 行开始加载 Banner", (long)(row + 1)];
    [self.banner loadAdWithSceneId:nil];
}

- (void)showBannerIfNeededForRow:(NSInteger)row
{
    if (self.shownRow == row)
    {
        return;
    }
    self.logLabel.text = [NSString stringWithFormat:@"第 %ld 行展示 Banner", (long)(row + 1)];
    [self.banner showWithSceneId:nil];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self refreshBannerForVisibleAdRow];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self refreshBannerForVisibleAdRow];
    }
}

#pragma mark - TradPlusADBannerDelegate

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

- (void)tpBannerAdLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__, adInfo);
    self.loadingRow = kInvalidRow;

    if (self.attachedRow == kInvalidRow)
    {
        return;
    }

    self.logLabel.text = [NSString stringWithFormat:@"第 %ld 行加载成功", (long)(self.attachedRow + 1)];
    [self showBannerIfNeededForRow:self.attachedRow];
}

- (void)tpBannerAdLoadFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@", __FUNCTION__, error);
    self.loadingRow = kInvalidRow;
    self.logLabel.text = [NSString stringWithFormat:@"加载错误：%ld", (long)error.code];
}

- (void)tpBannerAdIsLoading:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__, adInfo);
}

- (void)tpBannerAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@ %@", __FUNCTION__, adInfo, error);
    self.shownRow = kInvalidRow;
    self.logLabel.text = [NSString stringWithFormat:@"展现失败：%ld", (long)error.code];
}

- (void)tpBannerAdClicked:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__, adInfo);
}

- (void)tpBannerAdImpression:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__, adInfo);
    self.shownRow = self.attachedRow;
}

@end
