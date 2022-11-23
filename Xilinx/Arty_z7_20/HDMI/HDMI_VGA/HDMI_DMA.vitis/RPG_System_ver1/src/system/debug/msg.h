#ifndef msg_h   /* prevent circular inclusions */
#define msg_h   /* by using protection macros */


void msg_fprintf(const char *msg, const char *filename, const char *func, int line);

#endif
