/**-------------------------------------------------
 * 複合リテラルサンプルプログラム
 *
 * Ubuntu-LTS 20.04 kimura
 * -------------------------------------------------*/

#include <stdio.h>

typedef struct {
	int x;
	int y;
} Point;


/**-------------------------------------------------
 * 中心点を求める
 * -------------------------------------------------*/
Point center(const Point *p1, const Point *p2)
{
	return (Point) {
		.x = (p1->x + p2->x) / 2,
		.y = (p1->y + p2->y) / 2
	};
}


/**-------------------------------------------------
 * メイン関数
 * -------------------------------------------------*/
int main(int argc, char **argv)
{
	Point p = center(&(Point){1, 2}, &(Point){2, 3});

	printf("(%d, %d)\n", p.x, p.y);

	return 0;
}