#include <cstdio>
#include <iostream>
#include <algorithm>
#include <string>
#include <vector>

using namespace std;

// Dwa z najczesciej uzywanych typow o dlugich nazwach - ich skrocenie jest bardzo istotne
typedef vector<int> VI;
typedef long long LL;

// W programach bardzo rzadko mozna znalezc w pelni zapisana instrukcje petli. Zamiast niej, wykorzystywane sa trzy nastepujace makra:
// FOR - petla zwiekszajaca zmienna x od b do e wlacznie
#define FOR(x, b, e) for(int x = b; x <= (e); ++x)
// FORD - petla zmniejszajaca zmienna x od b do e wlacznie
#define FORD(x, b, e) for(int x = b; x >= (e); --x)
// REP - petla zwiekszajaca zmienna x od 0 do n. Jest ona bardzo czesto wykorzystywana do konstruowania i przegladania struktur danych
#define REP(x, n) for(int x = 0; x < (n); ++x)
// Makro VAR(v,n) deklaruje nowa zmienna o nazwie v oraz typie i wartosci zmiennej n. Jest ono czesto wykorzystywane podczas operowania na iteratorach struktur danych z biblioteki STL, ktorych nazwy typow sa bardzo dlugie
#define VAR(v, n) __typeof(n) v = (n)
// ALL(c) reprezentuje pare iteratorow wskazujacych odpowiednio na pierwszy i za ostatni element w strukturach danych STL. Makro to jest bardzo przydatne chociazby w przypadku korzystania z funkcji sort, ktora jako parametry przyjmuje pare iteratorow reprezentujacych przedzial elementow do posortowania.
#define ALL(c) (c).begin(), (c).end()
// Ponizsze makro sluzy do wyznaczania rozmiaru struktur danych STL. Uzywa sie go w programach, zamiast pisac po prostu x.size() z uwagi na fakt, iz wyrazenie x.size() jest typu unsigned int i w przypadku porownywania z typem int, w procesie kompilacji generowane jest ostrzezenie.
#define SIZE(x) ((int)(x).size())
// Bardzo pozyteczne makro, sluzace do iterowania po wszystkich elementach w strukturach danych STL.
#define FOREACH(i, c) for(VAR(i, (c).begin()); i != (c).end(); ++i)
// Skrot - zamiast pisac push_back podczas wstawiania elementow na koniec struktury danych, takiej jak vector, wystarczy napisac PB
#define PB push_back
// Podobnie - zamiast first bedziemy pisali po prostu ST
#define ST first
// a zamiast second - ND.
#define ND second
#include <list>
// Wartosc INF jest wykorzystywana jako reprezentacja nieskoñczonosci. Ma ona wartosc 1000000001, a nie 2147483647 (najwieksza wartosc typu int) ze wzgledu na dwa fakty - prosty zapis oraz brak przepelnienia wartosci zmiennej w przypadku dodawania dwoch nieskoñczonosci do siebie: ((int) 2147483647 + (int) 2147483647 = -2).
const int INF = 1000000001;
template<class V, class E> struct Graph {
// Typ krawedzi (Ed) dziedziczy po typie zawierajacym dodatkowe informacje zwiazane z krawedzia (E). Zawiera on rowniez pole v, okreslajace numer wierzcholka, do ktorego prowadzi krawedz. Zaimplementowany konstruktor pozwala na skrocenie zapisu wielu funkcji korzystajacych ze struktury grafu.
	struct Ed : E {
		int v; 
		Ed(E p, int w) : E(p), v(w) {}
	};
// Typ wierzcholka (Ve) dziedziczy po typie zawierajacym dodatkowe informacje z nim zwiazane (V) oraz po wektorze krawedzi. To drugie dziedziczenie moze wydawac sie na pierwszy rzut oka stosunkowo dziwne, lecz jest ono przydatne - umozliwia latwe iterowanie po wszystkich krawedziach wychodzacych z wierzcholka v: FOREACH(it, g[v])
	struct Ve : V,vector<Ed> {};
// Wektor wierzcholkow w grafie
	vector<Ve> g;
// Konstruktor grafu - przyjmuje jako parametr liczbe wierzcholkow
	Graph(int n=0) : g(n) {}
// Funkcja dodajaca do grafu nowa krawedz nieskierowana, laczaca wierzcholki b i e oraz zawierajaca dodatkowe informacje okreslone przez zmienna d. Krawedz nieskierowana jest reprezentowana przez dwie krawedzie skierowane - jedna prowadzaca z wierzcholka b do wierzcholka e, oraz druga z wierzcholka e do b. Struktura E w grafach nieskierowanych musi dodatkowo zawierac element int rev. Dla danej krawedzi skierowanej $(b,e)$, pole to przechowuje pozycje krawedzi $(e,b)$ na liscie incydencji wierzcholka $e$. Dzieki temu, dla dowolnej krawedzi w grafie w czasie stalym mozna znalezc krawedz o przeciwnym zwrocie.
	void EdgeU(int b, int e, E d = E()) {
	    Ed eg(d,e); eg.rev=SIZE(g[e])+(b==e); g[b].PB(eg);
	    eg.rev=SIZE(g[eg.v=b])-1; g[e].PB(eg);
	}
// Po wykonaniu algorytmu BFS, pole int t wierzcholka zawiera odleglosc od zrodla (-1 w przypadku, gdy wierzcholek jest nieosiagalny ze zrodla), pole int s zawiera numer ojca w drzewie BFS (dla wierzcholka bedacego zrodlem wyszukiwania oraz wierzcholkow nieosiagalnych jest to -1)
  void Bfs(int s) {
// Dla kazdego wierzcholka w grafie ustawiana jest poczatkowa wartosc zmiennych t oraz s na -1. rodlo wyszukiwania ma czas rowny 0
	FOREACH(it, g) it->t=it->s=-1; g[s].t=0;
// Algorytm BFS jest realizowany przy uzyciu kolejki FIFO, do ktorej wstawiane sa kolejne wierzcholki oczekujace na przetworzenie
	int qu[SIZE(g)],b,e;
// Do kolejki wstawione zostaje zrodlo
    qu[b=e=0]=s;
// Dopoki w kolejce sa jakies wierzcholki...
    while(b<=e) {
      s=qu[b++];
// Dla kazdej krawedzi wychodzacej z aktualnie przetwarzanego wierzcholka, jesli wierzcholek do ktorego ona prowadzi nie byl jeszcze wstawiony do kolejki, wstaw go i wyznacz wartosci zmiennych int t i int s
      FOREACH(it, g[s]) if (g[it->v].t==-1) {
        g[qu[++e]=it->v].t=g[s].t+1;
		g[it->v].s=s;
      }
    }
  }
};
struct Ve {int rev;};
struct Vs {int t, s;};

// Tablica kpos zawiera aktualne pozycje mrowek, a knr zlicza, ile razy odpowiednia mrowka przegonila biedronke. lst sluzy jako kolejka mrowek, ktore moga sie jeszcze ruszac
int kpos[1000], knr[1000], lst[1000];

// Funkcja zaznacza wszystkie wierzcholki w poddrzewie BFS wierzcholka v jako zablokowane (mrowki nie moga tam juz wchodzic)
void Mark(Graph<Vs, Ve> &g, int v, int t) {
	g.g[v].t = t;
	FOREACH(it, g.g[v]) if (g.g[v].s != it->v && g.g[it->v].t == INF)
			Mark(g, it->v, t);
}

int main() {
	int n, b, e, k, l;
// Wczytaj laczna liczbe lisci i rozgalezieñ w drzewie
	cin >> n;
// Skonstruuj odpowiedni graf do reprezentacji drzewa
	Graph<Vs, Ve> g(n);
// Wczytaj kolejne galazki drzewa i dodaj je do grafu
	REP(x, n-1) {
		cin >> b >> e;
		g.EdgeU(b-1, e-1);
	}
// Wczytaj liczbe oraz pozycje mrowek
	cin >> k;
	REP(x, k) {
		cin >> kpos[x];
		kpos[x]--;
		knr[x] = 0;
	}
// Wczytaj liczbe ladowañ biedronki
	cin >> l;
// Dla kazdego ladowania wyznacz przesuniecia mrowek...
	while(l--) {
		int len = k, nlen, t = 2;
		cin >> b;
// Wyznacz drzewo BFS ukorzenione w wierzcholku ladowania biedronki
		g.Bfs(--b);
// Zaznacz wierzcholki, do ktorych zadna mrowka nie wejdzie
		REP(y, n) g.g[y].t = INF;
		REP(y, k) Mark(g, kpos[lst[y] = y], 0);
// Dopoki sa mrowki, ktore moga wykonac ruch...
		while(len) {
// Sprobuj przesunac kazda mrowke, ktora ma szanse sie ruszyc
			REP(y, len) {
// Jesli aktualna mrowka znajduje sie w miejscu biedronki, to ja przegania
				if (kpos[lst[y]] == b) {
					knr[lst[y]]++;
					len = 0;
				} else 
// Jesli mrowka juz nie moze sie ruszyc, to usuwamy ja z listy
				if (g.g[e=g.g[kpos[lst[y]]].s].t < t) lst[y] = -1; else {
// Przesuwamy mrowke oraz blokujemy wszystkie wezly z poddrzewa
					Mark(g, kpos[lst[y]] = e, t);
					g.g[e].t = 0;
				}
			}
// Aktualizacja listy mrowek
			nlen = 0;
			REP(x, len) if (lst[x] != -1) lst[nlen++] = lst[x];
			len = nlen;
			t++;
		}
	}
// Wypisz znaleziony wynik
	REP(x, k) cout << kpos[x]+1 << " " << knr[x] << endl;
	return 0;
}
