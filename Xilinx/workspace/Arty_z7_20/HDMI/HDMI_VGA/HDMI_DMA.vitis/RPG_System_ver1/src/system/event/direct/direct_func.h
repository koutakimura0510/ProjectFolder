#ifndef direct_func_h   /* prevent circular inclusions */
#define direct_func_h   /* by using protection macros */

bool isDirect_object(GameWrapper *const game);
bool isDirect_event(GameWrapper *const game);
bool isDirect_worldmap(GameWrapper *const game);
bool isDirect_dangeonmap(GameWrapper *const game);
bool isDirect_buildmap(GameWrapper *const game);


#endif
