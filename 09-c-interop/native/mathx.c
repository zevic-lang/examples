/* Built automatically because it is in native/. */

/* Implemented in Zevic (see export "C" in src/Main.zev). */
void Greet(const char *name);

int mathx_square(int x) {
    return x * x;
}

const char *mathx_version(void) {
    return "mathx 1.0";
}

void mathx_greet_twice(const char *name) {
    Greet(name);
    Greet(name);
}
