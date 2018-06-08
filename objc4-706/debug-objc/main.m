//
//  main.m
//  debug-objc
//
//  Created by suchavision on 1/24/17.
//
//

#import <Foundation/Foundation.h>
#import "XXObject.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        XXObject *object = [[XXObject alloc] init];
        [object hello];
        [object hello];
    }
    return 0;
}
