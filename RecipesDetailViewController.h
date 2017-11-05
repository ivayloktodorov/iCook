//
//  RecipesDetailViewController.h
//  iCook
//
//  Created by Ivaylo Todorov on 7/1/17.
//  Copyright © 2017 Ivaylo Todorov. All rights reserved.
//

#import "ViewController.h"

@interface RecipesDetailViewController : ViewController
- (IBAction)backButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *recipeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *madeByUserLabel;
@property (weak, nonatomic) IBOutlet UIImageView *recipeImage;
@property (nonatomic, retain) IBOutlet UIImage *image;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *howManyPeopleLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptTextView;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (nonatomic,strong) NSString* reciName;
@property (nonatomic,strong) NSString* userLabel;
@property (nonatomic,strong) NSString* timeLab;
@property (nonatomic,strong) NSString* people;
@property (nonatomic,strong) NSString* descript;
@property (nonatomic,strong) NSString* country;
- (IBAction)shareButton:(id)sender;

@end
