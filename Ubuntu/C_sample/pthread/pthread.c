/* ------------------------------------------------------
 * マルチスレッドサンプル
 * ------------------------------------------------------
 * スレッドの数だけloop_maxの回数ループを行い
 * 合計値を表示する
 * ------------------------------------------------------
 * 2020/10/05	kimura
 * windows10 WSL1 Ubuntu LTS 18.10
 * gcc -o --- ---.c -lpthread
 * ------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <err.h>
#include <errno.h>
#include <pthread.h>
#include <string.h>
#include <unistd.h>
#include <stdint.h>

const size_t loop_max = 65535;

pthread_mutex_t m = PTHREAD_MUTEX_INITIALIZER;	//ミューテックスの初期設定
int32_t cnt = 0;	//合計値表示用変数

void f1();
void f2();

int main(int argc, char *argv[])
{
	pthread_t thread1, thread2;
	int32_t ret1, ret2;

	printf ("%d\n", cnt);
	ret1 = pthread_create(&thread1, NULL, (void *)f1, NULL);
	ret2 = pthread_create(&thread2, NULL, (void *)f2, NULL);

	if (ret1 != 0) {
		err(EXIT_FAILURE, "can not create thread1: %s", strerror(ret1));
	}

	if (ret2 != 0) {
		err(EXIT_FAILURE, "can not create thread2: %s", strerror(ret2));
	}
	printf ("%d\n", cnt);

	printf("execute pthread_join thread1\n");
	ret1 = pthread_join(thread1, NULL);
	if (ret1 != 0) {
		err(EXIT_FAILURE, "can not join thread2: %d", ret1);
	}
	printf ("%d\n", cnt);

	printf("execute pthread_join thread2\n");
	ret2 = pthread_join(thread2, NULL);
	if (ret2 != 0) {
		err(EXIT_FAILURE, "can not join thread2: %d", ret1);
	}

	printf ("done\n");
	printf ("%d\n", cnt);

	pthread_mutex_destroy(&m);
	return 0;
}

/* --------------------------------------------------
 * スレッド1で実行
 * --------------------------------------------------*/
void f1(void)
{
	size_t i;
	size_t try_again = 0;

	for (i = 0; i < loop_max; i++) {
#ifndef NOLOCK
		int32_t r;
		r = pthread_mutex_lock(&m);
		if (r != 0) {
			if (EBUSY == r) {
				try_again++;
				continue;
			}
			err(EXIT_FAILURE, "can not lock r: %d", r);
		}
#endif
		cnt++;
#ifndef NOLOCK
		r = pthread_mutex_unlock(&m);
		if (r != 0) {
			err(EXIT_FAILURE, "can not lock r: %d", r);
		}
#endif
	}
	printf("%s: try %lu\n", __func__, try_again);	//ロックされた回数を表示
}


/* --------------------------------------------------
 * スレッド2で実行 処理内容はf1と同じ
 * --------------------------------------------------*/
void f2(void)
{
	size_t i;
	size_t try_again = 0;

	for (i = 0; i < loop_max; i++) {
#ifndef NOLOCK
		int32_t r;
		r = pthread_mutex_lock(&m);
		if (r != 0) {
			if (EBUSY == r) {
				try_again++;
				continue;
			}
			err(EXIT_FAILURE, "can not lock r: %d", r);
		}
#endif
		cnt++;
#ifndef NOLOCK
		r = pthread_mutex_unlock(&m);
		if (r != 0) {
			err(EXIT_FAILURE, "can not lock r: %d", r);
		}
#endif
	}
	printf("%s: try %lu\n", __func__, try_again);
}
