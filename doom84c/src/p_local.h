#ifndef P_LOCAL_H
#define P_LOCAL_H

#include "doomdef.h"
#include "generated.h"

#define DEATH_TICS 14
typedef struct {
    int16_t x, y;
    uint8_t sector, hp, removed, cooldown, explode, pain, die;
} Actor;

#define EXPLODE_TIC 3
#define EXPLODE_TOTAL (NUM_BARREL_EXP * EXPLODE_TIC)
#define PISTOL_TOTAL 19
#define PISTOL_FIRE_AT 15

extern Actor actors[NUM_ACTORS];
extern uint8_t sprite_order[NUM_ACTORS];
extern int16_t sprite_z[NUM_ACTORS], sprite_x[NUM_ACTORS];

extern int16_t sector_ceiling[NUM_SECTORS], sector_target[NUM_SECTORS];
extern int16_t sector_floor[NUM_SECTORS], floor_target[NUM_SECTORS];
extern uint8_t floor_wait[NUM_SECTORS];
extern uint8_t use_held;

#endif /* P_LOCAL_H */
