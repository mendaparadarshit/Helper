//
//  Helpers.h
//
//  Created by Darshit on 30/03/2017.
//  Copyright © 2016 Darshit. All rights reserved.
//

#import "Helpers.h"
#import <CoreLocation/CoreLocation.h>

@implementation Helpers

#pragma mark -  File

+(NSString *)getFilename
{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd-HHmmss"];
    NSString *str_filename = [NSString stringWithFormat:@"file-%@-save.m4a",[dateFormat stringFromDate:today]];
    return str_filename;
}

+(NSURL *)getfilepathURLFromFilename:(NSString *)filename
{
    
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               filename,
                               nil];
    
    NSLog(@"recorderFilePath: %@",pathComponents);
    return [NSURL fileURLWithPathComponents:pathComponents];
}
+(void)removeFileFromPath :(NSURL *)url
{
    NSError *err = nil;
    
    NSData *audioData = [NSData dataWithContentsOfFile:[url path] options: 0 error:&err];
    if(audioData)
    {
        NSFileManager *fm = [NSFileManager defaultManager];
        [fm removeItemAtPath:[url path] error:&err];
    }
    if(err){
        NSLog(@"audioSession: %@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
        return;
    }
    
}

#pragma mark -  Datetime

+(NSString *)getCalculatedTimeFromTimer :(NSTimeInterval)currentTime
{
    int totalSeconds = (int)ceil(currentTime);
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    //int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d",minutes, seconds];
}

+(NSString *)setAPPDateFormat :(NSString *)str
{
    if (str.length<=0) {
        return @"";
    }
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:kDateFormat];
    NSDate *date = [format dateFromString:str];
    [format setDateFormat:kDateFormatForAPP];
    NSString* finalDateString = [format stringFromDate:date];
    return finalDateString;
}

+(NSString *)setAPPTimeFormat :(NSString *)str
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:kTimeFormat];
    NSDate *date = [format dateFromString:str];
    [format setDateFormat:kTimeFormatForAPP];
    NSString* finalDateString = [format stringFromDate:date];
    return finalDateString;
}

#pragma mark -  Alert Controller

+(void)alertWithTitle:(NSString *)title andMessage:(NSString *)message
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [topController presentViewController:alertController animated:YES completion:nil];
}

+ (void)alertActionsWithTitle:(NSString *)title andMessage:(NSString *)message Settings:(void (^)(void))Settings
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* Cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:Cancel];
    
    UIAlertAction* Setting = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (Settings) {
            Settings();
        }
    }];
    [alertController addAction:Setting];
    
    [topController presentViewController:alertController animated:YES completion:nil];
    
    
   
}

+ (void)alertQuestionWithTitle:(NSString *)title andMessage:(NSString *)message nodo:(void (^)(void))nodo
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yes = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:yes];
    
    UIAlertAction* no = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (nodo) {
            nodo();
        }
    }];
    [alertController addAction:no];
    
    [topController presentViewController:alertController animated:YES completion:nil];
    
}

+ (void)alertQuestionWithTitle:(NSString *)title andMessage:(NSString *)message yesdo:(void (^)(void))yesdo
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yes = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (yesdo) {
            yesdo();
        }
        
    }];
    [alertController addAction:yes];
    
    UIAlertAction* no = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:no];
    
    [topController presentViewController:alertController animated:YES completion:nil];
    
}

+ (void)actionSheetControllerWithRefButton:(UIButton *)sender controller:(UIViewController *)controller Titles:(NSArray *)titles Checkmarks:(NSArray *)checkmarks withCancel:(NSString *)cancel actionBlock:(void (^)(NSInteger index))actionBlock cancelBlock:(void (^)(void))cancelBlock
{
    //Use
    /*
     [Helpers actionSheetControllerWithRefButton:sender controller:self Titles:[NSArray arrayWithObjects:@"Date",@"Nearness",@"Popularity",@"Clearness", nil] Checkmarks:[NSArray arrayWithObjects:@true,@false,@true,@false, nil] withCancel:@"Cancel" actionBlock:^(NSInteger index) {
     NSLog(@"%ld",(long)index);
     } cancelBlock:nil];
     */
    
    UIAlertController *customActionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    if (titles!=nil) {
        for (NSString *str in titles) {
            UIAlertAction *buttons = [UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                //click action
                
                if (actionBlock) {
                    NSInteger index = [titles indexOfObject:action.title];
                    actionBlock(index);
                }
                
            }];
            
            
            if (checkmarks!=nil && titles.count==checkmarks.count) {
                
                NSInteger index = [titles indexOfObject:str];
                [buttons setValue:[checkmarks objectAtIndex:index] forKey:@"checked"];
            }
            
            [customActionSheet addAction:buttons];
        }

    }
    //[secondButton setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    if (cancel!=nil)
    {
        
        UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            if (cancelBlock) {
                cancelBlock();
            }
        }];
        [cancelButton setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [customActionSheet addAction:cancelButton];
    }
    
    
    [customActionSheet setModalPresentationStyle:UIModalPresentationPopover];
    
    UIPopoverPresentationController *popPresenter = [customActionSheet popoverPresentationController];
    popPresenter.sourceView = sender;
    popPresenter.sourceRect = sender.bounds; // You can set position of popover
    
    
    [controller presentViewController:customActionSheet animated:YES completion:nil];
}



#pragma mark - Other


+(NSString *)calculateLocationLat1:(CGFloat)lat1 Long1:(CGFloat)long1 Lat2:(CGFloat)lat2 Long2:(CGFloat)long2
{
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:lat1 longitude:long1];
    
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:lat2 longitude:long2];
    
    CLLocationDistance distance = [locB distanceFromLocation:locA];
    
    return [NSString stringWithFormat:@"%.2f",distance/1000];
}
+ (BOOL) validateUrl: (NSString *) candidate {
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}


@end
