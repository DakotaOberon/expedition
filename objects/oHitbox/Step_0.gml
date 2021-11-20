event_inherited();

// Create temporary ds list to hold collision
var tmpDS = ds_list_create();

x1 = x - (width / 2);
y1 = y - (height / 2);
x2 = x + (width / 2);
y2 = y + (height / 2);
collision_rectangle_list(x1, y1, x2, y2, oEntity, 0, 1, tmpDS, true);

check_hit_list(tmpDS, hit, status, allyTag);

ds_list_destroy(tmpDS);