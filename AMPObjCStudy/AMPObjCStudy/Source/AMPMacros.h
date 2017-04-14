//
//  AMPMacros.h
//  AMPStudy
//
//  Created by pilotns on 09.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#ifndef AMPMacros_h
#define AMPMacros_h

#include <stdio.h>

#define AMPSeparator "---------------------------------------------\n"

#define AMPOutputWithTypeAndFormatter(type, formatter) \
    void AMPOutput_##type(type value) { \
        printf(#formatter "\n", value); \
    }

#define AMPCallOutputMacroWithType(type, value) \
    AMPOutput_##type(value);


#define AMPPrintOffsetof(type, value) \
    printf(#value " offset - %lu\n", offsetof(type, value))

#define AMPPrintString(string) \
    printf("%s", string);


#define AMPCallTest(test, inputParameter) \
    do { \
        test(inputParameter); \
        AMPPrintString(AMPSeparator) \
    } while(false)


#define AMPEmptyParameter

static const uint16_t value = 1;
#define AMPIsBigendian() (*(char *)&value == 1)

#endif /* AMPMacros_h */
