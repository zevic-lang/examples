// Built automatically (clang++) because it is in native/. Only the extern "C" functions are visible to Zevic.
#include <algorithm>
#include <functional>
#include <map>
#include <memory>
#include <queue>
#include <string>
#include <vector>

namespace {
std::map<long, std::map<std::string, int>> counters;
std::map<long, std::priority_queue<int>> heaps;
std::string scratch;   // keeps wc_first's result alive until the next call
long next_id = 1;
}

extern "C" {

long wc_new() { counters[next_id]; return next_id++; }
void wc_add(long id, const char *w) { counters[id][w]++; }
int wc_count(long id, const char *w) {
    auto &m = counters[id];
    auto it = m.find(w);
    return it == m.end() ? 0 : it->second;
}
int wc_distinct(long id) { return (int)counters[id].size(); }
const char *wc_first(long id) {
    auto &m = counters[id];
    scratch = m.empty() ? "" : m.begin()->first;
    return scratch.c_str();
}
void wc_free(long id) { counters.erase(id); }

long pq_new() { heaps[next_id]; return next_id++; }
void pq_push(long id, int x) { heaps[id].push(x); }
int pq_pop(long id) { auto &h = heaps[id]; int x = h.top(); h.pop(); return x; }
int pq_len(long id) { return (int)heaps[id].size(); }
void pq_free(long id) { heaps.erase(id); }

void cpp_sort_desc(void *p, int n) {
    int *a = static_cast<int *>(p);
    std::sort(a, a + n, std::greater<int>());
}

}
