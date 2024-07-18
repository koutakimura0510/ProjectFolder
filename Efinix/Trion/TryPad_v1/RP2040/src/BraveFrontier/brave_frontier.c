/*------------------------------------------------------------------------------
 * Create 2024/07/15
 * Author Kouta Kimura
 * 
 *-----------------------------------------------------------------------------*/
#include "../trypad.h"

/**-----------------------------------------------------------------------------
 * ゲームモード関数
 *-----------------------------------------------------------------------------*/
void brave_frontier(void)
{
	// ここでシステム構造体
	SdlRect rect = {.top=0, .under=32, .left=0, .right=32, .color=COLOR_GREEN};
	uint8_t dir = 0;

	while (1) {
		switch (dir)
		{
		case 0:
			if (rect.right == 319) {
				dir = 1;
				rect.color = COLOR_BLUE;
			}
			rect.right++;
			rect.left++;
			break;

		case 1:
			if (rect.under == 239) {
				dir = 2;
				rect.color = COLOR_RED;
			}
			rect.top++;
			rect.under++;
			break;

		case 2:
			if (rect.left == 1) {
				dir = 3;
				rect.color = COLOR_GREEN;
			}
			rect.left--;
			rect.right--;
			break;

		case 3:
			if (rect.top == 1) {
				dir = 0;
				rect.color = 0xffff;
			}
			rect.top--;
			rect.under--;
			break;
		
		default:
			dir = 0;
			break;
		}
		rect_draw(&rect);
		usb_transaction();
		wait_ms(4);
	}
}