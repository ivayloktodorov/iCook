//
//  AlertView.m
//  iCook
//
//  Created by Ivaylo Todorov on 7/1/17.
//  Copyright © 2017 Ivaylo Todorov. All rights reserved.
//

#import "AlertView.h"
#import "ViewController.h"
#import "UserProfileViewController.h"
#import "SignUpViewController.h"
#import "RecipesDetailViewController.h"
#import "NewRecipesViewController.h"
#import "AllRecipesViewController.h"

@implementation AlertView
+(void)showAlertViewWithTitle:(NSString*)title message:(NSString*)message controller:(UIViewController*)controller {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okButton];
    [controller presentViewController:alert animated:NO completion:nil];
}



@end
