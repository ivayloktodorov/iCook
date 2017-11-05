//
//  allUsersViewController.h
//  iCook
//
//  Created by Ivaylo Todorov on 7/1/17.
//  Copyright © 2017 Ivaylo Todorov. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import <MessageUI/MessageUI.h>

@interface allUsersViewController : ViewController <MFMailComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    
    __weak IBOutlet UISearchBar *searchbar;
    // uisearchbar
    
    BOOL isSearched;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableViewOutled;
@property (nonatomic, strong) NSMutableArray* users;
@property (nonatomic, strong) NSMutableArray* recipes;
@property (nonatomic, strong) NSMutableArray* searchedResults;
@property (nonatomic, strong) NSMutableArray* emailArray;
@property (nonatomic, retain) UIImage* image;

- (IBAction)backButton:(id)sender;

@end
