//
//  PictureController.m
//  DuBi
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "PictureController.h"
#import "PictureHandle.h"
#define kPictureHandle [PictureHandle sharedPictureHandle]
#import "LWNMainPageUrl.h"
#import "PictureViewCell.h"
@interface PictureController ()

@end

@implementation PictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"PictureViewCell" bundle:nil] forCellReuseIdentifier:@"pictureCellID"];

    // 数据请求
    [self reuqestData];
       // 取消样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
-(void)reuqestData{
  // 加载菊花样式
    [kPictureHandle getDataWithString:[NSString stringWithFormat:kPictureUrl,@""] comptionBlock:^(NSMutableArray *array) {
        // 刷新数据
        [self reloadData];
    }];
  }
-(void)reloadData{
    [self.tableView reloadData];
    // 隐藏菊花样式
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return [kPictureHandle numberOfSections];


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
  //  NSLog(@"%ld",[kPictureHandle numofRowsAtSection:section]);
    return [kPictureHandle numofRowsAtSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PictureViewCell *cell = (PictureViewCell *)[tableView dequeueReusableCellWithIdentifier:@"pictureCellID"forIndexPath:indexPath];
    cell.picture = [kPictureHandle pictureForCellAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Picture *picture = [kPictureHandle pictureForCellAtIndexPath:indexPath];
    return [PictureViewCell heightFor:picture];
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
