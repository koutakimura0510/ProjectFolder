/**------------------------------------------------/
 * KeyBoard Toho RPG Game
 * -----------------------------------------------
 * 2020/09/16 kouta kimura
 * Ubuntu LTS 20.04
 * Editor vim non plugin
 * ------------------------------------------------*/


/**------------------------------------------------/
 * include
 * gf   :pathを指定することによりヘッダファイルに移動できる
 * <C-^>:直前のバッファに移動する
 * <C-o>:直前の作業ポイントにジャンプする
 * ------------------------------------------------*/
#include "../include/LIB.H"
#include "../include/DRAW.H"
#include "../include/MODE.H"
#include "../include/KEYBOARD.H"
#include <gtk/gtk.h>
#include <gdk/gdkkeysyms.h>


static int32_t x = 5+5;
static int32_t y = 5+5;
static int32_t mapx = 0;
static int32_t mapy = 0;

/**-------------------------------------------------------------------------------------
 * key動作処理
 * -------------------------------------------------------------------------------------*/
static bool key_press(GtkWidget *widget, GdkEventKey *key, gpointer user_data)
{
    switch (key->keyval)
    {
        case GDK_KEY_Right:
			if (0 == xpos_move(mapx, x)) {
				x++;
			}else{
				mapx++;
			}
            break;

        case GDK_KEY_Up:
            y--;
            break;

        case GDK_KEY_Down:
			if (y > 5+(FIELD_HEIGHT/2)) {
				mapy++;
			}else{
				y++;
			}
            break;

        case GDK_KEY_Left:
            x--;
            break;

        case GDK_KEY_S:
            gtk_main_quit();    //プログラム終了
            break;

		case GDK_OK:
            gtk_main_quit();    //プログラム終了
			break;

        default:
            break;
    }

    mapdraw(mapx, mapy);
    reimu_draw(x, y, RED, "霊");

    return false;
}


/**-------------------------------------------------------------------------------------
 * デバッグ用keycode取得
 * -------------------------------------------------------------------------------------*/
static bool key_debug(GtkWidget *widget, GdkEventKey *key, gpointer user_data)
{
    g_print("keyval=%d static=%d string=%s\n", key->keyval, key->state, key->string);
    return false;
}


/**-------------------------------------------------------------------------------------
 * メインループ
 * -------------------------------------------------------------------------------------*/
int main(int argc, char **argv)
{
    GtkWidget *window;
    gtk_init(&argc, &argv);

    window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    gtk_widget_set_size_request(window, 0, 0);  //windowを描画しない
    g_signal_connect(G_OBJECT(window), "key_press_event", G_CALLBACK(key_press), NULL);
    //g_signal_connect(G_OBJECT(window), "key_press_event", G_CALLBACK(key_debug), NULL); //デバッグ
    g_signal_connect(window, "destroy", G_CALLBACK(gtk_main_quit), NULL);   //プログラム終了
    gtk_widget_show_all(window);    //windowを描画

    CURSOL_OFF();
	map_info_struct_write(GLASS);
    mapdraw(0, 0);
    reimu_draw(x, y, RED, "霊");
	
    gtk_main(); //gtkメインループを行う

	clear_screen();
	SET_TYPE(NORMAL);
	SET_CHAR_COLOR(WHITE);
    strprintf("GTK RPG END");

    return 0;
}
