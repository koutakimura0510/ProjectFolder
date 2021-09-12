/* ---------------------------------------------------------------------------------
 * マルチスレッドサンプル
 * Ubuntu LTS 20.04 kimura
 * ---------------------------------------------------------------------------------
 * mutexの変数保護確認 スレッドに構造体のアドレスを渡す
 * ---------------------------------------------------------------------------------
 * 変数をスレッド間で操作する時、mutexで保護をしないと書き込み最中に他スレッドで
 * 操作されてしまい、バグの原因になります。
 *
 * pthread_join()関数は指定したスレッドが終了するまで
 * 呼び出しスレッドをブロックします。
 *
 * 指定するスレッドは、現在のプロセス内で切り離されていないものでなければなりません
 * 複数のスレッドが、同じスレッドの終了を待つことはできません。
 * --------------------------------------------------------------------------------*/

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <unistd.h>
#include <err.h>


/* -------------------------------------------------
 * 構造体確保
 * count	  : スレッド動作確認用、fprintf関数でカウンターの値をスレッド内で表示
 * flag		  : カウンター処理、確認用フラグ
 * thread_eoc : カウントスレッドの処理チェック用フラグ
 * -------------------------------------------------*/
typedef struct {
	int32_t count;
	int32_t flag;
	int32_t thread_eoc;
} t_thread;
static t_thread idthread = {0, 0, 0};


/* ------------------------------------------------
 * int pthread_create(pyhread_t *thread, const pthread_attr_t *attr,
 * 					  void *(*start_routine)(void *), void *arg);
 * ------------------------------------------------*/
void *thread_print(void *p);	//描画用スレッド
void *thread_cnt(void *p);		//カウント用スレッド
void *thread_str(void *p);


/* -------------------------------------------------
 * mutexの確保、スレッド間で変数の保護を行う
 * -------------------------------------------------*/
pthread_mutex_t mutex;


/* -------------------------------------------------
 * メインスレッド
 * -------------------------------------------------*/
int main(int argc, char *argv[])
{
	t_thread *p = &idthread;
	pthread_t tid1, tid2, tid3;
	int32_t errprint, errcnt, errstr;
	char *msg[] = {"TEST"};

	/* mutex初期化 */
	pthread_mutex_init(&mutex, NULL);

	/* スレッドの生成 */
	errprint = pthread_create(&tid1, NULL, thread_print, (void *)p);
	errcnt = pthread_create(&tid2, NULL, thread_cnt, (void *)p);
	errstr = pthread_create(&tid3, NULL, thread_str, (void **)msg);

	if (errprint != 0) {
		err(EXIT_FAILURE, "can not create thread_print: %s", strerror(errprint));
	}

	if (errcnt != 0) {
		err(EXIT_FAILURE, "can not create thread_cnt: %s", strerror(errcnt));
	}

	if (errcnt != 0) {
		err(EXIT_FAILURE, "can not create thread_str: %s", strerror(errstr));
	}

	/* メインにsleepを書いてもスレッドは動き続ける */
	while(1) {
		sleep(1);
		if (p->count == 50) {
			fprintf(stderr, "main while break\r\n");
			break;
		}
	}
	
	/* スレッドが終了したら指定したスレッドを破棄する */
	pthread_join(tid1, NULL);
	pthread_join(tid2, NULL);

	pthread_mutex_destroy(&mutex);
	fprintf(stderr, "threadが正しく終了しました プログラムを終了します\r\n");

	return 0;
}


/* -----------------------------------------------
 * スレッド2で更新されたカウンタの値を一定間隔で表示する
 * -----------------------------------------------*/
void *thread_print(void *p)
{
	t_thread *cntp = (t_thread *)p;
	int n = 0;
	char *s[] = {
		" ／ ",
		" ｜ ",
		" ＼ ",
		" 一 ",
	};

	while (cntp->thread_eoc != 1) {
		pthread_mutex_lock(&mutex);
		fprintf(stderr, "%s cnt = %d\r", s[n], cntp->count);
		n++;
		n &= 0x03;
		cntp->flag = 1;
		pthread_mutex_unlock(&mutex);
		usleep(100000);
	}
	fprintf(stderr, "\r\nthread1 done\r\n");

	return 0;
}


/* ------------------------------------------------
 * スレッド処理フラグが立っている時のみカウントの値を更新する
 * ------------------------------------------------*/
void *thread_cnt(void *p)
{
	t_thread *cntp = (t_thread *)p;

	while(cntp->count <= 100) {
		if (cntp->flag != 0) {
			pthread_mutex_lock(&mutex);
			cntp->count++;
			cntp->flag = 0;
			pthread_mutex_unlock(&mutex);
		}
	}
	cntp->thread_eoc = 1;
	fprintf(stderr, "\r\nthread2 done\r\n");

	return 0;
}


/* ------------------------------------------------
 * 文字列描画スレッド、detached動作の確認
 * ------------------------------------------------
 * スレッド内でdetached状態にしているため、スレッドのリソースは自動的に開放される
 * そのため、別スレッド内でjoinする必要はない
 * ------------------------------------------------
 * EINVAL : join可能なスレッドではない
 * ESRCH  : IDがthreadのスレッドが見つからない
 * ------------------------------------------------*/
void *thread_str(void *p)
{
	char **msg;
	int32_t error;

	error = pthread_detach(pthread_self());	//このスレッドをdetachとする

	if (error != 0) {
		err(EXIT_FAILURE, "can not detach thread_str: %s", strerror(error));
	}
	msg = (char **)p;
	fprintf(stderr, "%s\n", *msg);
	fprintf(stderr, "thread3 done\r\n");

	return 0;
}
