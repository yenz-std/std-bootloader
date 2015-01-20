#ifndef _BIT_OPS_H
#define _BIT_OPS_H

static inline void __set_bit(int nr,volatile void * addr)
{
   ((unsigned char *) addr)[nr >> 3] |= (1U << (nr & 7));
}

static inline void __clear_bit(int nr,volatile void * addr)
{
  ((unsigned char *) addr)[nr >>3] &= (~(1U << (nr & 7)));
  //  ((unsigned char *) addr)[nr >> 3] &= ~(1U << (nr & 7));
  //((unsigned char *) addr)[nr >> 3] &= (~(1U << (nr & 7)));

}


#endif
