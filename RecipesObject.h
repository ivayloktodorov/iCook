//
//  RecipesObject.h
//  iCook
//
//  Created by Ivaylo Todorov on 7/17/17.
//  Copyright © 2017 Ivaylo Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecipesObject : NSObject

@property (nonatomic, strong) NSString* recipeID;
@property (nonatomic, strong) NSString* user;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* time;
@property (nonatomic, strong) NSString* country;
@property (nonatomic, strong) NSString* howMany;
@property (nonatomic, strong) NSString* decription;
@property (nonatomic, strong) NSData* image;

@end
