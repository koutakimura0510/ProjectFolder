#include <stdio.h>
#include <png.h>

int main(int argc, char **argv)
{
	FILE *fp;
	int x, y;

	png_structp png_str = NULL;
	png_infop info_ptr  = NULL;

	if (argc < 2) {
		fprintf(stderr, "invalid argument\n");
		return -1;
	}

	if ((fp = fopen(argv[1], "rb")) == NULL) {
		perror(argv[1]);
		return -1;
	}

	png_str = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
	info_ptr = png_create_info_struct(png_str);

	if (setjmp(png_jmpbuf(png_str))) {
		png_destroy_read_struct(&png_str, &info_ptr, NULL);
		fclose(fp);
		return -1;
	}

	png_init_io(png_str, fp);
	png_read_png(png_str, info_ptr, PNG_TRANSFORM_PACKING, NULL);
	png_bytepp row_pointers = png_get_rows(png_str, info_ptr);

	if (info_ptr->color_type == PNG_COLOR_TYPE_RGB) {
		for (y = 0; y < info_ptr->height; y++) {
			for (x = 0; x < info_ptr->width; x++) {
				const int r = row_pointers[y][x * 3 + 0];
				const int g = row_pointers[y][x * 3 + 1];
				const int b = row_pointers[y][x * 3 + 2];
				printf("\033[48;2;%d;%d;%dm ", r, g, b);
			}
			printf("\033[0m\n");
		}
	} else if (info_ptr->color_type == PNG_COLOR_TYPE_RGB_ALPHA) {
		for (y = 0; y < info_ptr->height; y++) {
			for (x = 0; x < info_ptr->width; x++) {
				int r = row_pointers[y][x * 4 + 0];
				int g = row_pointers[y][x * 4 + 1];
				int b = row_pointers[y][x * 4 + 2];
				const int a = row_pointers[y][x * 4 + 3];
				if (a != 0xff) {
					r = r * a / 0xff + 0xff - a;
					g = g * a / 0xff + 0xff - a;
					b = b * a / 0xff + 0xff - a;
				}
				printf("\033[48;2;%d;%d;%dm ", r, g, b);
			}
			printf("\033[0m\n");
		}
	} else if (info_ptr->color_type == PNG_COLOR_TYPE_PALETTE) {
		for (y = 0; y < info_ptr->height; y++) {
			for (x = 0; x < info_ptr->width; x++) {
				const int i = row_pointers[y][x];
				const int r = info_ptr->palette[i].red;
				const int g = info_ptr->palette[i].green;
				const int b = info_ptr->palette[i].blue;
				printf("\033[48;2;%d;%d;%dm ", r, g, b);
			}
			printf("\033[0m\n");
		}
	}
	png_destroy_read_struct(&png_str, &info_ptr, NULL);
	fclose(fp);

	return 0;
}
