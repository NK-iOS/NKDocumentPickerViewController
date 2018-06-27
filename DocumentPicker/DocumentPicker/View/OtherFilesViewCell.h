//
//  OtherFilesViewCell.h
//  DocumentPicker
//
//  Created by 聂宽 on 2018/6/27.
//  Copyright © 2018年 聂宽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NKOtherFilesModel.h"

@interface OtherFilesViewCell : UICollectionViewCell
@property (nonatomic, strong) NKOtherFilesModel *model;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLab;

@end
