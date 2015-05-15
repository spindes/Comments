//
//  Utils.h
//  Login Screen created with Storyboards
//
//  Created by Aleksandra Borovytskaya on 4/24/15.
//  Copyright (c) 2015 Aleksandra Borovytskaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  NSString(Utils)

- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet;

- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet;

-(BOOL)validateEmail;

- (BOOL)validatesWithRegExp:(NSString *)regexpString;

@end
