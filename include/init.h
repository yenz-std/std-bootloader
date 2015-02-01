#ifndef _INIT_H
#define _INIT_H

#define __section(s)  __attribute__((__section__(#s)))
#define __bootm_init  __section(.text.bootm_init.text)

#endif
