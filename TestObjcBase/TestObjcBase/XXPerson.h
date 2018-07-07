//
//  XXPerson.h
//  TestObjcBase
//
//  Created by MacPro on 02/07/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXPerson : NSObject{
    struct {
        char handsome : 2; // 位域，代表占用一位空间
        char rich : 2;  // 按照顺序只占一位空间
        char tall : 2;
    } _tallRichHandsome;
    
}
@property (assign, nonatomic, getter=isTall) BOOL tall;
@property (assign, nonatomic, getter=isRich) BOOL rich;
@property (assign, nonatomic, getter=isHandsome) BOOL handsome;

@end
