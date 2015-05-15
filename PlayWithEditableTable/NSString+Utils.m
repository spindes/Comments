//
//  Utils.m
//  Login Screen created with Storyboards
//
//  Created by Aleksandra Borovytskaya on 4/24/15.
//  Copyright (c) 2015 Aleksandra Borovytskaya. All rights reserved.
//

#import "NSString+Utils.h"


@implementation NSString (Utils)


- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet {
    NSRange rangeOfFirstWantedCharacter = [self rangeOfCharacterFromSet:[characterSet invertedSet]];
    if (rangeOfFirstWantedCharacter.location == NSNotFound) {
        return @"";
    }
    return [self substringFromIndex:rangeOfFirstWantedCharacter.location];
}

- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet {
    NSRange rangeOfLastWantedCharacter = [self rangeOfCharacterFromSet:[characterSet invertedSet]
                                                               options:NSBackwardsSearch];
    if (rangeOfLastWantedCharacter.location == NSNotFound) {
        return @"";
    }
    return [self substringToIndex:rangeOfLastWantedCharacter.location+1]; // non-inclusive
}

- (BOOL)validateEmail

{
    
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    NSString *text = [self stringByTrimmingLeadingCharactersInSet:set];
    text = [text stringByTrimmingTrailingCharactersInSet:set];
    
    BOOL result = [text validatesWithRegExp:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"];
    return result;
    
}
-(BOOL)validatesWithRegExp:(NSString *)regexpString {
    NSPredicate *regexp = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexpString];
    BOOL result = [regexp evaluateWithObject:self];
    return result;
}


@end
