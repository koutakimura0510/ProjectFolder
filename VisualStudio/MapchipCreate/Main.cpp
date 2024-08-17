/*------------------------------------------------------------------------------
 * Create  2024/08/02
 * Author  Kouta Kimura
 * Windows 11
 * Visual Studio 2022 
 * SDL2-2.30.6
 * 
 * SDLを用いた画像読み込みファイルプログラム
 * ./program 画像ファイル名.拡張子
 * 
 * 扱う画像ファイルの仮定
 * RGBのカラー画像
 * 1画素のR.G.B成分は1バイトであること
 * 画像データは隙間なく並んでいること
 * R.G.Bの順番にデータが格納されていること
 *-----------------------------------------------------------------------------*/

 /**---------------------------------------------------------------------------
  * インクルードファイル
  * ---------------------------------------------------------------------------*/
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <tchar.h>
#include <SDL.h>
#include <SDL_image.h>
#include <Windows.h>



/**-----------------------------------------------------------------------------
 * HD画質、1280 x 3 x 15画面のデータ容量を超える場合
 * N_POSの乗数を増やす
 *-----------------------------------------------------------------------------*/
#define BUFFER_SIZE 	(1920 * 1080)
#define CUT_LINE_MAX	(32)
#define WINDOW_WIDTH	(800)
#define WINDOW_HEIGHT	(600)
#define ID_TEXTBOX1		(101)
#define ID_TEXTBOX2		(102)
#define	ID_TEXTBOX3		(103)
#define	ID_TEXTBOX4		(104)
#define	ID_TEXTBOX5		(105)
#define ID_BUTTON1		(1)
#define ID_BUTTON2		(2)
#define TEXT_BUFFER_SIZE (64)

 /**-----------------------------------------------------------------------------
  * RGB生成タイプ
  *-----------------------------------------------------------------------------*/
typedef enum
{
	XILINX,
	DEFAULT,
} RGB_TYPE;


/**-----------------------------------------------------------------------------
 * Pixel Info 構造体
 *-----------------------------------------------------------------------------*/
typedef struct {
	uint32_t pixel_wid;			// 1画像の X軸の切り取り領域指定
	uint32_t pixel_hei;			// 1画像の Y軸の切り取り領域指定
	uint32_t type;				// RGB データの並び順指定
	uint32_t color_bit;			// 1pixel の Bit幅を指定
	uint32_t memory_type;		// メモリのフォーマット指定
	uint32_t id_cnt;			// 切り抜き領域に ID を割り振る。デバッグ用途。
	uint32_t ypixel_cut;
	uint32_t xpixel_cut;
	uint32_t cut_line;
	uint8_t cut_line_buff[CUT_LINE_MAX];
} PixelInfo;


/**-----------------------------------------------------------------------------
 * Global インスタンス
 *-----------------------------------------------------------------------------*/
SDL_Surface* image;
SDL_PixelFormat* fmt;
FILE* fp;
HANDLE gFile;
HINSTANCE hInst;
TCHAR gMessageBuffer[1024];


/**-----------------------------------------------------------------------------
 * プロトタイプ宣言
 *-----------------------------------------------------------------------------*/
HANDLE file_create(HWND hWnd, char* path, char* dir_path);
bool mapchip_info_eoc(uint8_t xpos, uint8_t* id_buff);
uint32_t mapchip_pixel_gen(uint32_t alpha, uint32_t red, uint32_t green, uint32_t blue, uint32_t type, uint32_t color_bit);
uint32_t mapchip_color_upload(PixelInfo* info, uint8_t* color, uint8_t* sdl_pixe, uint32_t byte_per_pixel);
void mapchip_file_save(PixelInfo* info, uint8_t* color, uint32_t wmax, uint32_t byte_per_pixel);
void mapchip_info_save(PixelInfo* info);
void pixel_generate(PixelInfo pinfo);
static int sdl_init(HWND hWnd);
static void append_to_buffer(HWND hWnd, TCHAR msg_buffer[], TCHAR add_str[]);

/**-----------------------------------------------------------------------------
 * ウィンドウプロシージャのコールバック関数
 *-----------------------------------------------------------------------------*/
LRESULT CALLBACK WindowProcedure(HWND, UINT, WPARAM, LPARAM);


/**-----------------------------------------------------------------------------
 * 初期設定関数
 *
 * *path
 * 画像データのパスを入力
 *-----------------------------------------------------------------------------*/
HANDLE file_create(HWND hWnd, char* path, char* dir_path)
{
	char create_file[256] = "";
	strcat(create_file, path);
	size_t file_path_len = _tcslen(create_file);
	create_file[file_path_len - 3] = 'd';
	create_file[file_path_len - 2] = 'a';
	create_file[file_path_len - 1] = 't';

	image = IMG_Load(path);

	if (NULL == image) {
		MessageBox(hWnd, _T("ファイルの読み込みに失敗しました。"), _T("エラー"), MB_OK | MB_ICONERROR);

		return INVALID_HANDLE_VALUE;
	}

	/* ファイルのオープンとエラーチェック */
	gFile = CreateFile(
		create_file,				// ファイル名
		GENERIC_WRITE,              // 書き込みアクセス
		0,                          // 共有モード
		NULL,                       // セキュリティ属性
		CREATE_ALWAYS,              // 作成方法
		FILE_ATTRIBUTE_NORMAL,      // ファイル属性
		NULL);                      // テンプレートファイル

	if (gFile == INVALID_HANDLE_VALUE) {
		MessageBox(hWnd, _T("ファイル作成に失敗しました。"), _T("エラー"), MB_OK | MB_ICONERROR);
		return INVALID_HANDLE_VALUE;
	}

	return gFile;
}


/**-----------------------------------------------------------------------------
 * 指定した画像データのくり抜き領域をチェック
 *-----------------------------------------------------------------------------*/
bool mapchip_info_eoc(uint8_t xpos, uint8_t* id_buff)
{
	for (uint8_t i = 0; i < CUT_LINE_MAX; i++) {
		if (xpos == id_buff[i]) {
			return true;
		}
	}

	return false;
}

 /*
  * RGBを形成
  *
  * type
  * RGBの生成パターンを選択
  */
uint32_t mapchip_pixel_gen(uint32_t alpha, uint32_t red, uint32_t green, uint32_t blue, uint32_t type, uint32_t color_bit)
{
	uint32_t pixel;
	uint8_t msb;
	uint8_t lsb;

	switch (color_bit) {
	case 0:
		msb = 4;
		lsb = 4;
		break;

	default:
		msb = 8;
		lsb = 0;
		break;
	}

	switch (type) {
	case XILINX:
		pixel = alpha >> lsb;
		pixel = (pixel << msb) | (red >> lsb);
		pixel = (pixel << msb) | (blue >> lsb);
		pixel = (pixel << msb) | (green >> lsb);
		break;

	default:
		pixel = alpha >> lsb;
		pixel = (pixel << msb) | (red >> lsb);
		pixel = (pixel << msb) | (green >> lsb);
		pixel = (pixel << msb) | (blue >> lsb);
		break;
	}

	return pixel;
}

/**-----------------------------------------------------------------------------
 * MapChip 色データ抽出
 *-----------------------------------------------------------------------------*/
uint32_t mapchip_color_upload(PixelInfo* info, uint8_t* color, uint8_t* sdl_pixel, uint32_t byte_per_pixel)
{
	uint32_t wpos = 0;

	for (uint32_t y = 0; y < info->pixel_hei; y++) { // 指定範囲のマップチップデータ取得
		uint32_t cuty = y * image->w * byte_per_pixel;

		for (uint32_t x = 0; x < info->pixel_wid; x++) {
			uint32_t cutx = x * byte_per_pixel;

			for (uint32_t rgbx = 0; rgbx < byte_per_pixel; rgbx++) {	// 1pixel の RGB 要素抜き出し
				uint32_t pos = rgbx + cutx + cuty + info->xpixel_cut + info->ypixel_cut;
				color[wpos] = sdl_pixel[pos];
				wpos++;
			}
		}
	}

	return wpos;
}

/**-----------------------------------------------------------------------------
 * MapChip RGB データのファイル出力
 *-----------------------------------------------------------------------------*/
void mapchip_file_save(PixelInfo* info, uint8_t* color, uint32_t wmax, uint32_t byte_per_pixel)
{
	for (uint32_t x = 0; x < wmax; x = x + byte_per_pixel)
	{
		uint32_t pixel;

		if (byte_per_pixel == 3)
		{
			pixel = mapchip_pixel_gen(0xff, color[x + 2], color[x + 1], color[x], info->type, info->color_bit);
		}
		else
		{
			pixel = mapchip_pixel_gen(color[x + 3], color[x], color[x + 1], color[x + 2], info->type, info->color_bit);
		}

		switch (info->memory_type) {
		case 0:
			if (info->color_bit == 0) {
				// fprintf(fp, "%04x\n", pixel);
			}
			else
			{
				// fprintf(fp, "%08x\n", pixel);
			}
			break;

		default:
			if (info->color_bit == 0) {
				// fprintf(fp, "0x%04x\n", pixel);
			}
			else
			{
				// fprintf(fp, "0x%08x\n", pixel);
			}
			break;
		}
	}

	// fprintf(stderr, "ID = %3d,  マップチップのサイズ = %4d\n", info->id_cnt, wmax / byte_per_pixel);

	if (info->memory_type == 0) {	//マップチップデータの切り取りが終了したら改行する
		// fprintf(fp, "\n");
	}
}

/**-----------------------------------------------------------------------------
 * MapChip Info Save
 * パラメータ設定を追加する場合は、この関数内に処理追加
 *-----------------------------------------------------------------------------*/
void mapchip_info_save(PixelInfo* info)
{
	if (info->cut_line != 0) {
		uint32_t dec = 1;

		for (uint8_t i = 0; i < image->w / info->pixel_wid; i++) {
			dec *= 10;
		}

		for (uint8_t i = image->w / info->pixel_wid; i > 0; i--) {
			info->cut_line_buff[i] = info->cut_line / dec;
			info->cut_line %= dec;
		}
	}
	else {
		for (uint8_t i = 0; i < CUT_LINE_MAX; i++) {
			info->cut_line_buff[i] = i;
		}
	}
}


/*
 * 画像データの読み込み
 *
 * 1. 画像データの先頭アドレス取得
 * 2. 横幅、縦幅の最大値を取得
 * 3. 画像情報をファイルに出力
 * 4. 1pixelの最大バイト数ずつデータを生成、(RGB24bit = 3bytes)
 *
 * 色データの並び順が RGBである、使用するXilinxIPが RBGのためデータ生成を並び変えながら行う
 */
void pixel_generate(PixelInfo pinfo)
{
	PixelInfo info = pinfo;
	uint8_t color[BUFFER_SIZE];
	uint8_t* sdl_pixel;
	uint32_t wpos;	// Color Buffer WP

	fmt = image->format;
	SDL_LockSurface(image);
	sdl_pixel = ((uint8_t*)image->pixels);
	SDL_UnlockSurface(image);
	mapchip_info_save(&info);

	for (uint32_t y = 0; y < image->h / info.pixel_hei; y++)
	{
		info.ypixel_cut = y * info.pixel_hei * image->w * fmt->BytesPerPixel; // 画像の切り取り Y座標計算

		for (uint32_t x = 0; x < image->w / info.pixel_wid; x++)
		{
			if (false == mapchip_info_eoc(x, info.cut_line_buff)) {
				continue;
			}

			info.xpixel_cut = x * info.pixel_wid * fmt->BytesPerPixel;	// 画像の切り取り x座標計算
			info.id_cnt = x + (y * (image->w / info.pixel_wid));		// 切り取り座標のID算出
			wpos = mapchip_color_upload(&info, color, sdl_pixel, fmt->BitsPerPixel);
			mapchip_file_save(&info, color, wpos, fmt->BitsPerPixel);
		}
	}

	//fclose(fp);
	SDL_Quit();
}

/**-----------------------------------------------------------------------------
 * SDL 画像データ読み込み設定
 *-----------------------------------------------------------------------------*/
static int sdl_init(HWND hWnd)
{
	int32_t flags = IMG_INIT_JPG | IMG_INIT_PNG;
	int32_t initted = IMG_Init(flags);

	if ((initted & flags) != flags) {		// png jpgを使用可能にする
		MessageBox(hWnd, _T("SDL Init 0 初期化に失敗しました"), _T("エラー"), MB_OK | MB_ICONERROR);
		return 1;
	}

	if (SDL_Init(SDL_INIT_EVERYTHING) != 0) {
		MessageBox(hWnd, _T("SDL Init 1 初期化に失敗しました"), _T("エラー"), MB_OK | MB_ICONERROR);
		return 1;
	}

	return 0;
}


/**-----------------------------------------------------------------------------
 * main関数
 *-----------------------------------------------------------------------------*/
int WINAPI WinMain(
	HINSTANCE hInstance,
	HINSTANCE hPrevInstance,
	LPSTR lpCmdLine,
	int nCmdShow)
{
	WNDCLASSW wc = { 0 };
	wc.hbrBackground = (HBRUSH)COLOR_WINDOW;
	wc.hCursor = LoadCursor(NULL, IDC_ARROW);
	wc.hInstance = hInst;
	wc.lpszClassName = L"myWindowClass";
	wc.lpfnWndProc = WindowProcedure;

	if (!RegisterClassW(&wc))
		return -1;

	// main window の生成
	CreateWindowW(L"myWindowClass", L"Mapchip Edit", WS_OVERLAPPEDWINDOW | WS_VISIBLE,
		100, 100, 800, 600, NULL, NULL, NULL, NULL);

	//szWindowClass,					// アプリケーションの名前
	//	szTitle,						// タイトルバーに現れる文字列
	//	WS_OVERLAPPEDWINDOW,			// 生成するウィンドウのタイプ
	//	CW_USEDEFAULT, CW_USEDEFAULT,	// 最初に置くポジション (x, y)
	//	WINDOW_WIDTH, WINDOW_HEIGHT,	// 最初のサイズ (幅, 高さ)
	//	NULL,							// このウィンドウの親ウィンドウのハンドル
	//	NULL,							// メニューバー（このサンプルでは使用せず）
	//	hInstance,						// WinMain関数の最初のパラメータ
	//	NULL							// WM_CREATE情報（このアプリケーションでは使用せず）
	//ShowWindow(hWnd, nCmdShow);
	
	MSG msg = { 0 };

	while (GetMessage(&msg, NULL, NULL, NULL)) {
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}
	return 0;
}

/**-----------------------------------------------------------------------------
 * ウィンドウプロシージャ（メッセージに対するコールバック関数）
 *-----------------------------------------------------------------------------*/
LRESULT CALLBACK WindowProcedure(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	static HWND hEdit1, hEdit2, hEdit3, hEdit4;
	PAINTSTRUCT ps;
	HDC hdc;
	RECT textRect;
	WCHAR width_window_str[] = L"Width の Pixel 数を区切る座標を入力";
	WCHAR height_window_str[] = L"Height の Pixel 数を区切る座標を入力";
	WCHAR rom_window_str[] = L"データの保存形式 0=Flash Memory, 1=BRAM";
	WCHAR clip_window_str[] = L"使用する画像ラインを選択 左足、立姿、左足の歩行画像 = ID 1,2,3 としたとき、立姿を飛ばしたい場合は 13 と入力してください。";
	static TCHAR window_message[TEXT_BUFFER_SIZE] ="ABCDEFGHJKI\n";
	static TCHAR file_path[260];
	TCHAR dir[] = "raw\\";
	TCHAR ADD[TEXT_BUFFER_SIZE] = "1234\n";

	switch (message)
	{
	case WM_CREATE: // 画面の生成
		// 横幅
		CreateWindowW(L"static", width_window_str, WS_VISIBLE | WS_CHILD,
			100, 20, 500, 20, hWnd, NULL, NULL, NULL);
		hEdit1 = CreateWindowW(L"edit", L"", WS_VISIBLE | WS_CHILD | WS_BORDER | ES_NUMBER,
			20, 20, 60, 20, hWnd, (HMENU)ID_TEXTBOX1, NULL, NULL);

		// 縦幅
		CreateWindowW(L"static", height_window_str, WS_VISIBLE | WS_CHILD,
			100, 60, 500, 20, hWnd, NULL, NULL, NULL);
		hEdit2 = CreateWindowW(L"edit", L"", WS_VISIBLE | WS_CHILD | WS_BORDER | ES_NUMBER,
			20, 60, 60, 20,  hWnd, (HMENU)ID_TEXTBOX2, NULL, NULL);

		// メモリ構造選択
		CreateWindowW(L"static", rom_window_str, WS_VISIBLE | WS_CHILD,
			100, 100, 500, 20, hWnd, NULL, NULL, NULL);
		hEdit3 = CreateWindowW(L"edit", L"", WS_VISIBLE | WS_CHILD | WS_BORDER | ES_NUMBER,
			20, 100, 60, 20,  hWnd, (HMENU)ID_TEXTBOX3, NULL, NULL);

		// 読み込みデータ選択
		CreateWindowW(L"static", clip_window_str, WS_VISIBLE | WS_CHILD,
			100, 140, 500, 40, hWnd, NULL, NULL, NULL);
		hEdit4 = CreateWindowW(L"edit", L"", WS_VISIBLE | WS_CHILD | WS_BORDER | ES_NUMBER,
			20, 140, 60, 20, hWnd, (HMENU)ID_TEXTBOX4, NULL, NULL);

		// ファイル選択ボタン
		CreateWindowW(L"button", L"ファイル選択", WS_TABSTOP | WS_VISIBLE | WS_CHILD | BS_DEFPUSHBUTTON,
			20, 180, 120, 25,
			hWnd, (HMENU)ID_BUTTON1, (HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE), NULL);

		// 開始ボタン
		CreateWindowW(L"button", L"開始", WS_TABSTOP | WS_VISIBLE | WS_CHILD | BS_DEFPUSHBUTTON,
			20, 220, 120, 25,
			hWnd, (HMENU)ID_BUTTON2, (HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE), NULL);

		break;

	case WM_COMMAND: // ボタン入力イベント
		switch (LOWORD(wParam)) {
		case ID_BUTTON1:
			OPENFILENAME ofn;
			ZeroMemory(&ofn, sizeof(ofn));
			ofn.lStructSize = sizeof(ofn);
			ofn.hwndOwner = hWnd;
			ofn.lpstrFile = file_path;
			ofn.lpstrFile[0] = '\0'; // バッファを空に初期化
			ofn.nMaxFile = sizeof(file_path) / sizeof(TCHAR); // WCHAR なのでサイズ調整
			ofn.lpstrFilter = "All\0*.*\0Text\0*.TXT\0"; // ワイド文字列
			ofn.nFilterIndex = 1;
			ofn.lpstrFileTitle = NULL;
			ofn.nMaxFileTitle = 0;
			ofn.lpstrInitialDir = NULL;
			ofn.Flags = OFN_PATHMUSTEXIST | OFN_FILEMUSTEXIST;

			// ファイル選択ダイアログを表示
			if (GetOpenFileName(&ofn)) {
				// 選択されたファイルのパスを取得して使用する
				//MessageBox(hWnd, ofn.lpstrFile, "Selected File", MB_OK);
			}

			file_create(hWnd, ofn.lpstrFile, dir);
			//InvalidateRect(hWnd, NULL, TRUE); // ウィンドウの再描画を要求
			//UpdateWindow(hWnd);
			break;

		case ID_BUTTON2:
			PixelInfo pinfo;
			GetWindowText(hEdit1, gMessageBuffer, 256);
			pinfo.pixel_wid = atoi(gMessageBuffer);

			GetWindowText(hEdit2, gMessageBuffer, 256);
			pinfo.pixel_hei= atoi(gMessageBuffer);

			GetWindowText(hEdit3, gMessageBuffer, 256);
			pinfo.memory_type = atoi(gMessageBuffer);

			GetWindowText(hEdit4, gMessageBuffer, 256);
			pinfo.cut_line = atoi(gMessageBuffer);

			//sprintf(gMessageBuffer, "Values entered: %d, %d, %d", value1, value2, value3);
			//MessageBox(hWnd, gMessageBuffer, "Input Values", MB_OK);
			// sdl_init();
			sdl_init(hWnd);
			pixel_generate(pinfo);
			append_to_buffer(hWnd, window_message, ADD);
			CloseHandle(gFile); // ファイルを閉じる
		default:
			break;
		}

	case WM_PAINT:
		//GetClientRect(hWnd, &rect);

		hdc = BeginPaint(hWnd, &ps);	//  描画処理の開始
		textRect.left = 20;
		textRect.top = 300;
		textRect.right = 600;
		textRect.bottom = 600;
		DrawText(hdc, window_message, -1, &textRect, /*DT_WORDBREAK*/DT_LEFT | DT_TOP | DT_NOCLIP);
		EndPaint(hWnd, &ps);	//  ペイント処理の終了
		break;

	case WM_DESTROY:
		//PostQuitMessage(0);
		break;

	default:
		return DefWindowProc(hWnd, message, wParam, lParam);
		break;
	}

	return 0;
}

/**-----------------------------------------------------------------------------
 * 文字列の更新
 *-----------------------------------------------------------------------------*/
static void append_to_buffer(HWND hWnd, TCHAR msg_buffer[], TCHAR add_str[])
{
    size_t msg_len = _tcslen(msg_buffer);
    size_t add_len = _tcslen(add_str);
    
    // バッファがいっぱいになる場合に対応
    if (msg_len + add_len >= TEXT_BUFFER_SIZE) {
        // バッファの開始位置をずらす
        size_t available_space = TEXT_BUFFER_SIZE - add_len - 1;
        if (available_space < msg_len) {
            memmove(msg_buffer, msg_buffer + (msg_len - available_space), available_space * sizeof(TCHAR));
        }
        msg_len = available_space;
    }
	_tcscat_s(msg_buffer, TEXT_BUFFER_SIZE, add_str);
    
	InvalidateRect(hWnd, NULL, TRUE); // WM_PAINT の再描画を要求
	UpdateWindow(hWnd);
}