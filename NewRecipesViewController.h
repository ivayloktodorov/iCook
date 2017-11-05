//
//  NewRecipesViewController.h
//  iCook
//
//  Created by Ivaylo Todorov on 7/1/17.
//  Copyright © 2017 Ivaylo Todorov. All rights reserved.
//

#import "ViewController.h"

@interface NewRecipesViewController : ViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    
    
}

@property (weak, nonatomic) IBOutlet UITextField *recipeNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *cookTimeTextField;
@property (nonatomic, strong) IBOutlet UIButton *countryName;
@property (strong, nonatomic) IBOutlet UIPickerView *objPickerView;
@property (strong, nonatomic) NSString * pickerInfo;
@property (nonatomic, strong) NSMutableArray* recipes;
@property (nonatomic, strong) NSString *countryText;
@property (nonatomic, strong) NSString *recipeID;
@property (nonatomic, strong) NSString *recipeName;
@property (nonatomic, strong) NSString *recipeTime;
@property (nonatomic, strong) NSString *recipeDescript;
@property (weak, nonatomic) IBOutlet UITextView *recipeTextView;


@property (nonatomic, strong) UIImagePickerController* picker;
@property (nonatomic, strong) NSData *coreImage;
@property (nonatomic, retain) UIImage *chosenImage;
@property(nonatomic, assign) id<UINavigationControllerDelegate,
UIImagePickerControllerDelegate> delegate;

- (IBAction)selectCountryButton:(id)sender;
- (IBAction)uploadPhotoButoon:(id)sender;
- (IBAction)saveNewRecipeButton:(id)sender;
- (IBAction)backButton:(id)sender;
@end
