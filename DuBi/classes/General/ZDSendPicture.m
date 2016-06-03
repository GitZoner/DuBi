//
//  ZDSendPicture.m
//  DuBi
//
//  Created by lanou3g on 16/6/3.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDSendPicture.h"

#import "Color_marco.h"
#import "UIView+XYWidthHeight.h"

@interface ZDSendPicture ()

@property(strong,nonatomic)NSMutableArray * selectPhotosArray;

@property(strong,nonatomic)NSMutableArray * evaluationPhotosArray;

@property(strong,nonatomic)NSMutableArray * showPhotosArray;

@property(strong,nonatomic)NSMutableArray * camaraPhotoArray;

// collectionView
@property(strong,nonatomic)UICollectionView * collectionView;

// textView
@property(strong,nonatomic)UITextView * contentTextField;


@end

@implementation ZDSendPicture
- (NSMutableArray *)camaraPhotoArray{
    if (_camaraPhotoArray == nil) {
        _camaraPhotoArray = [NSMutableArray new];
    }
    return _camaraPhotoArray;
}


- (NSMutableArray *)selectPhotosArray{
    if (_selectPhotosArray == nil) {
        _selectPhotosArray = [NSMutableArray new];
    }
    return _selectPhotosArray;
}

- (NSMutableArray *)evaluationPhotosArray{
    if (_evaluationPhotosArray == nil) {
        _evaluationPhotosArray = [NSMutableArray new];
    }
    return _evaluationPhotosArray;
}


- (NSMutableArray *)showPhotosArray{
    if (_showPhotosArray == nil) {
        _showPhotosArray = [NSMutableArray new];
    }
    return _showPhotosArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // LocalPhotoViewController * loca = [LocalPhotoViewController new];
    // loca.selectPhotoDelegate = self;
    
    // 设置collectionView
    [self setControllectionView];
    
    self.contentTextField = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 150)];
    self.contentTextField.backgroundColor = tGrayColor;
    [self.view addSubview: self.contentTextField];
}

-(void)setControllectionView{
    self.view.backgroundColor = tGrayColor;
    UICollectionViewFlowLayout * flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.itemSize = CGSizeMake((self.view.width / 4 * 3) / 3,( self.view.width / 4 * 3) / 3);
    // 设置最小行间距
    flowLayout.minimumLineSpacing = 5;
    // 设置最小列间距
    flowLayout.minimumInteritemSpacing = self.view.width / 4 / 4;
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionView"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
}

-(void)getSelectedPhoto:(NSMutableArray *)photos
{
    self.selectPhotosArray = photos;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.selectPhotosArray.count;
}

// cell设置
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionView" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

// 增补视图 头尾视图

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    header.height = 200;
    header.width = self.view.width;
    
    
    return header;
}















@end
