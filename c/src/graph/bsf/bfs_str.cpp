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
// wydawac sie na pierwszy rzut oka stosunkowo dziwne, lecz jest ono
// przydatne - umozliwia latwe iterowanie po wszystkich krawedziach wychodzacych
// z wierzcholka v: FOREACH(it, g[v])
	struct Ve : V,vector<Ed> {};
// Wektor wierzcholkow w grafie
	vector<Ve> g;
// Konstruktor grafu - przyjmuje jako parametr liczbe wierzcholkow
	Graph(int n=0) : g(n) {}
// Funkcja dodajaca do grafu nowa krawedz nieskierowana, laczaca wierzcholki
// b i e oraz zawierajaca dodatkowe informacje okreslone przez zmienna d.
// Krawedz nieskierowana jest reprezentowana przez dwie krawedzie 
// skierowane - jedna prowadzaca z wierzcholka b do wierzcholka e oraz druga
// prowadzaca z wierzcholka e do wierzcholka b. Struktura E w grafach
// nieskierowanych musi dodatkowo zawierac element int rev. Dla danej krawedzi
// skierowanej $(b,e)$ pole to przechowuje pozycje krawedzi $(e,b)$ na liscie 
// incydencji wierzcholka $e$. Dzieki temu dla dowolnej krawedzi w grafie mozna
// w czasie stalym znalezc krawedz o przeciwnym zwrocie
	void EdgeU(int b, int e, E d = E()) {
	    Ed eg(d,e); eg.rev=SIZE(g[e])+(b==e); g[b].PB(eg);
	    eg.rev=SIZE(g[eg.v=b])-1; g[e].PB(eg);
	}
// Po wykonaniu algorytmu BFS pole int t wierzcholka zawiera odleglosc od zrodla
// (-1, gdy wierzcholek jest nieosiagalny ze zrodla), pole int s zawiera numer
// ojca w drzewie BFS (dla wierzcholka bedacego zrodlem wyszukiwania oraz
// wierzcholkow nieosiagalnych jest to -1)
  void Bfs(int s) {
// Dla kazdego wierzcholka w grafie ustawiana jest poczatkowa wartosc zmiennych
// t oraz s na -1. zrodlo wyszukiwania ma czas rowny 0
	FOREACH(it, g) it->t=it->s=-1; g[s].t=0;
// Algorytm BFS jest realizowany przy uzyciu kolejki FIFO, do ktorej wstawiane
// sa kolejne wierzcholki oczekujace na przetworzenie
	int qu[SIZE(g)],b,e;
// Do kolejki wstawione zostaje zrodlo
    qu[b=e=0]=s;
// Dopoki w kolejce sa jakies wierzcholki...
    while(b<=e) {
      s=qu[b++];
// Dla kazdej krawedzi wychodzacej z aktualnie przetwarzanego wierzcholka,
// jesli wierzcholek, do ktorego ona prowadzi, nie byl jeszcze wstawiony do
// kolejki, wstaw go i wyznacz wartosci zmiennych int t i int s
      FOREACH(it, g[s]) if (g[it->v].t==-1) {
        g[qu[++e]=it->v].t=g[s].t+1;
		g[it->v].s=s;
      }
    }
  }
};
// Krawedzie grafu nieskierowanego wymagaja dodatkowego pola int rev
struct Ve {
	int rev;
}; 
// Wzbogacenie wierzcholkow musi zawierac pola wymagane przez algorytm BFS
struct Vs {
	int t, s;
};
int main() {
	int n, m, s, b, e;
// Wczytaj liczbe wierzcholkow, krawedzi oraz numer wierzcholka startowego
	cin >> n >> m >> s;
	Graph<Vs, Ve> g(n);
// Dodaj do grafu wszystkie krawedzie
	REP(x,m) {
		cin >> b >> e;
		g.EdgeU(b, e);
	}
// Wykonaj algorytm BFS
	g.Bfs(s);
// Wypisz wynik
	REP(x, n) cout << "Wierzcholek " << x << ": czas = " << g.g[x].t << 
		", ojciec w lesie BFS = " << g.g[x].s << endl;
	return 0;
}
