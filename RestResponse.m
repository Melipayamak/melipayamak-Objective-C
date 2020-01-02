//
//  RestResponse.m
//  mp_objC
//
//  Created by Amirhossein Mehrvarzi on 11/26/19.
//  Copyright © 2019 Melipayamak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestResponse.h"


@implementation RestResponse


-(id)init:(NSData *)mutableData{
    
    self = [super init];
    
    NSError *error;
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:mutableData options:NSJSONReadingAllowFragments error:&error] ;
    
    [self setValuesForKeysWithDictionary:JSONDictionary];
    // Or you can do it using a loop instead of method above
    return self;
}
@end
