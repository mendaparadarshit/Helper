# Helper
This will help you to convert date time format,file manger,alert controller,actionsheet controller, distance between two latitude and longitude ,Url validation


File
-----------

```
+(NSString *)getFilename;
+(NSURL *)getfilepathURLFromFilename:(NSString *)filename;
+(void)removeFileFromPath :(NSURL *)url;
```

Datetime
-----------

```
+(NSString *)getCalculatedTimeFromTimer :(NSTimeInterval)currentTime;
+(NSString *)setAPPDateFormat :(NSString *)str;
+(NSString *)setAPPTimeFormat :(NSString *)str;
```


Alert
-----------

```
+(void)alertWithTitle:(NSString *)title andMessage:(NSString *)message;
+(void)alertActionsWithTitle:(NSString *)title andMessage:(NSString *)message Settings:(void (^)(void))Settings;
+(void)alertQuestionWithTitle:(NSString *)title andMessage:(NSString *)message nodo:(void (^)(void))nodo;
+(void)alertQuestionWithTitle:(NSString *)title andMessage:(NSString *)message yesdo:(void (^)(void))yesdo;
+(void)actionSheetControllerWithRefButton:(UIButton *)sender controller:(UIViewController *)controller Titles:(NSArray *)titles Checkmarks:(NSArray *)checkmarks withCancel:(NSString *)cancel actionBlock:(void (^)(NSInteger index))actionBlock cancelBlock:(void (^)(void))cancelBlock;
```


Others
-----------

```
+(NSString *)calculateLocationLat1:(CGFloat)lat1 Long1:(CGFloat)long1 Lat2:(CGFloat)lat2 Long2:(CGFloat)long2;
+(BOOL) validateUrl: (NSString *) candidate ;
```
