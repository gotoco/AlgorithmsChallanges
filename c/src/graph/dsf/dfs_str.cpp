#include <cstdio>
#include <iostream>
#include <algorithm>
#include <string>
#include <vector>

using namespace std;

// Dwa z najczesciej uzywanych typow o dlugich nazwach
// - ich skrocenie jest bardzo istotne
typedef vector<int> VI;
typedef long long LL;

// W programach bardzo rzadko mozna znalezc w pelni zapisana instrukcje petli.
// Zamiast niej wykorzystywane sa trzy nastepujace makra:
// FOR - petla zwiekszajaca zmienna x od b do e wlacznie
#define FOR(x, b, e) for(int x = b; x <= (e); ++x)
// FORD - petla zmniejszajaca zmienna x od b do e wlacznie
#define FORD(x, b, e) for(int x = b; x >= (e); --x)
// REP - petla zwiekszajaca zmienna x od 0 do n. Jest ona bardzo czesto
// wykorzystywana do konstruowania i przegladania struktur danych
#define REP(x, n) for(int x = 0; x < (n); ++x)
// Makro VAR(v,n) deklaruje nowa zmienna o nazwie v oraz typie i wartosci 
// zmiennej n. Jest ono czesto wykorzystywane podczas operowania na
// iteratorach struktur danych z biblioteki STL, ktorych nazwy typow sa bardzo dlugie
#define VAR(v, n) __typeof(n) v = (n)
// ALL(c) reprezentuje pare iteratorow wskazujacych odpowiednio na pierwszy
// i za ostatni element w strukturach danych STL. Makro to jest bardzo
// przydatne chociazby w przypadku korzystania z funkcji sort, ktora jako
// parametry przyjmuje pare iteratorow reprezentujacych przedzial
// elementow do posortowania
#define ALL(c) (c).begin(), (c).end()
// Ponizsze makro sluzy do wyznaczania rozmiaru struktur danych STL.
// Uzywa sie go w programach, zamiast pisac po prostu x.size() ze wzgledu na to,
// iz wyrazenie x.size() jest typu unsigned int i w przypadku porownywania
// z typem int w procesie kompilacji generowane jest ostrzezenie
#define SIZE(x) ((int)(x).size())
// Bardzo pozyteczne makro sluzace do iterowania po wszystkich elementach
// w strukturach danych STL
#define FOREACH(i, c) for(VAR(i, (c).begin()); i != (c).end(); ++i)
// Skrot - zamiast pisac push_back podczas wstawiania elementow na koniec
// struktury danych, takiej jak vector, wystarczy napisac PB
#define PB push_back
// Podobnie - zamiast first bedziemy pisali po prostu ST
#define ST first
// a zamiast second - ND
#define ND second

template<class V, class E> struct Graph {
	// Typ krawedzi (Ed) dziedziczy po typie zawierajacym dodatkowe informacje
	// zwiazane z krawedzia (E). Zawiera on rowniez pole v, okreslajace numer
	// wierzcholka, do ktorego prowadzi krawedz. Zaimplementowany konstruktor
	// pozwala na skrocenie zapisu wielu funkcji korzystajacych ze struktury grafu
	struct Ed : E {
		int v; 
		Ed(E p, int w) : E(p), v(w) {}
	};
	// Typ wierzcholka (Ve) dziedziczy po typie zawierajacym dodatkowe informacje
	// z nim zwiazane (V) oraz po wektorze krawedzi. To drugie dziedziczenie moze
	// wydawac sie na pierwszy rzut oka stosunkowo dziwne, lecz jest ono przydatne -
	// umozliwia latwe iterowanie po wszystkich krawedziach wychodzacych
	// z wierzcholka v: FOREACH(it, g[v])
	struct Ve : V, vector<Ed> {};
	// Wektor wierzcholkow w grafie
	vector<Ve> g;
	// Konstruktor grafu - przyjmuje jako parametr liczbe wierzcholkow
	Graph(int n=0) : g(n) {}
	// Funkcja dodajaca do grafu nowa krawedz nieskierowana, laczaca wierzcholki
	// b i e oraz zawierajaca dodatkowe informacje okreslone przez zmienna d.
	// Krawedz nieskierowana jest reprezentowana przez dwie krawedzie skierowane -
	// jedna prowadzaca z wierzcholka b do wierzcholka e oraz druga prowadzaca
	// z wierzcholka e do wierzcholka b. Struktura E w grafach nieskierowanych
	// musi dodatkowo zawierac element int rev. Dla danej krawedzi skierowanej
	// $(b,e)$ pole to przechowuje pozycje krawedzi $(e,b)$ na liscie incydencji
	// wierzcholka $e$. Dzieki temu dla dowolnej krawedzi w grafie mozna w czasie
	// stalym znalezc krawedz o przeciwnym zwrocie
	void EdgeU(int b, int e, E d = E()) {
	    Ed eg(d,e); eg.rev=SIZE(g[e])+(b==e); g[b].PB(eg);
	    eg.rev=SIZE(g[eg.v=b])-1; g[e].PB(eg);
	}
    void Dfs(int e = -1) {

    /*
     * Zmienne d i f reprezentuj ̧a odpowiednio czasy wejścia oraz wyjścia z wierzchołka,
     * natomiast s to numer wierzchołka - ojca w wyznaczonym lesie DFS.
     */
	VI st(SIZE(g));
	int t = -1 , i = 0, b = 0;
	e == -1 ? e=SIZE(g)-1 : b = e;
	//Ustaw wszystkie wierzchołki jako nieodwiedzone
	REP(x,SIZE(g)) g[x].d = g[x].f = g[x].s = -1;

	// Dla wszystkich wierzcholkow z przedzialu [b..e], jesli wierzcholek nie byl
	// jeszcze odwiedzony...
	FOR(s,b,e) if(g[s].d == -1) {
		// Wstaw wierzcholek na stos i ustaw dla niego odpowiedni czas wejscia.
		// Zmienna f wierzcholka sluzy tymczasowo jako licznik nieprzetworzonych
		// krawedzi wychodzacych z wierzcholka
		g[st[i++] = s].d = ++t;
		g[s].f = SIZE(g[s]);

		// Dopoki stos jest niepusty...
		while(i) {
			int s = st[i-1];
			// Przetworz kolejna krawedz wychodzaca z biezacego wierzcholka lub usun go
			// ze stosu (gdy nie ma juz wiecej krawedzi)
			if (g[s].f == 0) {g[s].f = ++t; --i;} else {
				// Jesli wierzcholek, do ktorego prowadzi krawedz, nie byl jeszcze odwiedzony, to...
				if (g[s = g[s][--g[s].f].v].d == -1) {
					// Ustaw numer wierzcholka-ojca w drzewie DFS oraz ustaw liczbe nieprzetworzonych
					// krawedzi wychodzacych z wierzcholka
					g[s].s = st[i-1];
					g[s].f = SIZE(g[s]);
					// Wstaw wierzcholek na stos i ustaw czas wejscia
					g[st[i++] = s].d = ++t;
				}
			}
		}
	}
}
};
// Krawedzie grafu nieskierowanego wymagaja dodatkowego pola int rev
struct Ve {
	int rev;
};
// Wzbogacenie wierzcholkow przechowujace wynik generowany przez algorytm DFS
struct Vs {
	int d, f, s;
};
int main() { 
	int n, m, s, b, e;
	// Wczytaj liczbe wierzcholkow, krawedzi oraz numer wierzcholka startowego
	cin >> n >> m >> s;
	// Skonstruuj odpowiedni graf
	Graph<Vs, Ve> g(n);
	// Dodaj do grafu wszystkie krawedzie
	REP(x,m) {
		cin >> b >> e;
		g.EdgeU(b, e);
	}
	// Wykonaj algorytm DFS i wypisz wynik
	g.Dfs(s);
	REP(x, SIZE(g.g)) cout << "Wierzcholek " << x << ": czas wejscia = " <<
		g.g[x].d << ", czas wyjscia = " << g.g[x].f << 
		", ojciec w lesie DFS = " << g.g[x].s << endl;
	return 0;
}
