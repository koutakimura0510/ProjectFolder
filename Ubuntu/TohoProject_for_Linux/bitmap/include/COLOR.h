#ifndef COLOR_H_
#define COLOR_H_

#define GEKAI_SIZE		((sizeof (gekaidb)) / (sizeof (GekaiDB)))

typedef enum
{
	UMI 	= 0x000061c1,
	SOUGEN  = 0x00afff7b,
	ZYARI	= 0x001e8b00,
	SUNA	= 0x00fffc80,
	TUTI	= 0x00ffb95e,
	YAMA	= 0x00959595,
	KOORI	= 0x007be8ff,
	MAGMA	= 0x00ff3148,
	MAGYAMA = 0x00835c00,
} GekaiID;

typedef struct
{
	uint32_t  name;
	uint32_t mapchipid;
} GekaiDB;

static const GekaiDB gekaidb[] = {
	{UMI, 		76},
	{SOUGEN, 	87},
	{ZYARI, 	87},
	{SUNA, 		122},
	{TUTI, 		123},
	{YAMA, 		175},
	{KOORI, 	388},
	{MAGMA, 	1288},
	{MAGYAMA,	1271},
};

#endif