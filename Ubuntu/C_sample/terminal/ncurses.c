#include <ncurses.h>

int main(void)
{
	initscr();		//画面クリア
	noecho();		//キー入力を表示しない
	curs_set(0);	//カーソル非表示

	mvprintw(1, 0, "Helloe world");

	while (true) {
		int ch = getch();
		if (ch == 'q') {
			break;
		}
	}
	endwin();
}
