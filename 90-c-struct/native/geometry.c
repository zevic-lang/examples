/* Built automatically because it is in native/. The structs match the extern struct declarations in Main.zev. */
#include <math.h>

typedef struct { double X, Y; } Vec2;
typedef struct { double MinX, MinY, MaxX, MaxY; } Box;

void geo_translate(Vec2 *p, double dx, double dy) {
    p->X += dx;
    p->Y += dy;
}

/* C functions called from Zevic cannot return a struct by value, so the result goes through a pointer. */
void geo_centroid(const Vec2 *pts, int n, Vec2 *out) {
    out->X = 0.0;
    out->Y = 0.0;
    for (int i = 0; i < n; i++) {
        out->X += pts[i].X;
        out->Y += pts[i].Y;
    }
    if (n > 0) {
        out->X /= n;
        out->Y /= n;
    }
}

void geo_bounds(const Vec2 *pts, int n, Box *out) {
    if (n <= 0) return;
    out->MinX = out->MaxX = pts[0].X;
    out->MinY = out->MaxY = pts[0].Y;
    for (int i = 1; i < n; i++) {
        if (pts[i].X < out->MinX) out->MinX = pts[i].X;
        if (pts[i].X > out->MaxX) out->MaxX = pts[i].X;
        if (pts[i].Y < out->MinY) out->MinY = pts[i].Y;
        if (pts[i].Y > out->MaxY) out->MaxY = pts[i].Y;
    }
}

double geo_perimeter(const Vec2 *pts, int n) {
    double total = 0.0;
    for (int i = 0; i < n; i++) {
        const Vec2 *a = &pts[i];
        const Vec2 *b = &pts[(i + 1) % n];
        total += sqrt((b->X - a->X) * (b->X - a->X) + (b->Y - a->Y) * (b->Y - a->Y));
    }
    return total;
}
