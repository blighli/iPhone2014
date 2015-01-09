//
//  PhotoPickerViewController.m
//  PictureFilter
//
//  Created by 陈晟豪 on 14/12/19.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoPickerViewController.h"
#import "PhotoCell.h"
#import "DetailPhotoViewController.h"

@interface PhotoPickerViewController ()
{
    NSIndexPath *lastChosenCell;
    UIImageView *selectedImageView;
    UIImage *selectedImage;
}
@property (weak, nonatomic) IBOutlet UINavigationBar *photoPickerNavigationBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (retain, nonatomic) IBOutlet UINavigationItem *photoPickerNavigationItem;
@property (weak, nonatomic) IBOutlet UIButton *photoPickerPreviewButton;
@property(nonatomic, strong) NSArray *assets;

- (IBAction)clickPreviewButton:(id)sender;

@end

@implementation PhotoPickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建一个导航栏集合
    self.photoPickerNavigationItem = [[UINavigationItem alloc] initWithTitle:@"相册"];
    
    //创建一个左边按钮
    self.photoPickerNavigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil
                                                                                        style:UIBarButtonItemStyleDone
                                                                                       target:self
                                                                                       action:@selector(clickCancelButton:)];
    
    [self.photoPickerNavigationItem.leftBarButtonItem setImage:[UIImage imageNamed:@"BackButton"]];
    
    //创建右边按钮
    self.photoPickerNavigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                                      target:self
                                                                                                      action:@selector(clickPreviewButton:)];
    //右边按钮不可用
    [self.photoPickerNavigationItem.rightBarButtonItem setEnabled:false];
    
    [self.photoPickerNavigationBar pushNavigationItem:self.photoPickerNavigationItem animated:NO];
    
    //底部完成按钮不可用
    [self.photoPickerPreviewButton setEnabled:false];
    
    _assets = [@[] mutableCopy];
    __block NSMutableArray *tmpAssets = [@[] mutableCopy];
    // 1
    ALAssetsLibrary *assetsLibrary = [PhotoPickerViewController defaultAssetsLibrary];
    // 2
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if(result)
            {
                // 3
                [tmpAssets addObject:result];
            }
        }];
        
        // 4
        //NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
        //self.assets = [tmpAssets sortedArrayUsingDescriptors:@[sort]];
        self.assets = tmpAssets;
        
        // 5
        [self.collectionView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"Error loading images %@", error);
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    //修改状态栏文字颜色
    return UIStatusBarStyleLightContent;
}

- (IBAction)clickCancelButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickDoneButton:(id)sender
{
    //通过delegate调用代理方法
    [self.delegate setPhoto:selectedImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickPreviewButton:(id)sender
{
    DetailPhotoViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailPhoto"];
    detail.image = selectedImage;
    [self presentViewController:detail animated:YES completion:NULL];
}

#pragma mark - assets

+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}

#pragma mark - collection view data source

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //定义展示的UICollectionViewCell的个数
    return self.assets.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //每个单元显示照片
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    ALAsset *asset = self.assets[indexPath.row];
    cell.asset = asset;
    
    return cell;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    //每一行的最小间距
    return 5;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    //每个cell的最小间隔
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //定义每个cell的大小
    //判断不同设备分辨率
    if([[UIScreen mainScreen] bounds].size.width == 375)
    {
        //4.7寸屏
        return CGSizeMake(118, 118);
    }
    else if([[UIScreen mainScreen] bounds].size.width == 414)
    {
        //5.5寸屏
        return CGSizeMake(130, 130);
    }
    return CGSizeMake(100, 100);
}

#pragma mark - collection view delegate

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //每个cell被选中时调用的方法
    ALAsset *asset = self.assets[indexPath.row];
    ALAssetRepresentation *defaultRep = [asset defaultRepresentation];
    selectedImage = [UIImage imageWithCGImage:[defaultRep fullScreenImage] scale:[defaultRep scale] orientation:0];
    
    //获取被点击的Cell
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    //为该Cell加上选中图像
    [self setSelectedImage:cell AtIndexPath:indexPath];
}

- (void)setSelectedImage:(UICollectionViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    //只初始化一次
    if(selectedImageView == nil)
    {
        selectedImageView = [[UIImageView alloc] initWithFrame:cell.bounds];
        selectedImageView.image = [UIImage imageNamed:@"CellSelectedImage"];
        
        lastChosenCell = nil;
    }
    
    if(selectedImageView.superview == nil)
    {
        [cell addSubview:selectedImageView];
        
        lastChosenCell = indexPath;
        
        //NavigationBar右边按钮可用
        [self.photoPickerNavigationItem.rightBarButtonItem setEnabled:true];
        
        //底部完成按钮可用
        [self.photoPickerPreviewButton setEnabled:true];
        [self.photoPickerPreviewButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
    else
    {
        if(indexPath == lastChosenCell)
        {
            [selectedImageView removeFromSuperview];
            lastChosenCell = nil;
            
            //NavigationBar右边按钮不可用
            [self.photoPickerNavigationItem.rightBarButtonItem setEnabled:false];
            
            //底部完成按钮不可用
            [self.photoPickerPreviewButton setEnabled:false];
            [self.photoPickerPreviewButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            
        }
        else
        {
            [selectedImageView removeFromSuperview];
            [cell addSubview:selectedImageView];
            lastChosenCell = indexPath;
            
            //NavigationBar右边按钮可用
            [self.photoPickerNavigationItem.rightBarButtonItem setEnabled:true];
            
            //底部完成按钮可用
            [self.photoPickerPreviewButton setEnabled:true];
            [self.photoPickerPreviewButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            
        }
    }
}

@end

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


