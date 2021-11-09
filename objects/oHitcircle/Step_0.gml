event_inherited();

// Create temporary ds list to hold collision
var tmpDS = ds_list_create();

collision_circle_list(x, y, radius, all, 0, 1, tmpDS, true);

check_hit_list(tmpDS, hit, status, allyTag);

ds_list_destroy(tmpDS);
