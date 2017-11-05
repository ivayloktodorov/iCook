//
//  CountriesViewController.h
//  iCook
//
//  Created by Ivaylo Todorov on 7/2/17.
//  Copyright © 2017 Ivaylo Todorov. All rights reserved.
//

#import "ViewController.h"

@interface CountriesViewController : ViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchControllerDelegate> {

    NSMutableArray *countries;
    NSMutableArray *searchResult;
    BOOL isSearching;
    UISearchBar *searchBar;
    
}




@property (nonatomic, strong) NSString *countryText;
@property (weak, nonatomic) IBOutlet UITableView *tableViewOutled;
@property (nonatomic, strong) NSString *recipeName;
@property (nonatomic, strong) NSString *recipeTime;
@property (nonatomic, strong) NSString *recipeDescript;
@property (strong, nonatomic) NSString * pickerInfo;
@property (nonatomic, retain) UIImageView* photo;

- (IBAction)backButton:(id)sender;

@end
