/* Built automatically because it is in native/. */
#include <stddef.h>

int ev_read_int(const void *p) {
    return *(const int *)p;
}

int ev_sum(int from, int to, int (*f)(int)) {
    int total = 0;
    for (int i = from; i < to; i++) total += f(i);
    return total;
}

static unsigned long g_id;
static void (*g_cb)(unsigned long, int);

void ev_subscribe(unsigned long id, void (*f)(unsigned long, int)) {
    g_id = id;
    g_cb = f;
}

void ev_fire(int value) {
    if (g_cb) g_cb(g_id, value);
}
