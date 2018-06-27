//
//  NKSeleDocumentTool.m
//  Personal
//
//  Created by 聂宽 on 2018/6/21.
//  Copyright © 2018年 聂宽. All rights reserved.
//

#import "NKSeleDocumentTool.h"

@interface NKSeleDocumentTool()<UIDocumentPickerDelegate>
@property (nonatomic, copy) SeleDocumentFinish seleFinish;
@property (nonatomic, strong) UIViewController *vc;
@end

@implementation NKSeleDocumentTool
+ (NKSeleDocumentTool *)shareDocumentTool
{
    static NKSeleDocumentTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NKSeleDocumentTool alloc] init];
    });
    return instance;
}

- (void)seleDocumentWithDocumentTypes:(NSArray<NSString *> *)allowedUTIs Mode:(UIDocumentPickerMode)mode controller:(UIViewController *)vc finishBlock:(SeleDocumentFinish)seleFinish
{
    // @[@"public.3gpp"]
    UIDocumentPickerViewController *picker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:allowedUTIs inMode:mode];
    picker.delegate = self;
    _vc = vc;
    _seleFinish = seleFinish;
    [vc presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIDocumentPickerDelegate
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray <NSURL *>*)urls
{
    if (self.seleFinish) {
        self.seleFinish(urls);
    }
    [controller dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
