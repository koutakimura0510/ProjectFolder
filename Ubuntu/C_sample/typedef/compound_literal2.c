/**-------------------------------------------------
 * 複合リテラルサンプルプログラム2
 *
 * Ubuntu-LTS 20.04 kimura
 * -------------------------------------------------*/

#include <stdio.h>

typedef struct {
	int x;
	int y;
} Point;

static Point point;


/**-------------------------------------------------
 * メイン関数
 * -------------------------------------------------*/
int main(int argc, char **argv)
{
	//Point point;

	point = (Point){100, 20};

	printf("(%d, %d)\n", point.x, point.y);

	return 0;
}
