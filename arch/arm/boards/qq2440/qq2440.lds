OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)
SECTIONS
{
  . = 0x00000800;
  _scopy = .;

.text :
     { 
      *(.text.bootm_init.text) ;
      *(.text)
     }
  
.data : {*(.data)}
 _ecopy = .;

_sbss = .;
.bss :{*(.bss)}
 _ebss = .;
}

