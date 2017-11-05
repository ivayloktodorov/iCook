//
//  RecipesDetailViewController.m
//  iCook
//
//  Created by Ivaylo Todorov on 7/1/17.
//  Copyright © 2017 Ivaylo Todorov. All rights reserved.
//

#import "RecipesDetailViewController.h"
#import "allUsersViewController.h"
#import "AllRecipesViewController.h"
#import "ViewController.h"
#import "NewRecipesViewController.h"
#import "AlertView.h"
#import <CoreData/CoreData.h>
#import <Social/Social.h>

@interface RecipesDetailViewController ()

@end

@implementation RecipesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _recipeNameLabel.text = _reciName;
    _madeByUserLabel.text = _userLabel;
    _timeLabel.text = _timeLab;
    _howManyPeopleLabel.text = _people;
    _descriptTextView.text = _descript;
    _countryLabel.text = _country;
    [_recipeImage setImage:self.image];
    [self.view addSubview:_recipeImage];
    
    if (!_image) {
        _image = [UIImage imageNamed: @"336510"];
        [_recipeImage setImage:self.image];
        [self.view addSubview:_recipeImage];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)backButton:(id)sender {
    UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AllRecipesViewController* goToAllRecipesVC = [VC instantiateViewControllerWithIdentifier:@"recipesTableVC"];
    [self presentViewController:goToAllRecipesVC animated:NO completion:nil];
}
- (IBAction)shareButton:(id)sender {
    [self ShareFacebook];

}

- (void)ShareFacebook {
    SLComposeViewController *fbController=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];

    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result){
            [fbController dismissViewControllerAnimated:YES completion:nil];
            switch(result){
                case SLComposeViewControllerResultCancelled:
                default:
                {
                    NSLog(@"Cancelled.....");
                }
                    break;
                case SLComposeViewControllerResultDone:
                {
                    NSLog(@"Posted....");
                }
                    break;
            }};
        
        [fbController setInitialText:@"This is My Sample Text"];
        [fbController setCompletionHandler:completionHandler];
        [self presentViewController:fbController animated:YES completion:nil];
    }
    else{
        NSLog(@"mne");
        [AlertView showAlertViewWithTitle:@"Грешка!" message:@"Моля първо да се Log-нете в Facebook." controller:self];
    }
}

@end
