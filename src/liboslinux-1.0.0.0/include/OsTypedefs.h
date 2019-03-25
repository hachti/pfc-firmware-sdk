//------------------------------------------------------------------------------
/// Copyright (c) WAGO Kontakttechnik GmbH & Co. KG
///
/// PROPRIETARY RIGHTS are involved in the subject matter of this material. All
/// manufacturing, reproduction, use, and sales rights pertaining to this
/// subject matter are governed by the license agreement. The recipient of this
/// software implicitly accepts the terms of the license.
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
/// \file ${file_name}
///
/// \version <Revision>: $Rev$
///
/// \brief short description of the file contents
///
/// \author ${user} $Author$ : WAGO Kontakttechnik GmbH & Co. KG
//------------------------------------------------------------------------------

#ifndef OS_TYPEDEFS_H_
#define OS_TYPEDEFS_H_


//------------------------------------------------------------------------------
// Include files
//------------------------------------------------------------------------------

#include <semaphore.h>
#define __need_timespec
#include <time.h>

#include <pthread.h>

//------------------------------------------------------------------------------
// Constants
//------------------------------------------------------------------------------

enum
{
   OS_S_OK = 0,
   OS_E_NO_MEMORY,
   OS_E_UNKNOWN = -1U,
};

//------------------------------------------------------------------------------
// Macros
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
// Typedefs
//------------------------------------------------------------------------------

//typedef pthread_mutex_t tOS_Mutex;
//typedef pthread_mutex_t tOS_Lock;
//typedef sem_t			   tOS_Event;
//typedef sem_t 				tOS_Semaphore;
//typedef struct timespec tOsTime;
//typedef pthread_t			tOS_Thread;
//typedef pthread_rwlock_t tOs_RwLock;

//typedef  void *(*__start_routine)(void *);

//------------------------------------------------------------------------------
// Global variables
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
// Local variables
//------------------------------------------------------------------------------



#endif /* OS_TYPEDEFS_H_ */
