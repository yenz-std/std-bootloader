#ifndef __io_h_
#define __io_h_

#ifndef __raw_readb
#define __raw_readb(v)    (*(volatile unsigned char *)(v))
#endif

#ifndef __raw_readw
#define __raw_readw(v)     (*(volatile unsigned short *)(v))
#endif


#ifndef __raw_readl
#define __raw_readl(v)     (*(volatile unsigned int *)(v))
#endif

#ifndef __raw_writeb
#define __raw_writeb(v,a)    (*(volatile unsigned char *)(a) = (v))
#endif

#ifndef __raw_writew
#define __raw_writew(v,a)    (*(volatile unsigned short *)(a) = (v))
#endif

#ifndef __raw_writel
#define __raw_writel(v,a)    (*(volatile unsigned int *)(a) = (v))
#endif

#define readl(v)  __raw_readl(v)
#define readw(a)  __raw_readw(a)
#define readb(a)  __raw_readb(a)

#define writeb(v,a)  __raw_writeb(v,a)
#define writew(v,a)  __raw_writew(v,a)
#define writel(v,a)  __raw_writel(v,a)

#endif
