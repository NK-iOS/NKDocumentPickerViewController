//
//  OtherFilesViewCell.m
//  DocumentPicker
//
//  Created by 聂宽 on 2018/6/27.
//  Copyright © 2018年 聂宽. All rights reserved.
//

#import "OtherFilesViewCell.h"

@implementation OtherFilesViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        _imgView.image = [UIImage imageNamed:@"image_placeholder"];
        _imgView.clipsToBounds = YES;
        [self addSubview:_imgView];
        _imgView.frame = CGRectMake(0, 2, self.frame.size.width, self.frame.size.height - 42);
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.numberOfLines = 2;
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.textColor = [UIColor lightGrayColor];
        [self addSubview:_titleLab];
        _titleLab.frame = CGRectMake(5, CGRectGetMaxY(_imgView.frame) + 3, self.frame.size.width - 10, self.frame.size.height - (CGRectGetMaxY(_imgView.frame) + 3));
    }
    return self;
}

- (void)setModel:(NKOtherFilesModel *)model
{
    _model = model;
    _titleLab.text = model.fileName;
}
@end
