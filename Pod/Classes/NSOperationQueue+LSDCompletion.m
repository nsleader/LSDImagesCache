//
// Created by IVAN CHIRKOV on 21.04.15.
//

#import "NSOperationQueue+LSDCompletion.h"


@implementation NSOperationQueue (LSDCompletion)

- (void)setCompletion:(NSOperationQueueCompletion)completion
{
    NSOperationQueueCompletion copiedCompletion = [completion copy];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self waitUntilAllOperationsAreFinished];

        dispatch_async(dispatch_get_main_queue(), ^{
            copiedCompletion();
        });
    });
}

@end