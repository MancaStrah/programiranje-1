###############################################################################
# Želimo definirati pivotiranje na mestu za tabelo [a]. Ker bi želeli
# pivotirati zgolj dele tabele, se omejimo na del tabele, ki se nahaja med
# indeksoma [start] in [end].
#
# Primer: za [start = 0] in [end = 8] tabelo
#
# [10, 4, 5, 15, 11, 2, 17, 0, 18]
#
# preuredimo v
#
# [0, 2, 5, 4, 10, 11, 17, 15, 18]
#
# (Možnih je več različnih rešitev, pomembno je, da je element 10 pivot.)
#
# Sestavi funkcijo [pivot(a, start, end)], ki preuredi tabelo [a] tako, da bo
# element [ a[start] ] postal pivot za del tabele med indeksoma [start] in
# [end]. Funkcija naj vrne indeks, na katerem je po preurejanju pristal pivot.
# Funkcija naj deluje v času O(n), kjer je n dolžina tabele [a].
#
# Primer:
#
#     >>> a = [10, 4, 5, 15, 11, 2, 17, 0, 18]
#     >>> pivot(a, 1, 7)
#     3
#     >>> a
#     [10, 2, 0, 4, 11, 15, 17, 5, 18]  

###############################################################################


# OK rešitev

def pivot(a, start, end):
    if start == end:
        return start
    p = a[start]
    prvi_vecji = start + 1
    for i in range (start + 1, end + 1):
        if a[i] < p:
            a[prvi_vecji], a[i] = a[i], a[prvi_vecji]
            prvi_vecji += 1
    a[start], a[prvi_vecji - 1] = a[prvi_vecji - 1], a[start]
    return prvi_vecji - 1




# Patetični poskus, ne deluje ok za dva elementa.
# Bomo enkrat mičken kasneje ugotovili, kje tiči problemček. 
# Ker je ura velik. 
def pivot1(a, start, end):
    if start == end:
        return start
    p = a[start]
    biggest = a[start + 1]
    m = 1
    for i in range(start, end + 1): 
        if a[i] <= p: 
            a[start + m] = a[i]
            a[i] = biggest 
            m += 1
            biggest = a[start+m]
            if i == end:
                a[start] = a[start + m - 1]
                a[start + m - 1] = p
        else:
            if i == end:
                a[start], a[start + m - 1] = a[start + m - 1], p
    return start + m - 1
            
b = [2,1]
a = [10, 4, 5, 15, 11, 2, 17, 0, 18]

### TO SMO NA VAJAH PRESKOČILI ################################################
###############################################################################
# V tabeli želimo poiskati vrednost k-tega elementa po velikosti.
#
# Primer: Če je
#
#     >>> a = [10, 4, 5, 15, 11, 3, 17, 2, 18]
#
# potem je tretji element po velikosti enak 5, ker so od njega manši elementi
#  2, 3 in 4. Pri tem štejemo indekse od 0 naprej, torej je "ničti" element 2.
#
# Sestavite funkcijo [kth_element(a, k)], ki v tabeli [a] poišče [k]-ti
# element po velikosti. Funkcija sme spremeniti tabelo [a]. Cilj naloge je, da
# jo rešite brez da v celoti uredite tabelo [a].
###############################################################################



###############################################################################
# Tabelo a želimo urediti z algoritmom hitrega urejanja (quicksort).
#
# Napišite funkcijo [quicksort(a)], ki uredi tabelo [a] s pomočjo pivotiranja.
# Poskrbi, da algoritem deluje 'na mestu', torej ne uporablja novih tabel.
#
# Namig: Definirajte pomožno funkcijo [quicksort_part(a, start, end)], ki
#        uredi zgolj del tabele [a].
#
#     >>> a = [10, 4, 5, 15, 11, 3, 17, 2, 18]
#     >>> quicksort(a)
#     [2, 3, 4, 5, 10, 11, 15, 17, 18]
###############################################################################


def quicksort(a):
    def quicky(start, end):
        if end - start <= 0:
            return
        p_index = pivot(a, start, end)
        quicky(start, p_index - 1)
        quicky(p_index + 1, end)
    quicky(0, len(a)-1)
    return




# Tudi quicksort2 se zdi, da dela ok. Ni pa eleganten. 
# Oziroma en korak preveč.

def quicksort_part(a, start, end):
    if end - start <= 0:

        return
    # if len(a) == 1:
        # return a
    else: 
        p_index = pivot(a, start, end)
        quicksort_part(a, start, p_index - 1)
        quicksort_part(a, p_index + 1, end)


def quicksort2(a):
    p_index = pivot(a, 0, len(a))
    quicksort_part(a, 0, p_index - 1)
    quicksort_part(a, p_index + 1, len(a))


import random
def test_quicksort(n, max_l, max_k):
    for _ in range(n):
        l = random.randint(0, max_l)
        a = [random.randint(-max_k, max_k) for _ in range(l)]
        a1 = a[:]
        a2 = a[:]
        quicksort(a1)
        a2.sort()
        if a1 != a2:
            print(a)
    return          


def test_quicksort2(n, max_l, max_k):
    for _ in range(n):
        l = random.randint(0, max_l)
        a = [random.randint(-max_k, max_k) for _ in range(l)]
        a1 = a[:]
        a2 = a[:]
        quicksort2(a1)
        a2.sort()
        if a1 != a2:
            print(a)
    return    


###############################################################################
# Če imamo dve urejeni tabeli, potem urejeno združeno tabelo dobimo tako, da
# urejeni tabeli zlijemo. Pri zlivanju vsakič vzamemo manjšega od začetnih
# elementov obeh tabel. Zaradi učinkovitosti ne ustvarjamo nove tabele, ampak
# rezultat zapisujemo v že pripravljeno tabelo (ustrezne dolžine).
# 
# Funkcija naj deluje v času O(n), kjer je n dolžina tarčne tabele.
# 
# Sestavite funkcijo [zlij(target, begin, end, list_1, list_2)], ki v del 
# tabele [target] med start in end zlije tabeli [list_1] in [list_2]. V primeru, 
# da sta elementa v obeh tabelah enaka, naj bo prvi element iz prve tabele.
# 
# Primer:
#  
#     >>> list_1 = [1,3,5,7,10]
#     >>> list_2 = [1,2,3,4,5,6,7]
#     >>> target = [-1 for _ in range(len(list_1) + len(list_2))]
#     >>> zlij(target, 0, len(target), list_1, list_2)
#     >>> target
#     [1,1,2,3,3,4,5,5,6,7,7,10]
#
###############################################################################

def zlij(target, begin, end, list_1, list_2):
    i1 = 0
    i2 = 0
    for j in range(begin, end + 1):
        i1_is_ok = i1 < len(list_1)
        i2_is_ok = i2 < len(list_2)
        if (not i2_is_ok and i1_is_ok) or (i1_is_ok and list_1[i1] <= list_2[i2]):
            target[j] = list_1[i1]
            i1 += 1
        elif i2_is_ok:
            target[j] = list_2[i2]
            i2 += 1
        else: 
            raise Exception("Lengths of lists are not sufficient")

# list_1 = [1,3,5,7,10]
# list_2 = [1,2,3,4,5,6,7]
# target = [-1 for _ in range(len(list_1) + len(list_2))]
# zlij(target, 0, len(target) - 1, list_1, list_2)
# target

###############################################################################
# Tabelo želimo urediti z zlivanjem (merge sort). 
# Tabelo razdelimo na polovici, ju rekurzivno uredimo in nato zlijemo z uporabo
# funkcije [zlij].
#
# Namig: prazna tabela in tabela z enim samim elementom sta vedno urejeni.
#
# Napišite funkcijo [mergesort(a)], ki uredi tabelo [a] s pomočjo zlivanja.
# Za razliko od hitrega urejanja tu tabele lahko kopirate, zlivanje pa je 
# potrebno narediti na mestu.
#
# >>> a = [10, 4, 5, 15, 11, 3, 17, 2, 18]
# >>> mergesort(a)
# [2, 3, 4, 5, 10, 11, 15, 17, 18]
###############################################################################

def mergesort(a):
    if len(a) <= 1:
        return
    half = len(a) // 2 
    a1 = a[:half]
    a2 = a[half:]
    mergesort(a1)
    mergesort(a2)
    zlij(a, 0, len(a) - 1, a1, a2)


def test_mergesort(n, max_l, max_k):
    for _ in range(n):
        l = random.randint(0, max_l)
        a = [random.randint(-max_k, max_k) for _ in range(l)]
        a1 = a[:]
        a2 = a[:]
        mergesort(a1)
        a2.sort()
        if a1 != a2:
            print(a)
    return 
