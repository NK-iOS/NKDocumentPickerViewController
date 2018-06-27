//
//  ViewController.m
//  DocumentPicker
//
//  Created by 聂宽 on 2018/6/27.
//  Copyright © 2018年 聂宽. All rights reserved.
//

#import "ViewController.h"
#import "NKSeleDocumentTool.h"
#import "OtherFilesViewCell.h"
#import <QuickLook/QuickLook.h>
#import "UIActionSheet+Blocks.h"

#define screenW [[UIScreen mainScreen] bounds].size.width
#define screenH [[UIScreen mainScreen] bounds].size.height

#define NKColorWithRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, QLPreviewControllerDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NKOtherFilesModel *seleFileM;

@end
// cell
static NSString *OtherFilesViewCellID = @"OtherFilesViewCell";

@implementation ViewController

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
        
        NSString *documentPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"OtherFiles"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *files = [fileManager contentsOfDirectoryAtPath:documentPath error:nil];
        for (NSString *fileName in files) {
            NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
            NKOtherFilesModel *model = [[NKOtherFilesModel alloc] init];
            model.fileName = fileName;
            model.filePath = filePath;
            [_dataArr addObject:model];
        }
    }
    return _dataArr;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 44) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[OtherFilesViewCell class] forCellWithReuseIdentifier:OtherFilesViewCellID];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择文件";
    self.view.backgroundColor = NKColorWithRGB(0xEFEFF4);
    self.collectionView.backgroundColor = self.view.backgroundColor;
    
    [self settingBottomView];
}

- (void)settingBottomView
{
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.borderWidth = 1;
    bottomView.layer.borderColor = NKColorWithRGB(0xEFEFF4).CGColor;
    [self.view addSubview:bottomView];
    bottomView.frame = CGRectMake(0, self.view.frame.size.height - 44, screenW, 44);
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [addBtn setTitleColor:NKColorWithRGB(0x323232) forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"add_new"] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    addBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:addBtn];
    addBtn.frame = CGRectMake(0, 0, screenW, 44);
}

- (void)addBtnAction
{
    [UIActionSheet showInView:self.view
                    withTitle:@"打开文件"
            cancelButtonTitle:@"取消"
       destructiveButtonTitle:nil
            otherButtonTitles:@[@"从“文件”上传"]
                     tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
                         if (buttonIndex == 0) {
                             [[NKSeleDocumentTool shareDocumentTool] seleDocumentWithDocumentTypes:@[@"public.data"] Mode:UIDocumentPickerModeImport controller:self finishBlock:^(NSArray<NSURL *> *urls) {
                                 NSURL *fileUrl = urls.firstObject;
                                 NSData *fileData = [NSData dataWithContentsOfURL:fileUrl];
                                 NSString *fileName = [[[fileUrl absoluteString] componentsSeparatedByString:@"/"] lastObject];
                                 NSString *documentPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"OtherFiles"];
                                 NSString *newFilePath = [documentPath stringByAppendingPathComponent:fileName];
                                 NSFileManager *fileManager = [NSFileManager defaultManager];
                                 
                                 // 判断movie文件是否存在，如果不存在，就创建一个
                                 if (![fileManager fileExistsAtPath:documentPath]) {
                                     [fileManager createDirectoryAtPath:documentPath withIntermediateDirectories:YES attributes:nil error:nil];
                                 }
                                 if ([fileManager createFileAtPath:newFilePath contents:fileData attributes:nil]) {
                                     _dataArr = nil;
                                     [self.collectionView reloadData];
                                 }else
                                 {
                                     // 失败
                                     NSLog(@"保存失败！");
                                 }
                             }];
                         }
                     }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OtherFilesViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OtherFilesViewCellID forIndexPath:indexPath];
    NKOtherFilesModel *model = self.dataArr[indexPath.item];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NKOtherFilesModel *model = self.dataArr[indexPath.item];
    _seleFileM = model;
    [self QLPreviewingControllerLoad];
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemW = (screenW - (1 + 3)*5 ) /3 ;
    return CGSizeMake(itemW, itemW + 10);
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (void)QLPreviewingControllerLoad
{
    QLPreviewController *QLVC = [[QLPreviewController alloc] init];
    QLVC.dataSource = self;
    [self presentViewController:QLVC animated:YES completion:^{
        
    }];
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:self.seleFileM.filePath];
    return documentsDirectoryURL;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *documentPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"OtherFiles"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 判断Image文件是否存在，如果不存在，就创建一个
    if (![fileManager fileExistsAtPath:documentPath]) {
        [fileManager createDirectoryAtPath:documentPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    _dataArr = nil;
    [self.collectionView reloadData];
}
@end

