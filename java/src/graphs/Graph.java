package graph;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

/**
 * Author: Maciej Grochowski
 * Contact: mgrochowski@ubirds.eu
 * Date: 11/8/13
 * Time: 3:28 PM
 * <p/>
 * This code is a uBirds company property.
 */

/**
 * @param <V> vertex class
 * @param <E>  edge class
 */
public class Graph <V, E> {

    public Graph(int n){
        g = new ArrayList<Ve>();
        for(int i=0; i<n; i++) {
            g.add(new Ve());
        }
    }

    //Wektor wierzchołków w grafie
    private List<Ve> g;

    /**
     * Funkcja dodająca do grafu nową krawędź nieskierowaną, łączącą wierzchołki b i e oraz zawierająca dodatkowe
     * informację przekazywane przez zmienną d.
     * Krawędź nieskierowana jest reprezentowana przez dwie krawędzie skierowane - jedną prowadzącą z wierzchołka b do e
     * oraz drugą  z e do b.
     * @param b
     * @param e
     * @param d
     */
    public void EdgeU(int b, int e, E d){
        //System.out.println("@Debug: tworze krawedz b, e: " + b + " " + e);
        Ed eg = new Ed(d, e);

        int be = 0;
        if(b == e) be = 1;
        eg.setRev(g.get(e).getEdVector().size()+be);
        Ve newVe = g.get(b);
        List<Ed> newListEd = newVe.getEdVector();
        newListEd.add(eg);
        newVe.setVector(newListEd);

        g.set(b, newVe);

        Ed eg2 = new Ed(d, b);
        eg2.setRev(g.get(b).getEdVector().size()-1);

        newVe = g.get(e);
        newListEd = newVe.getEdVector();
        newListEd.add(eg2);
        newVe.setVector(newListEd);
        g.set(e, newVe);

    }

    /**
     * Funkcja dodająca do grafu nową krawędź skierowaną z wierzchołka b do e,
     * zawierającą dodatkowe informacje określone przez zmienną d.
     */
    public void EdgeD(int b, int e, E d) {
        Ve test = g.get(b);
        test.getEdVector().add(new Ed(d, e));
    }

    public void write(){
       for(int x=0; x<g.size(); x++){
           System.out.print(x+ ": ") ;
           List<Ed> edgesFromX = g.get(x).getEdVector();
           for(Ed ed : edgesFromX){
               System.out.print(ed.getV() + " ") ;
           }
           System.out.println(" ");
       }
    }

    public void bfs(int s) {
        // Dla kazdego wierzcholka w grafie ustawiana jest poczatkowa wartosc zmiennych
        // t oraz s na -1. zrodlo wyszukiwania ma czas rowny 0
        for(Ve vertex : g){
            vertex.setS(-1);
            vertex.setT(-1);
        }
        Ve vs = g.get(s);
        vs.setT(0);
        g.set(s, vs);

        // Algorytm BFS jest realizowany przy uzyciu kolejki FIFO, do ktorej wstawiane
        // sa kolejne wierzcholki oczekujace na przetworzenie
        int qu[] = new int[g.size()];
        int b = 0, e = 0;
        // Do kolejki wstawione zostaje zrodlo
        qu[0] = s;
        // Dopoki w kolejce sa jakies wierzcholki...
        while(b<=e) {
            s=qu[b++];
            // Dla kazdej krawedzi wychodzacej z aktualnie przetwarzanego wierzcholka,
            // jesli wierzcholek, do ktorego ona prowadzi, nie byl jeszcze wstawiony do
            // kolejki, wstaw go i wyznacz wartosci zmiennych int t i int s

            for(Ed edgesFromGs : g.get(s).getEdVector()){
                if(g.get(edgesFromGs.getV()).getT() == -1){
                   qu[++e]=edgesFromGs.getV();
                   Ve clipboard = g.get(qu[e]);
                   clipboard.setT(g.get(s).getT()+1);
                   clipboard.setS(s);
                   g.set(qu[e], clipboard);
                }
            }
        }
    }

    public void writeBfs(){
        //Wypisz wynik bfs
        int index = 0;
        for(Ve vertex : g){
            System.out.print("Wierzcholek " + index + " : czas = " + vertex.getT() + " , ojciec w drzewie BFS = " + vertex.getS());
            System.out.println(" ");
            index++;
        }
    }

    /**
     * Przeszukiwanie grafu w głąb:
     * Aktualizuje dany graf o czas wejścia czas wyjścia i numer ojca w lesie dsf
     *
     * @param e numer wierzchołka od którego rozpoczynamy algorytm dsf
     */
    public void dsf(Integer e){
        List<Integer> st = new ArrayList<Integer>(g.size());
        for(int i=0; i<g.size(); i++){
            st.add(0);
        }


        int t = -1 , i = 0, b = 0;

        if(e == null || e < 0){
            e = g.size() - 1;
        } else {
            b = e;
        }

        for(Ve ve : g){
            ve.d = ve.f = ve.s = -1;
        }

        // Dla wszystkich wierzcholkow z przedzialu [b..e], jesli wierzcholek nie byl
        // jeszcze odwiedzony...
        for(int s = b; s <= (e); ++s){
            // Wstaw wierzcholek na stos i ustaw dla niego odpowiedni czas wejscia.
            // Zmienna f wierzcholka sluzy tymczasowo jako licznik nieprzetworzonych
            // krawedzi wychodzacych z wierzcholka
            //System.out.print("##s = " + s + " i = " + i + " g.size() = " + g.size() + " st.size() = " + st.size());
            st.set(i++, s);
            g.get(s).d = ++t;
            g.get(s).f = g.get(s).getEdVector().size();
            // Dopoki stos jest niepusty...
            while(i > 0){
                System.out.print(  "##st print size=" + st.size() );
//                for (Integer item : st)
//                    System.out.print("##item st = " + item);

                System.out.println("##i = " + i);
                int ss = st.get(i-1);
                // Przetworz kolejna krawedz wychodzaca z biezacego wierzcholka lub usun go
                // ze stosu (gdy nie ma juz wiecej krawedzi)
                if (g.get(ss).f == 0){
                    g.get(ss).f = ++t;
                    --i;
                } else {
                // Jesli wierzcholek, do ktorego prowadzi krawedz, nie byl jeszcze odwiedzony, to...
                    //g[s = g[s][--g[s].f].v].d
                    System.out.println("## ss= " + ss);
                    int newS = g.get(ss).getEdVector().get(g.get(ss).f - 1).getV();
                    --g.get(ss).f;
                    ss = newS;
                    if (g.get(ss).d == -1) {
                        // Ustaw numer wierzcholka-ojca w drzewie DFS oraz ustaw liczbe nieprzetworzonych
                        // krawedzi wychodzacych z wierzcholka
                        g.get(ss).s = st.get(i-1);     //nowy stary :) w sensie ze nowy ojciec w dfs
                        g.get(ss).f = g.get(ss).getEdVector().size();   //nowa zmienna wyjścia z węzła która okresla ile trzeba nodów przerobic
                        // Wstaw wierzcholek na stos i ustaw czas wejscia
                        g.get(ss).d = t;
                        t++;
                        st.set(i, ss);
                        i++;
                    }

                }
            }
        }

    }

    public void writeDsf(){
        int i = 0;
        for(Ve ve : g){
          System.out.println("Wierzcholek " + i++ +": czas wejscia = "
                  + ve.d + ", czas wyjscia = " + ve.f +", ojciec w lesie DFS = " + ve.s);
        }
    }

}


/**
 * Klasa reprezentująca krawędź wychodzącą z danego wierzchołka.
 */
class Ed  {

    public Ed(Object E, int w){
        e = E;
        v = w;
    }

    private Object e;
    private Integer v;
    private Integer rev;

    Object getE() {
        return e;
    }

    void setE(Object e) {
        this.e = e;
    }

    /**
     * @return wierzchołek do którego prowadzi dana krawędź
     */
    Integer getV() {
        return v;
    }

    void setV(Integer v) {
        this.v = v;
    }

    Integer getRev() {
        return rev;
    }

    void setRev(Integer rev) {
        this.rev = rev;
    }
}

/**
 * Klasa reprezentująca wierzchołki w grafie.
 * Wierzchołek skłąda się z numeru i krawędzi do których można się z niego dostać.
 */
class Ve {

    public Ve(){
        vector = new ArrayList<Ed>();
    }

    private Object v;
    private List<Ed> vector;
    public int s;
    private int t;
    public int d;
    public int f;

    Object getV() {
        return v;
    }

    void setV(Object v) {
        this.v = v;
    }

    List<Ed> getEdVector() {
        return vector;
    }

    void setVector(List<Ed> vector) {
        this.vector = vector;
    }

    /**
     * @return ojciec w drzewie przeszukiwania
     */
    int getS() {
        return s;
    }

    void setS(int s) {
        this.s = s;
    }

    /**
     * @return odległość od wierzchołka przeszukiwania.
     */
    int getT() {
        return t;
    }

    void setT(int t) {
        this.t = t;
    }

    int getD() {
        return d;
    }

    void setD(int d) {
        this.d = d;
    }
}

