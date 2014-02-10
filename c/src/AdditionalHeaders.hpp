#include <complex>
#include <iterator>
#include <set>
#include <bitset>
#include <map>
#include <stack>
#include <list>
#include <queue>
#include <deque>
#include <vector>
// Stała INF jest wykorzystywana jako reprezentacja nieskończoności. Ma ona
// wartość 1000000001, a nie 2147483647 (największa wartość typu int) ze
// względu na dwa fakty - prosty zapis, oraz brak przepełnienia wartości zmiennej
// w przypadku dodawania dwóch nieskończoności do siebie
// ((int) 2147483647 + (int) 2147483647 = -2).
const int INF = 1000000001;
// Stała EPS jest używana w wielu algorytmach geometrycznych do porównywania
// wartości bliskich zera (w zadaniach tego typu pojawia się wiele problemów
// związanych z błędami zaokrągleń)
const double EPS = 10e-9;
// Skrócone nazwy różnych typów i operatorów o długich nazwach
/*typedef vector<VI> VVI;
typedef vector<LL> VLL;
typedef vector<double> VD;
typedef vector<string> VS;
typedef pair<int, int> PII;
typedef vector<PII> VPII;*/
#define PF push front
#define MP make pair
