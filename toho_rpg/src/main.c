/**------------------------------------------------/
 * KeyBoard Toho RPG Game
 * -----------------------------------------------
 * OS Ubuntu LTS 20.04
 * Editor vim non plugin
 * Compiler gcc
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
#include "../include/FILE.H"
#include <gtk/gtk.h>
#include <gdk/gdkkeysyms.h>



/**----------------------------------------------------
 * key動作処理
 * ---------------------------------------------------*/
static bool key_press(GtkWidget *widget, GdkEventKey *key)
{
	uint8_t id;

    switch (key->keyval)
    {
        case GDK_KEY_Left:
			id = LEFT;
            break;

        case GDK_KEY_Up:
			id = UP;
            break;

        case GDK_KEY_Down:
			id = DOWN;
            break;

        case GDK_KEY_Right:
			id = RIGHT;
            break;

        case GDK_KEY_S:
            gtk_main_quit();    //プログラム終了
            break;

		case GDK_OK:
            gtk_main_quit();    //プログラム終了
			break;

        default:
            return false;
    }

	animation_move(id);

    return false;
}


/**---------------------------------------------------
 * デバッグ用keycode取得
 * ---------------------------------------------------*/
static bool key_debug(GtkWidget *widget, GdkEventKey *key, gpointer user_data)
{
    g_print("keyval=%d static=%d string=%s\n", key->keyval, key->state, key->string);
    return false;
}


/**---------------------------------------------------
 * メインループ
 * ---------------------------------------------------*/
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
	animation_move(NON);
	savewrite();
	saveing();
    gtk_main(); //gtkメインループを行う

	clear_screen();
	SET_TYPE(NORMAL);
    strprintf("GTK RPG END");

    return 0;
}
