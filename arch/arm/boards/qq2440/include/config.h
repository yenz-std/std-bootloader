#ifndef __CONFIG_H_
#define __CONFIG_H_

/* config MPLL 405MHZ for input frequency 12mHZ*/
#define MP_MDIV 0x7f
#define MP_PDIV 0x2
#define MP_SDIV 0x1

/* config MPLL 399.65MHZ for input frequency 16.9344 */
/* #define MP_MDIV 0x6e */
/* #define MP_PDIV 0x3 */
/* #define MP_SDIV 0x1 */




/* config UPLL 48MHZ */
#define UP_MDIV 0x38
#define UP_PDIV 0x2
#define UP_SDIV 0x2

#define BOARD_SPECIFIC_CLKDIVN  0x5
#define BOARD_SPECIFIC_MPLL  ((MP_MDIV << 12) | (MP_PDIV << 4) | 0x1)
#define BOARD_SPECIFIC_UPLL  ((UP_MDIV << 12) | (UP_PDIV << 4) | 0x2)

#endif
