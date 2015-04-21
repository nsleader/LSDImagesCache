//
// Created by IVAN CHIRKOV on 21.04.15.
//

#import <Foundation/Foundation.h>

typedef void (^NSOperationQueueCompletion) (void);

@interface NSOperationQueue (LSDCompletion)

- (void)setCompletion:(NSOperationQueueCompletion)completion;

@end