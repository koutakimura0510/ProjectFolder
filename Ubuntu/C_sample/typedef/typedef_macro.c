#include <stdio.h>
#include <stdint.h>

#define GET_SVMCTL_STRUCT_MEMBER(struct, member) ((struct).member)

typedef struct {
	uint32_t id;
	uint32_t field;
	uint32_t bgmadr;
} DtmDB;

DtmDB db;

// 使用例
int main(void)
{
	db.id = 123;
	db.field = 981;
	db.bgmadr = 111;

	printf("%d\n", GET_SVMCTL_STRUCT_MEMBER(db, bgmadr));
	printf("%d\n", GET_SVMCTL_STRUCT_MEMBER(db, id));
	printf("%d\n", GET_SVMCTL_STRUCT_MEMBER(db, field));

	return 0;
}