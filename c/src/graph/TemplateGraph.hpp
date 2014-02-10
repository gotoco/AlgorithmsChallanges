#include <vector>
#include <cstdio>
#include <iostream>
#include <algorithm>
#include <string>
#include <vector>
#include "Includes.hpp"

/*
	Graph<V,E>, gdzie V jest typem określajacym dodatkowe
	informacje przechowywane w wierzchołkach,
	natomiast E jest typem określajacym dodatkowe
	informacje przechowywane w krawędziach grafu.

	W ten sposób, jeśli chcemy stworzyć graf modelujacy sieć dróg w mieście,
	to wystarczy wzbogacić strukturę V o informacje zwiazane ze skrzyżowaniami,
	natomiast strukturę E — z ulicami.
*/

template <class V, class E> struct Graph {

// Typ krawędzi (Ed) dziedziczy po typie zawierającym dodatkowe informacje
// związane z krawędzią (E). Zawiera on również pole v, określające numer
// wierzchołka, do którego prowadzi krawędź. Zaimplementowany konstruktor
// pozwala na skrócenie zapisu wielu funkcji korzystających ze struktury grafu.
struct Ed : E {
	int v;
	Ed(E p, int w) : E(p), v(w) { }
};

// Typ wierzchołka (Ve) dziedziczy po typie zawierającym dodatkowe informacje
// z nim związane (V) oraz po wektorze krawędzi. To drugie dziedziczenie może
// wydawać się na pierwszy rzut oka stosunkowo dziwne, lecz jest ono przydatne -
// umożliwia łatwe iterowanie po wszystkich krawędziach wychodzących z
// wierzchołka v: FOREACH(it, g[v])
struct Ve : V, vector<Ed> {};

// Wektor wierzchołków w grafie
vector<Ve> g;

// Konstruktor grafu - przyjmuje jako parametr liczbę wierzchołków
Graph(int n = 0) : g(n) { }

// Funkcja dodająca do grafu nową krawędź skierowaną z wierzchołka b do e,
// zawierającą dodatkowe informacje określone przez zmienną d.
void EdgeD(int b, int e, E d = E()) {
	g[b].PB(Ed(d, e));
	}

// Funkcja dodająca do grafu nową krawędź nieskierowaną, łączącą wierzchołki
// b i e oraz zawierającą dodatkowe informacje określone przez zmienną
// d. Krawędź nieskierowana jest reprezentowana przez dwie krawędzie
// skierowane - jedną prowadzącą z wierzchołka b do wierzchołka e, oraz
// drugą z wierzchołka e do b. Struktura E w grafach nieskierowanych
// musi dodatkowo zawierać element int rev. Dla danej krawędzi skierowanej
// (b,e), pole to przechowuje pozycję krawędzi (e,b) na liście incydencji
// wierzchołka e. Dzięki temu, dla dowolnej krawędzi w grafie w czasie stałym
// można znaleźć krawędź o przeciwnym zwrocie.
void EdgeU(int b, int e, E d = E()) {

	Ed eg(d, e);
	eg.rev = SIZE(g[e]) + (b == e);
	g[b].PB(eg);
	eg.rev = SIZE(g[eg.v = b]) - 1;
	g[e].PB(eg);
	}

void Write() {
// Dla wszystkich wierzchołków w grafie zaczynając od 0...
	REP(x, SIZE(g)) {
		// Wypisz numer wierzchołka
		cout << x << ":";
		// Dla każdej krawędzi wychodzącej z przetwarzanego wierzchołka o numerze
		// x, wypisz numer wierzchołka, do którego ona prowadzi
		FOREACH(it, g[x]) cout << " " << it->v;
		cout << endl;

		}
	}

// Po wykonaniu algorytmu BFS, pole int t wierzchołka zawiera odległość od
// źródła (-1 w przypadku, gdy wierzchołek jest nieosiągalny ze źródła), pole
// int s zawiera numer ojca w drzewie BFS (dla wierzchołka będącego źródłem
// wyszukiwania oraz wierzchołków nieosiągalnych jest to -1)
void Bfs(int s) {
	// Dla każdego wierzchołka w grafie ustawiana jest początkowa wartość zmiennych
	// t oraz s na -1. Źródło wyszukiwania ma czas równy 0
	FOREACH(it, g) it->t = it->s = -1;
	g[s].t = 0;

	// Algorytm BFS jest realizowany przy użyciu kolejki FIFO, do której wstawiane
	// są kolejne wierzchołki oczekujące na przetworzenie
	int qu[SIZE(g)], b, e;
	// Do kolejki wstawione zostaje źródło
	qu[b = e = 0] = s;
	// Dopóki w kolejce są jakieś wierzchołki...
	while (b <= e) {
		s = qu[b++];
		// Dla każdej krawędzi wychodzącej z aktualnie przetwarzanego wierzchołka,
		// jeśli wierzchołek do którego ona prowadzi nie był jeszcze wstawiony do
		// kolejki, wstaw go i wyznacz wartości zmiennych int t i int s

		FOREACH(it, g[s]) if (g[it->v].t == -1) {
			g[qu[++e] = it->v].t = g[s].t + 1;
			g[it->v].s = s;
		}
	}
}
};
