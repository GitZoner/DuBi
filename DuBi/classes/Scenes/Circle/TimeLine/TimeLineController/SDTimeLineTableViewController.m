//
//  SDTimeLineTableViewController.m
//  GSD_WeiXin(wechat)
//
//  Created by gsd on 16/2/25.
//  Copyright © 2016年 GSD. All rights reserved.
//

/*
 
 *********************************************************************************
 *
 * GSD_WeiXin
 *
 * QQ交流群: 362419100(2群) 459274049（1群已满）
 * Email : gsdios@126.com
 * GitHub: https://github.com/gsdios/GSD_WeiXin
 * 新浪微博:GSD_iOS
 *
 * 此“高仿微信”用到了很高效方便的自动布局库SDAutoLayout（一行代码搞定自动布局）
 * SDAutoLayout地址：https://github.com/gsdios/SDAutoLayout
 * SDAutoLayout视频教程：http://www.letv.com/ptv/vplay/24038772.html
 * SDAutoLayout用法示例：https://github.com/gsdios/SDAutoLayout/blob/master/README.md
 *
 *********************************************************************************
 
 */

#import "SDTimeLineTableViewController.h"

#import "SDRefresh.h"

#import "SDTimeLineTableHeaderView.h"
#import "SDTimeLineRefreshHeader.h"
#import "SDTimeLineRefreshFooter.h"
#import "SDTimeLineCell.h"

#import "SDTimeLineCellModel.h"

#import "UITableView+SDAutoTableViewCellHeight.h"

#import "UIView+SDAutoLayout.h"

#define kTimeLineTableViewCellId @"SDTimeLineCell"
#import <AVOSCloud/AVOSCloud.h>
#import "Main_marco.h"


static CGFloat textFieldH = 40;

@interface SDTimeLineTableViewController () <SDTimeLineCellDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) BOOL isReplayingComment;
@property (nonatomic, strong) NSIndexPath *currentEditingIndexthPath;
@property (nonatomic, copy) NSString *commentToUser;

@property (strong,nonatomic)NSArray *avObjectArray;

@end

@implementation SDTimeLineTableViewController

{
    SDTimeLineRefreshFooter *_refreshFooter;
    SDTimeLineRefreshHeader *_refreshHeader;
    CGFloat _lastScrollViewOffsetY;
    CGFloat _totalKeybordHeight;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!_refreshHeader.superview) {
        
        _refreshHeader = [SDTimeLineRefreshHeader refreshHeaderWithCenter:CGPointMake(40, 45)];
        _refreshHeader.scrollView = self.tableView;
        __weak typeof(_refreshHeader) weakHeader = _refreshHeader;
        __weak typeof(self) weakSelf = self;
        [_refreshHeader setRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.dataArray = [[weakSelf creatModelsWithCount:10] mutableCopy];
                [weakHeader endRefreshing];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                });
            });
        }];
        [self.tableView.superview addSubview:_refreshHeader];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    [self.dataArray addObjectsFromArray:[self creatModelsWithCount:10]];
    
   // __weak typeof(self) weakSelf = self;
    
    
    // 上拉加载
    /*
    _refreshFooter = [SDTimeLineRefreshFooter refreshFooterWithRefreshingText:@"正在加载数据..."];
    __weak typeof(_refreshFooter) weakRefreshFooter = _refreshFooter;
    [_refreshFooter addToScrollView:self.tableView refreshOpration:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.dataArray addObjectsFromArray:[weakSelf creatModelsWithCount:10]];
            [weakSelf.tableView reloadData];
            [weakRefreshFooter endRefreshing];
        });
    }];
     */
    
    SDTimeLineTableHeaderView *headerView = [SDTimeLineTableHeaderView new];
    headerView.frame = CGRectMake(0, 0, 0, 260);
    self.tableView.tableHeaderView = headerView;
    
    [self.tableView registerClass:[SDTimeLineCell class] forCellReuseIdentifier:kTimeLineTableViewCellId];
    
    [self setupTextField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
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


-(void)setAvObjectArray:(NSArray *)avObjectArray {
    if (_avObjectArray != avObjectArray) {
        _avObjectArray = nil;
        _avObjectArray = avObjectArray;
    }
}



- (NSArray *)creatModelsWithCount:(NSInteger)count
{
    NSMutableArray *cellModelArray = [NSMutableArray array];
    
    
    AVQuery *query = [AVQuery queryWithClassName:@"userDeliverInfo"];
    self.avObjectArray = [query findObjects];
    
    // 从好友动态表中获取动态对象，解析每一个动态对象，赋值给相应的model
    for (AVObject *deliverObject in self.avObjectArray) {
        SDTimeLineCellModel *cellModel = [SDTimeLineCellModel new];
        cellModel.iconName = deliverObject[@"iconName"];
        cellModel.name = deliverObject[@"userAlias"];
        cellModel.msgContent = deliverObject[@"msgContent"];
        cellModel.picNamesArray = deliverObject[@"picNamesArray"];
        
        // 查询表中点赞
        AVRelation *likerRelation = [deliverObject relationforKey:@"liker"];
        AVQuery *likerQuery = [likerRelation query];
        NSArray *likerArray = [likerQuery findObjects];
        NSMutableArray *likerModelArray =[NSMutableArray array];
        for (AVObject *likerObject in likerArray ) {
            SDTimeLineCellLikeItemModel *likeModel = [SDTimeLineCellLikeItemModel new];
            likeModel.userName = likerObject[kLikeModelListKey_likerName];
            likeModel.userId = likerObject[kLikeModelListKey_likerID];
            if ([likeModel.userId isEqualToString:kUserDefaultGetValue(kUserInfoKey_telNum)]) {
               
            }
            [likerModelArray addObject:likeModel];
        }
        cellModel.likeItemsArray = likerModelArray;
        
        // 查询表中评论
        AVRelation *commentRelation = [deliverObject relationforKey:@"commentArray"];
        AVQuery *commentQuery = [commentRelation query];
        NSArray *commentArray = [commentQuery findObjects];
        NSMutableArray *commentModelArray = [NSMutableArray array];
        for (AVObject *commentObject in commentArray) {
             SDTimeLineCellCommentItemModel *commentModel = [SDTimeLineCellCommentItemModel new];
            commentModel.firstUserId = commentObject[kCommentModelListKey_firstID];
            commentModel.firstUserName = commentObject[kCommentModelListKey_firstName];
            commentModel.secondUserId = commentObject[kCommentModelListKey_secondID];
            commentModel.secondUserName =commentObject[kCommentModelListKey_secondName];
            [commentModelArray addObject:commentModel];
        }
        cellModel.commentItemsArray = commentModelArray;
        
        [cellModelArray addObject:cellModel];
    }
    
    return [cellModelArray copy];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeLineTableViewCellId];
    cell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            SDTimeLineCellModel *model = weakSelf.dataArray[indexPath.row];
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.dataArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[SDTimeLineCell class] contentViewWidth:[self cellContentViewWith]];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_textField resignFirstResponder];
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


#pragma mark - SDTimeLineCellDelegate

- (void)didClickcCommentButtonInCell:(UITableViewCell *)cell
{
    [_textField becomeFirstResponder];
    _currentEditingIndexthPath = [self.tableView indexPathForCell:cell];
    
    [self adjustTableViewToFitKeyboard];
    
}

- (void)didClickLikeButtonInCell:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    SDTimeLineCellModel *model = self.dataArray[index.row];
    NSMutableArray *temp = [NSMutableArray arrayWithArray:model.likeItemsArray];
    
    BOOL isLiked = NO;
    for (SDTimeLineCellLikeItemModel *likeModel in temp) {
        if ([likeModel.userId isEqualToString:kUserDefaultGetValue(kUserInfoKey_telNum)]) {
            isLiked = YES;
        }
    }
    
    
    
    if (!model.isLiked && isLiked == NO) {
        SDTimeLineCellLikeItemModel *likeModel = [SDTimeLineCellLikeItemModel new];
        likeModel.userName = kUserDefaultGetValue(kUserInfoKey_userAlias);
        likeModel.userId = kUserDefaultGetValue(kUserInfoKey_telNum);
        [temp addObject:likeModel];
        model.liked = YES;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            AVObject *likeObject = [[AVObject alloc] initWithClassName:@"likeModel"];
            [likeObject setObject:likeModel.userName forKey:kLikeModelListKey_likerName];
            [likeObject setObject:likeModel.userId forKey:kLikeModelListKey_likerID];
            [likeObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                AVObject * deliverObject = self.avObjectArray[index.row];
                AVRelation *likerRelation = [deliverObject relationforKey:@"liker"];
            
                [likerRelation addObject:likeObject];
                [deliverObject saveInBackground];
            }];
        });
        
        
        
    } else {
        SDTimeLineCellLikeItemModel *tempLikeModel = nil;
        for (SDTimeLineCellLikeItemModel *likeModel in model.likeItemsArray) {
            if ([likeModel.userId isEqualToString:kUserDefaultGetValue(kUserInfoKey_telNum)]) {
                tempLikeModel = likeModel;
                break;
            }
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         
           
                AVObject * deliverObject = self.avObjectArray[index.row];
                AVRelation *likerRelation = [deliverObject relationforKey:@"liker"];
                AVQuery *likerQuery = [likerRelation query];
                NSArray *likerArray = [likerQuery findObjects];
            for (AVObject *likeObject in likerArray) {
                if ([likeObject[kLikeModelListKey_likerID] isEqualToString:kUserDefaultGetValue(kUserInfoKey_telNum)]) {
                    [likerRelation removeObject:likeObject];
                    [deliverObject saveInBackground];
                    break;
                }
            }
            
           
        });
        
        
        
        
        
        [temp removeObject:tempLikeModel];
        model.liked = NO;
    }
    model.likeItemsArray = [temp copy];
    
    [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)savelikerData:(SDTimeLineCellLikeItemModel *)likeModel toDeliverObject:(AVObject *)object {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        
    });
    
    
}
- (void)adjustTableViewToFitKeyboard
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:_currentEditingIndexthPath];
    CGRect rect = [cell.superview.superview.superview convertRect:cell.frame toView:window];
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
        
        SDTimeLineCellModel *model = self.dataArray[_currentEditingIndexthPath.row];
        NSMutableArray *temp = [NSMutableArray new];
        [temp addObjectsFromArray:model.commentItemsArray];
        SDTimeLineCellCommentItemModel *commentItemModel = [SDTimeLineCellCommentItemModel new];
        
        if (self.isReplayingComment) {
            commentItemModel.firstUserName = @"GSD_iOS";
            commentItemModel.firstUserId = @"GSD_iOS";
            commentItemModel.secondUserName = self.commentToUser;
            commentItemModel.secondUserId = self.commentToUser;
            commentItemModel.commentString = textField.text;
            
            self.isReplayingComment = NO;
        } else {
            commentItemModel.firstUserName = @"GSD_iOS";
            commentItemModel.commentString = textField.text;
            commentItemModel.firstUserId = @"GSD_iOS";
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
}

@end
