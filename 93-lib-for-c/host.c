/* A plain C program that uses the Zevic library through the generated header. */
#include <stdio.h>
#include <stdlib.h>
#include "textstats.h"

int main(void) {
    zevic_init(0, NULL); /* starts the Zevic runtime: call it once before any other Zevic function */

    const char *text = "the quick brown fox\njumps over the lazy dog\nThe end";

    printf("words: %d\n", ts_words(text));
    printf("lines: %d\n", ts_lines(text));
    printf("lines of \"\": %d\n", ts_lines(""));
    printf("lines of \"a\\n\": %d\n", ts_lines("a\n"));

    const char *top = ts_top_word(text);
    printf("top word: %s\n", top);
    free((void *)top);

    const char *rev = ts_reverse_words("one two three four");
    printf("reversed: %s\n", rev);
    free((void *)rev);
    return 0;
}
