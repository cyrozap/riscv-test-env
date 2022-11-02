OUTPUT_ARCH( "riscv" )
ENTRY(_start)

MEMORY
{
  RAM (rw) : ORIGIN = 0x00000000, LENGTH = 64k
  ROM (rx) : ORIGIN = 0x80000000, LENGTH = 64k
}

SECTIONS
{
  .text.init : {
    *(.text.init)
    . = ALIGN(0x1000);
  } >ROM
  .tohost : {
    *(.tohost)
    . = ALIGN(0x1000);
  } >ROM
  .text : {
    *(.text)
    . = ALIGN(0x1000);
  } >ROM

  .data : {
    _data_start = .;
    *(.data*)
    . = ALIGN(4);
    _data_end = .;
  } >RAM AT >ROM
  _data_loadaddr = LOADADDR(.data);

  .bss : {
    _bss_start = .;
    *(.bss*)
    . = ALIGN(4);
    _bss_end = .;
  } >RAM
  _end = .;

  /DISCARD/ : { *(.eh_frame) }

  . = ALIGN(4);
  end = .;
}
