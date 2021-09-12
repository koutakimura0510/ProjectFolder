#ifndef FILE_H_
#define FILE_H_

bool mapf_write(const char *filepath, uint32_t *framebuffer, uint32_t maxwidth, uint32_t maxheight);
bool bin_read(const char *filepath, uint32_t *framebuffer, uint32_t maxwidth, uint32_t maxheight);

#endif
