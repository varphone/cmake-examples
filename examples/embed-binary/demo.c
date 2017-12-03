#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <inttypes.h>

#ifdef EMBED_WITH_BLOB
extern char _binary_demo_c_start;
extern char _binary_demo_c_end;
extern char _binary_demo_png_start;
extern char _binary_demo_png_end;
#endif

#ifdef EMBED_WITH_INCLUDE
#include "demo.c.inc"
#include "demo.png.inc"
#endif

/* Resource mapping */
typedef struct _resource_mapping {
	const char* name;	/* Resource name */
	uintptr_t mem_addr;	/* Memory address of the resource */
	uint32_t mem_size;	/* Memory size in bytes of the resource */
} resource_mapping;

static resource_mapping mappings[4] = {
#ifdef EMBED_WITH_BLOB
	{ "demo.c", (uintptr_t)&_binary_demo_c_start, 0 /* Fill later */ },
	{ "demo.png", (uintptr_t)&_binary_demo_png_start, 0 /* Fill later */ },
#endif
#ifdef EMBED_WITH_INCLUDE
	{ "demo.c", (uintptr_t)demo_c, sizeof(demo_c) },
	{ "demo.png", (uintptr_t)demo_png, sizeof(demo_png) },
#endif
	{ NULL, 0, 0 },
};

int main(int argc, char** argv)
{
	int i;
	resource_mapping* p = mappings;
#ifdef EMBED_WITH_BLOB
	mappings[0].mem_size = &_binary_demo_c_end - &_binary_demo_c_start;
	mappings[1].mem_size = &_binary_demo_png_end - &_binary_demo_png_start;
#endif
	while (p->name) {
		printf("mapping name=%s mem_addr=%" PRIxPTR " mem_size=%d\n",
		       p->name, p->mem_addr, p->mem_size);
		p++;
	}
	return 0;
}