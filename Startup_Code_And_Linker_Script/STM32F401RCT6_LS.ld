ENTRY(Reset_Handler)

MEMORY
{
	FLASH(rx) : ORIGIN = 0X08000000 , LENGTH = 256K
	SRAM(rwx) : ORIGIN = 0X20000000 , LENGTH = 64K
}

SECTIONS
{
	.text : 
	{
		*(.isr_vector)
		*(.text)
		*(.rodata)
		. = ALIGN(4);
		_etext = . ;
	}>FLASH
	
	.data : 
	{
		_sdata = . ;
		*(.data)
		. = ALIGN(4);
		_edata = . ;
	}>SRAM AT> FLASH 
	
	.bss : 
	{
		_sbss = . ;
		*(.bss)
		. = ALIGN(4);
		_ebss = . ;
	}>SRAM
	
	
}