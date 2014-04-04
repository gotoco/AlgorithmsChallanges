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
  void Dfs(int e = -1) {
	VI st(SIZE(g));
	int t = -1 , i = 0, b = 0;
	e==-1 ? e=SIZE(g)-1 : b = e;
	REP(x,SIZE(g)) g[x].d = g[x].f = g[x].s = -1;
// Dla wszystkich wierzcholkow z przedzialu [b..e], jesli wierzcholek nie byl jeszcze odwiedzony...
	FOR(s,b,e) if(g[s].d == -1) {
// Wstaw wierzcholek na stos i ustaw dla niego odpowiedni czas wejscia. Zmienna f wierzcholka sluzy tymczasowo jako licznik nieprzetworzonych krawedzi wychodzacych z wierzcholka.
		g[st[i++] = s].d = ++t; g[s].f = SIZE(g[s]);
// Dopoki stos jest niepusty...
		while(i) {
			int s = st[i-1];
// Przetworz kolejna krawedz wychodzaca z aktualnego wierzcholka, lub usuñ go ze stosu (gdy nie ma juz wiecej krawedzi)
			if (!g[s].f) {g[s].f = ++t; --i;} else {
// Jesli wierzcholek, do ktorego prowadzi krawedz nie byl jeszcze odwiedzony, to...
				if (g[s = g[s][--g[s].f].v].d == -1) {
// Ustaw numer wierzcholka-ojca w drzewie DFS oraz ustaw liczbe nieprzetworzonych krawedzi wychodzacych z wierzcholka
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
struct Ve {int rev;};
// Wzbogacenie struktury wierzcholkow w grafie zawiera dodatkowe elementy wymagane przez algorytm DFS, oraz liste l uzywana przez algorytm LCA, sluzacego do wyznaczania najwczesniejszego wspolnego przodka dwoch wierzcholkow w drzewie
struct Vs {
	int d, f, s; 
	VI l;
};

// Makro Desc zwraca prawde, jesli wierzcholek n jest przodkiem wierzcholka m w drzewie g
#define Desc(n,m) (g->g[n].d <= g->g[m].d && g->g[n].f >= g->g[m].f)
// Funkcja LCA zwraca odleglosc wierzcholka b od sciezki prowadzacej miedzy wierzcholkiem e, a korzeniem drzewa g
int LCA(Graph<Vs, Ve> *g, int b, int e) {
	int res = 0, p = SIZE(g->g[b].l)-1;
// Dopoki wierzcholek b nie jest przodkiem wierzcholka e...
	while(!Desc(b, e)) {
// Wykorzystujac wyznaczone wartosci przodkow z tablicy LCA, przesuwamy sie w gore drzewa, wykonujac za kazdym razem krok o wielkosci bedacej potega dwojki
		p = min(p, SIZE(g->g[b].l)-1);
		while(p>0 && Desc(g->g[b].l[p], e)) p--;
// Zwieksz wyznaczona odleglosc o wielkosc wykonywanego kroku oraz wykonaj ten krok
		res += (1<<p);
		b = g->g[b].l[p];
	}
	return res;
}

// Funkcja wyznacza wartosci tablic l dla wszystkich wierzcholkow drzewa. Dla ustalonego wierzcholka v, kolejne elementy tablicy l reprezentuja numery wierzcholkow o odleglosci 1, 2, 4 ... od wierzcholka v w kierunku korzenia drzewa (wierzcholek numer 0)
void GenLCA(Graph<Vs, Ve> *g, int v) {
	if (v != 0 && !SIZE(g->g[v].l)) {
		int c = g->g[v].s;
// Wyznacz liste l dla ojca wierzcholka v
		GenLCA(g, c);
// Wstaw na liste l wierzcholka v jego ojca jako pierwszy element
		g->g[v].l.PB(c);
// Wykorzystaj tablice LCA przodkow do wyznaczenia wyniku dla wierzcholka v
		while(SIZE(g->g[c].l) >= SIZE(g->g[v].l)) {
			c = g->g[c].l[SIZE(g->g[v].l)-1];
			g->g[v].l.PB(c);
		}
	}
}

int main() {
	int n, m, b, e;
// Wczytaj opis drzewa, po ktorym podrozuje Bajtazar
	cin >> n;
	Graph<Vs, Ve> gr(n);
	REP(x, n-1) {
		cin >> b >> e;
		gr.EdgeU(b-1, e-1);
	}
// Wykonaj algorytm DFS, a nastepnie wylicz wartosci list LCA wierzcholkow
	gr.Dfs(0);
	FOR(x,1,n-1) GenLCA(&gr, x);
// Wczytaj dlugosc trasy Bajtazara oraz miejsce startowe
	cin >> m;
	cin >> b;
	int res = 0;
// Dla kolejnej trasy, wyznacz jej dlugosc oraz zwieksz wynik
	REP(x, m-1) {
		cin >> e;
		res += LCA(&gr, b-1, e-1) + LCA(&gr, e-1, b-1);
		b = e;
	}
// Wypisz wynik
	cout << res << endl;
	return 0;
}
