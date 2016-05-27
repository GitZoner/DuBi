//
//  JTCircleViewController.m
//  DuBi
//
//  Created by Jason on 16/5/25.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "JTCircleViewController.h"
#import "JTCircleCell.h"
#import "DWBubbleMenuButton.h"
@interface JTCircleViewController ()
@property (strong,nonatomic)UIImageView *headerImageView;
@end
static NSString *const circleCellReuseIdentifier  = @"CircleCellID";
@implementation JTCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[JTCircleCell class] forCellReuseIdentifier:circleCellReuseIdentifier];
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width / 6 * 4)];
    self.headerImageView.backgroundColor = [UIColor orangeColor];
    self.tableView.tableHeaderView = self.headerImageView;
    
    // 添加悬浮button
    [self addExpandButton];
   
    
}

-(void)addExpandButton {
    
    // 添加悬浮button
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    image.layer.cornerRadius = 20;
    image.layer.masksToBounds = YES;
    image.image = [UIImage imageNamed:@"buddy_buddy"];
    DWBubbleMenuButton *expandButton = [[DWBubbleMenuButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    expandButton.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 30, [UIScreen mainScreen].bounds.size.height - 59);
    expandButton.homeButtonView = image;
    [[UIApplication sharedApplication].keyWindow addSubview:expandButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JTCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:circleCellReuseIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 500;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
