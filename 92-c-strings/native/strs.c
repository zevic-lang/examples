/* Built automatically because it is in native/. */
#include <ctype.h>
#include <stdlib.h>
#include <string.h>

char *strs_upper(const char *s) {
    size_t n = strlen(s);
    char *out = malloc(n + 1);
    for (size_t i = 0; i <= n; i++) out[i] = (char)toupper((unsigned char)s[i]);
    return out;
}

char *strs_join(const char *a, const char *b) {
    size_t na = strlen(a), nb = strlen(b);
    char *out = malloc(na + nb + 1);
    memcpy(out, a, na);
    memcpy(out + na, b, nb + 1);
    return out;
}

static char *g_stored;

/* Takes ownership: the Zevic side passed a copy made with NewString. */
void strs_store(char *s) { g_stored = s; }
const char *strs_stored(void) { return g_stored; }
void strs_release(void) { free(g_stored); g_stored = NULL; }

const char *strs_broken(void) { return "ok\xff\xfe!"; }
