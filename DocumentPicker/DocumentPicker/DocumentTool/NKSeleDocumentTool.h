//
//  NKSeleDocumentTool.h
//  Personal
//
//  Created by 聂宽 on 2018/6/21.
//  Copyright © 2018年 聂宽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void(^SeleDocumentFinish)(NSArray<NSURL *> *urls);

@interface NKSeleDocumentTool : NSObject
+ (NKSeleDocumentTool *)shareDocumentTool;

- (void)seleDocumentWithDocumentTypes:(NSArray <NSString *>*)allowedUTIs Mode:(UIDocumentPickerMode)mode controller:(UIViewController *)vc finishBlock:(SeleDocumentFinish)seleFinish;
/*
 Thanks for your review!
 2.5.15： The "从“文件”上传" is select items from the Files app and the user's iCloud documents.
 I ask apple's technical support for the solution.
 */
@end
