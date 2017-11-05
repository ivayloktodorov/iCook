//
//  AllRecipesViewController.h
//  iCook
//
//  Created by Ivaylo Todorov on 7/1/17.
//  Copyright © 2017 Ivaylo Todorov. All rights reserved.
//

#import "ViewController.h"


@interface AllRecipesViewController : ViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchControllerDelegate> {

    IBOutlet UISegmentedControl *segmentedControl;
    int rowNo;
    NSMutableArray *searchResult;
    BOOL isSearching;
//    UISearchBar *searchBar;
    
}


@property (weak, nonatomic) IBOutlet UITableView *tableViewOutled;
@property (nonatomic, strong) NSMutableArray* myRecipes;
@property (nonatomic, strong) NSMutableArray* allRecipes;
@property (nonatomic, strong) NSMutableArray* searchedResults;
@property (strong, nonatomic) IBOutlet UISegmentedControl * segmentedControl;
@property (nonatomic,strong) NSString* user;
@property (nonatomic, strong) NSMutableArray* recipeID;
@property (nonatomic, strong) NSMutableArray* recipeName;
@property (nonatomic, strong) NSMutableArray* recipeCountry;
@property (nonatomic, strong) NSMutableArray* recipeDescript;
@property (nonatomic, strong) NSMutableArray* recipeHowMany;
@property (nonatomic, strong) NSMutableArray* recipeTime;
@property (nonatomic, retain) UIImage* image;

@property (nonatomic) int myRecipeNumber;

- (IBAction)profileButton:(id)sender;
- (IBAction)newRecipeButton:(id)sender;
- (IBAction)segmentedChange:(id)sender;



@end
