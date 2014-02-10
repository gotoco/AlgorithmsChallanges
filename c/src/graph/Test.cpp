//============================================================================
// Name        : Test.cpp
// Author      : mgrochowski
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include "Includes.hpp"
#include "TemplateGraph.hpp"

using namespace std;

struct Empty { };

// Krawedzie grafu nieskierowanego wymagaja dodatkowego pola int rev
struct Ve {
	int rev;
};
// Wzbogacenie wierzcholkow musi zawierac pola wymagane przez algorytm BFS
struct Vs {
	int t, s;
};

/*int main() {

	cout <<"Podaj liczbę n i m!" << endl; // prints !!!Hello World!!!

	int n, m, b, e, s;
	// Wczytaj liczbę wierzchołków i krawędzi w grafie
	cin >> n >> m ;
	cout <<"Podaj wierzchołek s dla którego odpalimy bsf!" << endl;
	cin >> s;
	cout <<"Wprowadzaj połączenia między wierzchołkami !" << endl;
	// Skonstruuj graf o odpowiednim rozmiarze, nie zawierający dodatkowych
	// informacji dla wierzchołków ani krawędzi
	Graph<Vs, Ve> gr(n);
	REP(x, m) {
		// Wczytaj początek i koniec kolejnej krawędzi
		cin >> b >> e;
		// Dodaj do grafu krawędź skierowaną z wierzchołka b do e
		// Dodaj do grafu krawędź skierowaną z wierzchołka b do e
		gr.EdgeU(b, e);
	}

	// Wypisz graf
	gr.Write();

	// Wykonaj algorytm BFS
	gr.Bfs(s);
	// Wypisz wynik
	REP(x, n) cout << "Wierzcholek " << x << ": czas = " << gr.g[x].t <<
	", ojciec w drzewie BFS = " << gr.g[x].s << endl;

	return 0;
}*/
