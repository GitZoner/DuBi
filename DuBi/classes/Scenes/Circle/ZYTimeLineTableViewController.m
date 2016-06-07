//
//  ZYTimeLineTableViewController.m
//  ZYProject1
//
//  Created by lanou3g on 16/5/28.
//  Copyright © 2016年 橙子. All rights reserved.
//

#import "ZYTimeLineTableViewController.h"
#import "SDRefresh.h"


#import "ZYTimeLineRefreshHeader.h"
#import "ZYTimeLinerefreshFooter.h"
#import "ZYTimeLineCell.h"
#import "ZYTimeLineCellModel.h"
#import <AVOSCloud/AVOSCloud.h>
#import "ZYGetObject.h"
#import "UITableView+SDAutoTableViewCellHeight.h"


#import "UIView+SDAutoLayout.h"

#import "JTCircleHeaderView.h"
#import "Color_marco.h"
#define kTimeLineTableViewCellId @"SDTimeLineCell"
#import "Main_marco.h"


static CGFloat textFieldH = 40;


@interface ZYTimeLineTableViewController ()<ZYTimeLineCellDelegate, UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) BOOL isReplayingComment;
@property (nonatomic, strong) NSIndexPath *currentEditingIndexthPath;
@property (nonatomic, copy) NSString *commentToUser;
/*请求的动态avObject对象数组*/
@property (strong, nonatomic) NSMutableArray *avObjectArray;



// 头部视图
@property (strong,nonatomic)JTCircleHeaderView *headerVew;
// 获取数据的所在页
@property (assign,nonatomic)NSInteger dataPageNum;

@end

@implementation ZYTimeLineTableViewController



{
    ZYTimeLinerefreshFooter *_refreshFooter;
    ZYTimeLineRefreshHeader *_refreshHeader;
    CGFloat _lastScrollViewOffsetY;
    CGFloat _totalKeybordHeight;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 背景设置为黑色
    
    self.tableView.backgroundColor = tGrayColor;
   
    // 头部视图
    
    self.tableView.autoresizesSubviews = NO;
    self.headerVew = [[JTCircleHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.7)];
    self.tableView.tableHeaderView =self.headerVew;
    
    self.navigationItem.title = @"我的朋友圈";
    self.view.backgroundColor = tGrayColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    if ([kUserDefaultGetValue(kUserInfoKey_hasSign) isEqualToString:@"YES"]) {
        
    
    [self.dataArray addObjectsFromArray:[self getDeliverDataWithPageNum:self.dataPageNum]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    __weak typeof(self) weakSelf = self;
    
    
    // 上拉加载
        self.dataPageNum = 0;
    _refreshFooter = [ZYTimeLinerefreshFooter refreshFooterWithRefreshingText:@"正在加载数据..."];
    __weak typeof(_refreshFooter) weakRefreshFooter = _refreshFooter;
    [_refreshFooter addToScrollView:self.tableView refreshOpration:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.dataArray addObjectsFromArray:[weakSelf getDeliverDataWithPageNum:++weakSelf.dataPageNum]];
            [weakSelf.tableView reloadData];
            [weakRefreshFooter endRefreshing];
        });
    }];
    
//       SDTimeLineTableHeaderView *headerView = [SDTimeLineTableHeaderView new];
//        headerView.frame = CGRectMake(0, 0, 0, 260);
//       self.tableView.tableHeaderView = headerView;
    
    [self.tableView registerClass:[ZYTimeLineCell class] forCellReuseIdentifier:kTimeLineTableViewCellId];
    
    [self setupTextField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    }
}




- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([kUserDefaultGetValue(kUserInfoKey_hasSign) isEqualToString:@"YES"])  {
    if (!_refreshHeader.superview) {
        
        _refreshHeader = [ZYTimeLineRefreshHeader refreshHeaderWithCenter:CGPointMake(40, 45)];
        _refreshHeader.scrollView = self.tableView;
        __weak typeof(_refreshHeader) weakHeader = _refreshHeader;
        __weak typeof(self) weakSelf = self;
        [_refreshHeader setRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
#warning 从数据库获取发布内容对象，并对获取的对象进行解析，解析数据封装到model
               
                weakSelf.dataArray = [[weakSelf getDeliverDataWithPageNum:weakSelf.dataPageNum] mutableCopy];
                [weakHeader endRefreshing];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                });
            });
        }];
        [self.tableView.superview addSubview:_refreshHeader];
    }
        
        
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_textField resignFirstResponder];
}

- (void)dealloc
{
    [_refreshHeader removeFromSuperview];
    [_refreshFooter removeFromSuperview];
    
    [_textField removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupTextField
{
    _textField = [UITextField new];
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    _textField.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8].CGColor;
    _textField.layer.borderWidth = 1;
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.view.width, textFieldH);
    [[UIApplication sharedApplication].keyWindow addSubview:_textField];
    
    [_textField becomeFirstResponder];
    [_textField resignFirstResponder];
}

/**
 *  从数据库获取朋友圈数据
 *
 *  @param ItemsNum 查询结果，每页的个数
 *  @param pageNum  需要返回第几页的数据
 *
 *  @return 数组
 */


-(NSArray *)getDeliverDataWithPageNum:(NSInteger)pageNum {
    
    AVQuery *query = [AVQuery queryWithClassName:@"userDeliverInfo"];
    NSDate *now = [NSDate date];
    [query whereKey:@"createdAt" lessThanOrEqualTo:now];
    query.limit = 5; // 最多返回 10 条结果
    query.skip = pageNum * 5;  // 跳过 20 条结果
    
    
    
   
    
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    
    for (AVObject *object in self.avObjectArray) {
        
        ZYTimeLineCellModel *zymodel = [ZYTimeLineCellModel new];
        zymodel.userAlias = object[@"userAlias"];
        zymodel.publishType = object[@"publishType"];
        zymodel.msgContent = object[@"msgContent"];
        zymodel.picNamesArray = object[@"picNamesArray"];
        zymodel.iconName = object[@"iconName"];
        
        
        AVRelation *relation = [object relationforKey:@"likeItems"];
        AVQuery *query = [relation query];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (objects.count > 0) {
                // 临时存放点赞model的数组
                NSMutableArray *likeArray = [NSMutableArray array];
                
                for (AVObject *object in objects) {
                    ZYTimeLineCellLikeItemModel *likeModel = [ZYTimeLineCellLikeItemModel new];
                    likeModel.userName = object[@"userAlias"];
                    [likeArray addObject:likeModel];
                }
                
                zymodel.likeItemsArray = likeArray;
                
            }
        }];
        
        
        
        
        
        
        zymodel.createdAt = object[@"createdAt"];
        
        [tempArray addObject:zymodel];
    }
    
    return tempArray;
    
    
    
    
}

/*
- (NSArray *)creatModelsWithCount:(NSInteger)count
{
//    NSArray *iconImageNamesArray = @[@"icon0.jpg",
//                                     @"icon1.jpg",
//                                     @"icon2.jpg",
//                                     @"icon3.jpg",
//                                     @"icon4.jpg",
//                                     ];
//    
//    NSArray *namesArray = @[@"GSD_iOS",
//                            @"风口上的猪",
//                            @"当今世界网名都不好起了",
//                            @"我叫郭德纲",
//                            @"Hello Kitty"];
//    
//    NSArray *textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，https://github.com/gsdios/SDAutoLayout大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
//                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，https://github.com/gsdios/SDAutoLayout等于把小屏完全拉伸。",
//                           @"当你的 app 没有提供 3x 的 LaunchImage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。",
//                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
//                           @"屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
//                           ];
//    
//    NSArray *commentsArray = @[@"社会主义好！👌👌👌👌",
//                               @"正宗好凉茶，正宗好声音。。。",
//                               @"你好，我好，大家好才是真的好",
//                               @"有意思",
//                               @"你瞅啥？",
//                               @"瞅你咋地？？？！！！",
//                               @"hello，看我",
//                               @"曾经在幽幽暗暗反反复复中追问，才知道平平淡淡从从容容才是真",
//                               @"人艰不拆",
//                               @"咯咯哒",
//                               @"呵呵~~~~~~~~",
//                               @"我勒个去，啥世道啊",
//                               @"真有意思啊你💢💢💢"];
//    
//    NSArray *picImageNamesArray = @[ @"pic0.jpg",
//                                     @"pic1.jpg",
//                                     @"pic2.jpg",
//                                     @"pic3.jpg",
//                                     @"pic4.jpg",
//                                     @"pic5.jpg",
//                                     @"pic6.jpg",
//                                     @"pic7.jpg",
//                                     @"pic8.jpg"
//                                     ];
//    NSMutableArray *resArr = [NSMutableArray new];
//    
//    for (int i = 0; i < count; i++) {
//        int iconRandomIndex = arc4random_uniform(5);
//        int nameRandomIndex = arc4random_uniform(5);
//        int contentRandomIndex = arc4random_uniform(5);
//        
//        ZYTimeLineCellModel *model = [ZYTimeLineCellModel new];
//        model.iconName = iconImageNamesArray[iconRandomIndex];
//        model.name = namesArray[nameRandomIndex];
//        model.msgContent = textArray[contentRandomIndex];
//        
//        
//        // 模拟“随机图片”
//        int random = arc4random_uniform(6);
//        
//        NSMutableArray *temp = [NSMutableArray new];
//        for (int i = 0; i < random; i++) {
//            int randomIndex = arc4random_uniform(9);
//            [temp addObject:picImageNamesArray[randomIndex]];
//        }
//        if (temp.count) {
//            model.picNamesArray = [temp copy];
//        }
//        
//        // 模拟随机评论数据
//        int commentRandom = arc4random_uniform(3);
//        NSMutableArray *tempComments = [NSMutableArray new];
//        for (int i = 0; i < commentRandom; i++) {
//            ZYTimeLineCellCommentItemModel *commentItemModel = [ZYTimeLineCellCommentItemModel
//                                                                new];
//            int index = arc4random_uniform((int)namesArray.count);
//            commentItemModel.firstUserName = namesArray[index];
//            commentItemModel.firstUserId = @"666";
//            if (arc4random_uniform(10) < 5) {
//                commentItemModel.secondUserName = namesArray[arc4random_uniform((int)namesArray.count)];
//                commentItemModel.secondUserId = @"888";
//            }
//            commentItemModel.commentString = commentsArray[arc4random_uniform((int)commentsArray.count)];
//            [tempComments addObject:commentItemModel];
//        }
//        model.commentItemsArray = [tempComments copy];
//        
//        // 模拟随机点赞数据
//        int likeRandom = arc4random_uniform(3);
//        NSMutableArray *tempLikes = [NSMutableArray new];
//        for (int i = 0; i < likeRandom; i++) {
//            ZYTimeLineCellLikeItemModel *model = [ZYTimeLineCellLikeItemModel new];
//            int index = arc4random_uniform((int)namesArray.count);
//            model.userName = namesArray[index];
//            model.userId = namesArray[index];
//            [tempLikes addObject:model];
//        }
//        
//        model.likeItemsArray = [tempLikes copy];
//        
//        
//        
//        [resArr addObject:model];
//    }
//    return [resArr copy];
    
   //  ZYGetObject *zygetObject = [ZYGetObject sharedZYGetObject];
    // NSArray *arr = [zygetObject userDeliverInfoWithClassName:@"userDeliverInfo"];
    
    
    AVQuery *query = [AVQuery queryWithClassName:@"userDeliverInfo"];
    self.avObjectArray = [NSMutableArray array];
    self.avObjectArray = [query findObjects].mutableCopy;
    NSMutableArray *tempArray = [NSMutableArray array];
    
   
    for (AVObject *object in self.avObjectArray) {
        
        ZYTimeLineCellModel *zymodel = [ZYTimeLineCellModel new];
        zymodel.userAlias = object[@"userAlias"];
        zymodel.publishType = object[@"publishType"];
        zymodel.msgContent = object[@"msgContent"];
        zymodel.picNamesArray = object[@"picNamesArray"];
        zymodel.iconName = object[@"iconName"];
        
       
        AVRelation *relation = [object relationforKey:@"likeItems"];
        AVQuery *query = [relation query];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (objects.count > 0) {
                // 临时存放点赞model的数组
                NSMutableArray *likeArray = [NSMutableArray array];
                
                for (AVObject *object in objects) {
                    ZYTimeLineCellLikeItemModel *likeModel = [ZYTimeLineCellLikeItemModel new];
                    likeModel.userName = object[@"userAlias"];
                    [likeArray addObject:likeModel];
                }
                
                zymodel.likeItemsArray = likeArray;
                
            }
        }];
        
        
       
        
        
       
        zymodel.createdAt = object[@"createdAt"];
        
        [tempArray addObject:zymodel];
    }
    
    return tempArray;
}
   */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"++++++++++============%ld",self.dataArray.count);
    if ([kUserDefaultGetValue(kUserInfoKey_hasSign) isEqualToString:@"YES"]) {
         return self.dataArray.count;
    }else {
        return 0;
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeLineTableViewCellId];
    cell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            ZYTimeLineCellModel *model = weakSelf.dataArray[indexPath.row];
            model.isOpening = !model.isOpening;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        
        [cell setDidClickCommentLabelBlock:^(NSString *commentId, CGRect rectInWindow, NSIndexPath *indexPath) {
            weakSelf.textField.placeholder = [NSString stringWithFormat:@"  回复：%@", commentId];
            weakSelf.currentEditingIndexthPath = indexPath;
            [weakSelf.textField becomeFirstResponder];
            weakSelf.isReplayingComment = YES;
            weakSelf.commentToUser = commentId;
            [weakSelf adjustTableViewToFitKeyboardWithRect:rectInWindow];
        }];
        
        cell.delegate = self;
    }
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    cell.model = self.dataArray[indexPath.row];
   // cell.contentAVObject = self.avObjectArray[indexPath.row];
    
    NSLog(@"%@",cell);
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.dataArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ZYTimeLineCell class] contentViewWidth:[self cellContentViewWith]];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
   

    [_textField resignFirstResponder];
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
   
    AVQuery *query = [AVQuery queryWithClassName:@"userDeliverInfo"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        for (AVObject *object in objects) {
            
            ZYTimeLineCellModel *zyModel = [ZYTimeLineCellModel new];
            
            
        }
        
        
        self.avObjectArray = objects.mutableCopy;
        
    
        
        
    }];
    
    
    
    
}


- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}


#pragma mark - ZYTimeLineCellDelegate

- (void)didClickcCommentButtonInCell:(UITableViewCell *)cell
{
    [_textField becomeFirstResponder];
    _currentEditingIndexthPath = [self.tableView indexPathForCell:cell];
    
    [self adjustTableViewToFitKeyboard];
    NSLog(@"我可以评论了");
}

- (void)didClickLikeButtonInCell:(UITableViewCell *)cell
{
    __weak typeof(ZYTimeLineTableViewController *) weakSelf = self;
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    ZYTimeLineCellModel *model = self.dataArray[index.row];
    NSMutableArray *temp = [NSMutableArray arrayWithArray:model.likeItemsArray];
    
    if (!model.isLiked) {
        
        
        ZYTimeLineCellLikeItemModel *likeModel = [ZYTimeLineCellLikeItemModel new];
        likeModel.userName = kUserDefaultGetValue(kUserInfoKey_userAlias);
        // likeModel.userId = @"gsdios";
        [temp addObject:likeModel];
        model.liked = YES;
        
        
        
        // 新建一个 AVRelation
        AVQuery *query = [AVQuery queryWithClassName:@"userInfo"];
        [query whereKey:@"telNum" equalTo:kUserDefaultGetValue(kUserInfoKey_telNum)];
       
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if(!error && objects.count > 0) {
            AVObject *deliverObject = weakSelf.avObjectArray[index.row];
            
            AVRelation *relation = [deliverObject relationforKey:@"likeItems"];
            [relation addObject:[objects firstObject]];
            [deliverObject saveInBackground];
        
            }else {
                NSLog(@"++++++%@",kUserDefaultGetValue(kUserInfoKey_telNum));
                NSLog(@"没有获取到点赞人的对象");
            }
        }];
        
       

        
        
        
    } else {
        
       ZYTimeLineCellLikeItemModel *tempLikeModel = nil;
        for (ZYTimeLineCellLikeItemModel *likeModel in model.likeItemsArray) {
           if ([likeModel.userName isEqualToString:kUserDefaultGetValue(kUserInfoKey_userAlias)]) {
                tempLikeModel = likeModel;
                break;
            }
        }
        [temp removeObject:tempLikeModel];
        
        
        
        
       model.liked = NO;
    }
    model.likeItemsArray = [temp copy];
    
    [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
}


- (void)adjustTableViewToFitKeyboard
{
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:_currentEditingIndexthPath];
            CGRect rect = [cell.superview convertRect:cell.frame toView:window];
            [self adjustTableViewToFitKeyboardWithRect:rect];
}
         


- (void)adjustTableViewToFitKeyboardWithRect:(CGRect)rect
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGFloat delta = CGRectGetMaxY(rect) - (window.bounds.size.height - _totalKeybordHeight);
    
    CGPoint offset = self.tableView.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    
    [self.tableView setContentOffset:offset animated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    if (textField.text.length) {
        [_textField resignFirstResponder];
        
        ZYTimeLineCellModel *model = self.dataArray[_currentEditingIndexthPath.row];
        NSMutableArray *temp = [NSMutableArray new];
        [temp addObjectsFromArray:model.commentItemsArray];
        ZYTimeLineCellCommentItemModel *commentItemModel = [ZYTimeLineCellCommentItemModel new];
        
        
        
        AVObject * deliverObject = self.avObjectArray[_currentEditingIndexthPath.row];
        NSLog(@"sdfsdsdf:%@",deliverObject.objectId);
        
          commentItemModel.commentString = textField.text;
        NSLog(@"评论：：：%@",commentItemModel.commentString);
            deliverObject[@"commentItemsArray"] = [NSArray arrayWithObjects:commentItemModel.commentString, nil];
            
            
             [deliverObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                 NSLog(@"%d,%@",succeeded,error);
             }];
            
     
        
        
        
        if (self.isReplayingComment) {
            commentItemModel.firstUserName = kUserDefaultGetValue(kUserInfoKey_userAlias);
//            commentItemModel.firstUserId = @"GSD_iOS";
            commentItemModel.secondUserName = self.commentToUser;
//            commentItemModel.secondUserId = self.commentToUser;
            commentItemModel.commentString = textField.text;
            
            self.isReplayingComment = NO;
        } else {
            commentItemModel.firstUserName = kUserDefaultGetValue(kUserInfoKey_userAlias);
            commentItemModel.commentString = textField.text;
//            commentItemModel.firstUserId = @"GSD_iOS";
        }
        [temp addObject:commentItemModel];
        model.commentItemsArray = [temp copy];
        [self.tableView reloadRowsAtIndexPaths:@[_currentEditingIndexthPath] withRowAnimation:UITableViewRowAnimationNone];
        
       
   
         _textField.text = @"";
        
        return YES;
    }
    
    
    
    return NO;
}



- (void)keyboardNotification:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    
    
    CGRect textFieldRect = CGRectMake(0, rect.origin.y - textFieldH, rect.size.width, textFieldH);
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
        textFieldRect = rect;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _textField.frame = textFieldRect;
    }];
    
    CGFloat h = rect.size.height + textFieldH;
    if (_totalKeybordHeight != h) {
        _totalKeybordHeight = h;
        [self adjustTableViewToFitKeyboard];
    }
    
    NSLog(@"我们");
}



- (UIImageView *)createHomeButtonView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 40.f, 40.f)];
    imageView.image = [UIImage imageNamed:@"buddy_buddy"];
    imageView.layer.cornerRadius = imageView.frame.size.height / 2.f;
    imageView.backgroundColor =[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
    imageView.clipsToBounds = YES;
    
    return imageView;
}

- (NSArray *)createDemoButtonArray {
    NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];
    
    int i = 0;
    for (NSString *title in @[@"A", @"B", @"C", @"D", @"E", @"F"]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        
        
        button.frame = CGRectMake(0.f, 0.f, 30.f, 30.f);
        button.layer.cornerRadius = button.frame.size.height / 2.f;
        button.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
        button.clipsToBounds = YES;
        button.tag = i++;
        
        [button addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonsMutable addObject:button];
    }
    
    return [buttonsMutable copy];
}

- (void)test:(UIButton *)sender {
    NSLog(@"Button tapped, tag: %ld", (long)sender.tag);
}

- (UIButton *)createButtonWithName:(NSString *)imageName {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button sizeToFit];
    
    [button addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


@end
