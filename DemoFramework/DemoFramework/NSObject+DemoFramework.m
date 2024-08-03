//
//  NSObject+DemoFramework.m
//  DemoFramework
//
//  Created by Antonio Posabella on 3/8/24.
//

#import "NSObject+DemoFramework.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@interface NSObject (DemoFrameworkMethods)
-(id)buttonTapped;
@end

@implementation NSObject (DemoFramework)
+ (void)load {
    NSLog(@"[DEMO FRAMEWORK] loaded");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
        Class targetClass = NSClassFromString(@"AnalysisDemoApp.ViewController");
        
        NSLog(@"[DEMO FRAMEWORK] targetClass");
        SEL originalSelector = @selector(buttonTapped);
        SEL swizzledSelector = @selector(swizzled_buttonTapped);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        
        class_addMethod(
                        targetClass,
                        method_getName(swizzledMethod),
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        Method originalMethod = class_getInstanceMethod(targetClass, originalSelector);
        Method addedMethod = class_getInstanceMethod(targetClass, swizzledSelector);
        
        method_exchangeImplementations(originalMethod, addedMethod);
    });
}

- (void)swizzled_buttonTapped {
    NSLog(@"[DEMO FRAMEWORK] Tapped");
    [self showPopup];
}


-(void)showPopup {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = keyWindow.rootViewController;
    
    if (rootViewController != nil) {
        // Create the alert controller
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hello World!"
                                                                       message:@""
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        // Add an action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {}];
        
        [alert addAction:okAction];
        
        [rootViewController presentViewController:alert animated:YES completion:nil];
    } else {
        NSLog(@"[DEMO FRAMEWORK] Root view controller is nil");
    }
    
}
@end
