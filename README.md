# NKDocumentPickerViewController

## <a id="如何使用ObjectFromJSON"></a>一行代码实现从手机上传文件到APP
      Guideline 2.5.15 - Performance - Software Requirements
      由于最近项目审核遇到的一些问题，一直不理解苹果爸爸到底是让我怎么修改，，，最后才明白苹果的新规，遇到类似问题的可以参考。
      利用UIDocumentPickerViewController从手机上传文件到app！有时候会有这么一些需求,需要用户上传自己的一些xml,doc,pdf文档.可是iOS上并没有直观的文件管理系统.这时候Document Picker就可以帮助我们访问iCould,dropBox等应用中的文件.然后进行相关操作.
# 上线APP：
<img src="https://upload-images.jianshu.io/upload_images/1721864-0feb4befb2dddb9f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="60px" height="60px">
<a href="https://itunes.apple.com/cn/app/我的超级文件/id1397704011?mt=8">我的超级文件</a>

# 方法调用：
```objc
[[NKSeleDocumentTool shareDocumentTool] seleDocumentWithDocumentTypes:@[@"public.data"] Mode:UIDocumentPickerModeImport controller:self finishBlock:^(NSArray<NSURL *> *urls) {
      NSURL *fileUrl = urls.firstObject;
      // 选择的文件数据
      NSData *fileData = [NSData dataWithContentsOfURL:fileUrl];
}];
```
# 效果预览：
一行代码实现文件选择，简洁方便
