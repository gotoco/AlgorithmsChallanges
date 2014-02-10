#include <cstdio>
#include <iostream>
#include <algorithm>
#include <string>
#include <vector>
using namespace std;
// Dwa z najczęściej używanych typów o długich nazwach - ich skrócenie jest bardzo
// istotne
typedef vector<int> VI;
typedef long long LL;
// W programach bardzo rzadko można znaleźć w pełni zapisaną instrukcję pętli.
// Zamiast niej, wykorzystywane są trzy następujące makra:
// FOR - pętla zwiększająca zmienną x od b do e włącznie
#define FOR(x, b, e) for(int x=b; x<=(e); ++x)
// FORD - pętla zmniejszająca zmienną x od b do e włącznie
#define FORD(x, b, e) for(int x=b; x>=(e); ––x)
// REP - pętla zwiększająca zmienną x od 0 do n. Jest ona bardzo
// często wykorzystywana do konstruowania i przeglądania struktur danych
#define REP(x, n) for(int x=0; x<(n); ++x)
// Makro VAR(v,n) deklaruje nową zmienną o nazwie v oraz typie i wartości
// zmiennej n. Jest ono często wykorzystywane podczas operowania na iteratorach
// struktur danych z biblioteki STL, których nazwy typów są bardzo długie
#define VAR(v,n) typeof(n) v=(n)
// ALL(c) reprezentuje parę iteratorów wskazujących odpowiednio na pierwszy i
// za ostatni element w strukturach danych STL. Makro to jest bardzo przydatne
// chociażby w przypadku korzystania z funkcji sort, która jako parametry
// przyjmuje parę iteratorów reprezentujących przedział elementów do posortowania.
#define ALL(c) c.begin(),c.end()
// Poniższe makro służy do wyznaczania rozmiaru struktur danych STL. Używa się go
// x.size() jest typu unsigned int i podczas porównywania z typem int,
// w programach, zamiast pisać po prostu x.size() z uwagi na fakt, iż wyrażenie
// proces kompilacji generuje ostrzeżenie.
#define SIZE(x) (int)x.size()
// Bardzo pożyteczne makro, służące do iterowania po wszystkich elementach w
// strukturach danych STL.
#define FOREACH(i,c) for(VAR(i,(c).begin());i!=(c).end();++i)
// Skrót - zamiast pisać push back podczas wstawiania elementów na koniec
// struktury danych, takich jak vector, wystarczy napisać PB
#define PB push_back
// Podobnie - zamiast first będziemy pisali po prostu ST
#define ST first
// a zamiast second - ND.
#define ND second
