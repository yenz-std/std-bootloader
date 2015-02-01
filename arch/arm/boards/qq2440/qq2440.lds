OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)
SECTIONS
{
  . = 0x0;
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
_copysize = _scopy - _ecopy;
