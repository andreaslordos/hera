//
//  Event+CoreDataProperties.h
//  Hera
//
//  Created by Andreas Lordos on 7/27/22.
//
//

#import "Event+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Event (CoreDataProperties)

+ (NSFetchRequest<Event *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nonatomic) BOOL predicted;
@property (nonatomic) int16_t type;

@end

NS_ASSUME_NONNULL_END
