//
//  AlertView.h
//  iCook
//
//  Created by Ivaylo Todorov on 7/1/17.
//  Copyright © 2017 Ivaylo Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlertView : NSObject
+(void)showAlertViewWithTitle:(NSString*)title message:(NSString*)message controller:(UIViewController*)controller;

@end
