# NKDocumentPickerViewController

## <a id="如何使用ObjectFromJSON"></a>一行代码实现从手机上传文件到APP
# 上线APP：
<img src="https://upload-images.jianshu.io/upload_images/1721864-0feb4befb2dddb9f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" style="height: 45px;width: 50px;">
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
