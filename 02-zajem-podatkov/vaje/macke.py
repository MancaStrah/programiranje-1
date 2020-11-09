# import csv
# import os
# import requests
# import re

# ###############################################################################
# # Najprej definirajmo nekaj pomožnih orodij za pridobivanje podatkov s spleta.
# ###############################################################################

# # definiratje URL glavne strani bolhe za oglase z mačkami
# cats_frontpage_url = 'http://www.bolha.com/zivali/male-zivali/macke/'
# # mapa, v katero bomo shranili podatke
# cat_directory = 'programiranje-1\\02-zajem-podatkov\\vaje'
# # ime datoteke v katero bomo shranili glavno stran
# frontpage_filename = 'bolha-frontpage.html'
# # ime CSV datoteke v katero bomo shranili podatke
# csv_filename = 'macke-podatki.csv'


# def download_url_to_string(url):
#     """Funkcija kot argument sprejme niz in puskuša vrniti vsebino te spletne
#     strani kot niz. V primeru, da med izvajanje pride do napake vrne None.
#     """
#     try:
#         # del kode, ki morda sproži napako
#         r = requests.get(url)
#         page_content = r.text
#     except ConnectionError:
#         # koda, ki se izvede pri napaki
#         # dovolj je če izpišemo opozorilo in prekinemo izvajanje funkcije
#         print('Neuspešen dostop do {}.'.format(url))
#         return None
#     # nadaljujemo s kodo če ni prišlo do napake
#     return page_content


# def save_string_to_file(text, directory, filename):
#     """Funkcija zapiše vrednost parametra "text" v novo ustvarjeno datoteko
#     locirano v "directory"/"filename", ali povozi obstoječo. V primeru, da je
#     niz "directory" prazen datoteko ustvari v trenutni mapi.
#     """
#     os.makedirs(directory, exist_ok=True)
#     path = os.path.join(directory, filename)
#     # path je sedaj polno ime datoteke
#     with open(path, 'w', encoding='utf-8') as file_out:
#         file_out.write(text)
#     return None


# # Definirajte funkcijo, ki prenese glavno stran in jo shrani v datoteko.


# def save_frontpage(page, directory, filename):
#     """Funkcija shrani vsebino spletne strani na naslovu "page" v datoteko
#     "directory"/"filename"."""
#     content = download_url_to_string(url)
#     save_string_to_file(content, directory, filename)


# ###############################################################################
# # Po pridobitvi podatkov jih želimo obdelati.
# ###############################################################################


# def read_file_to_string(directory, filename):
#     """Funkcija vrne celotno vsebino datoteke "directory"/"filename" kot niz"""
#     path = os.path.join(directory, filename)
#     with open(path, 'r', encoding='utf-8') as file_in:
#         content = file_in.read()
#     return content


# # Definirajte funkcijo, ki sprejme niz, ki predstavlja vsebino spletne strani,
# # in ga razdeli na dele, kjer vsak del predstavlja en oglas. To storite s
# # pomočjo regularnih izrazov, ki označujejo začetek in konec posameznega
# # oglasa. Funkcija naj vrne seznam nizov.


# def page_to_ads(page_content):
#     """Funkcija poišče posamezne oglase, ki se nahajajo v spletni strani in
#     vrne njih seznam"""

#     pattern = re.compile(r'<article.*?>(.*?)</article>', re.DOTALL)
#     oglasi = [m.group(1) for m in re.finditer(pattern, page_content)]


#     return oglasi


# # Definirajte funkcijo, ki sprejme niz, ki predstavlja oglas, in izlušči
# # podatke o imenu, ceni in opisu v oglasu.


# def get_dict_from_ad_block(block):
#     """Funkcija iz niza za posamezen oglasni blok izlušči podatke o imenu, ceni
#     in opisu ter vrne slovar, ki vsebuje ustrezne podatke
#     """
#     pattern = re.compile(r'<h3.*>(?P<ime>.*?)</a></<h3>'
#                         r'.*?Objavljen:.*?pubdate">(?P<datum>.*)</time', re.DOTALL)
    
    
   
#     match = re.search(pattern, block)
    
#     slovar = match.groupdict() if match is not None else None
#     return slovar
    

# # Definirajte funkcijo, ki sprejme ime in lokacijo datoteke, ki vsebuje
# # besedilo spletne strani, in vrne seznam slovarjev, ki vsebujejo podatke o
# # vseh oglasih strani.


# def ads_from_file(filename, directory):
#     """Funkcija prebere podatke v datoteki "directory"/"filename" in jih
#     pretvori (razčleni) v pripadajoč seznam slovarjev za vsak oglas posebej."""
#     content = read_file_to_string(directory, filename)
#     ads = page_to_ads(content)
#     dictionaries = [get_dict_from_ad_block(ad) for ad in ads]

#     return dictionaries


# ###############################################################################
# # Obdelane podatke želimo sedaj shraniti.
# ###############################################################################


# def write_csv(fieldnames, rows, directory, filename):
#     """
#     Funkcija v csv datoteko podano s parametroma "directory"/"filename" zapiše
#     vrednosti v parametru "rows" pripadajoče ključem podanim v "fieldnames"
#     """
#     os.makedirs(directory, exist_ok=True)
#     path = os.path.join(directory, filename)
#     with open(path, 'w', encoding='utf-8') as csv_file:
#         writer = csv.DictWriter(csv_file, fieldnames=fieldnames)
#         writer.writeheader()
#         for row in rows:
#             writer.writerow(row)
#     return


# # Definirajte funkcijo, ki sprejme neprazen seznam slovarjev, ki predstavljajo
# # podatke iz oglasa mačke, in zapiše vse podatke v csv datoteko. Imena za
# # stolpce [fieldnames] pridobite iz slovarjev.


# def write_cat_ads_to_csv(ads, directory, filename):
#     """Funkcija vse podatke iz parametra "ads" zapiše v csv datoteko podano s
#     parametroma "directory"/"filename". Funkcija predpostavi, da sa ključi vseh
#     sloverjev parametra ads enaki in je seznam ads neprazen.

#     """
#     # Stavek assert preveri da zahteva velja
#     # Če drži se program normalno izvaja, drugače pa sproži napako
#     # Prednost je v tem, da ga lahko pod določenimi pogoji izklopimo v
#     # produkcijskem okolju
#     assert ads and (all(j.keys() == ads[0].keys() for j in ads))
#     write_csv(ads[0].keys(), ads, directory, filename)
    


# # Celoten program poženemo v glavni funkciji

# def main(redownload=False, reparse=True):
#     """Funkcija izvede celoten del pridobivanja podatkov:
#     1. Oglase prenese iz bolhe
#     2. Lokalno html datoteko pretvori v lepšo predstavitev podatkov
#     3. Podatke shrani v csv datoteko
#     """
#     # Najprej v lokalno datoteko shranimo glavno stran
#     if redownload:
#         content = download_url_to_string(cats_frontpage_url)
#         save_string_to_file(content, cat_directory, frontpage_filename)

#     # Iz lokalne (html) datoteke preberemo podatke
#     page_Text = read_file_to_string(cat_directory, frontpage_filename)

#     # Podatke prebermo v lepšo obliko (seznam slovarjev)
#     if reparse:
#         ads = ads_from_file(frontpage_filename, cat_directory)

#         #Cleanup step:
#         ads = [ad for ad in ads if ad is not None]

#     # Podatke shranimo v csv datoteko
#         write_cat_ads_to_csv(ads, cat_directory, csv_filename)
#     # Dodatno: S pomočjo parameteov funkcije main omogoči nadzor, ali se
#     # celotna spletna stran ob vsakem zagon prense (četudi že obstaja)
#     # in enako za pretvorbo
#     return None

# # if dodamo, da se main zažene samo, če poženemo macke.py 
# if __name__ == '__main__':
#     main()

import requests
import re
import os
import csv

###############################################################################
# Najprej definirajmo nekaj pomožnih orodij za pridobivanje podatkov s spleta.
###############################################################################

# definirajte URL glavne strani bolhe za oglase z mačkami
cats_frontpage_url = 'http://www.bolha.com/zivali/male-zivali/macke/'
# mapa, v katero bomo shranili podatke
cat_directory = 'programiranje-1\\02-zajem-podatkov\\vaje'
# ime datoteke v katero bomo shranili glavno stran
frontpage_filename = 'index_macki.html'
# ime CSV datoteke v katero bomo shranili podatke
csv_filename = 'macki.csv'


def download_url_to_string(url):
    """Funkcija kot argument sprejme niz in poskusi vrniti vsebino te spletne
    strani kot niz. V primeru, da med izvajanje pride do napake vrne None.
    """
    try:
        # del kode, ki morda sproži napako
        r = requests.get(url)
    except requests.exceptions.ConnectionError:
        # koda, ki se izvede pri napaki
        # dovolj je če izpišemo opozorilo in prekinemo izvajanje funkcije
        print("Napaka pri povezovanju do:", url)
        return None
    # nadaljujemo s kodo če ni prišlo do napake
    if r.status_code == requests.codes.ok:
        return r.text
    else:
        print("Napaka pri prenosu strani:", url)
        return None


def save_string_to_file(text, directory, filename):
    """Funkcija zapiše vrednost parametra "text" v novo ustvarjeno datoteko
    locirano v "directory"/"filename", ali povozi obstoječo. V primeru, da je
    niz "directory" prazen datoteko ustvari v trenutni mapi.
    """
    os.makedirs(directory, exist_ok=True)
    path = os.path.join(directory, filename)
    with open(path, 'w', encoding='utf-8') as file_out:
        file_out.write(text)
    return None

# Definirajte funkcijo, ki prenese glavno stran in jo shrani v datoteko.


def save_frontpage(directory, filename):
    """Funkcija vrne celotno vsebino datoteke "directory"/"filename" kot niz"""
    text = download_url_to_string(cats_frontpage_url)
    save_string_to_file(text, directory, filename)
    return None

###############################################################################
# Po pridobitvi podatkov jih želimo obdelati.
###############################################################################


def read_file_to_string(directory, filename):
    """Funkcija vrne celotno vsebino datoteke "directory"/"filename" kot niz"""
    path = os.path.join(directory, filename)
    with open(path, 'r', encoding='utf-8') as file_in:
        return file_in.read()

# Definirajte funkcijo, ki sprejme niz, ki predstavlja vsebino spletne strani,
# in ga razdeli na dele, kjer vsak del predstavlja en oglas. To storite s
# pomočjo regularnih izrazov, ki označujejo začetek in konec posameznega
# oglasa. Funkcija naj vrne seznam nizov.


def page_to_ads(page_content):
    """Funkcija poišče posamezne oglase, ki se nahajajo v spletni strani in

    vrne njih seznam"""
    rx = re.compile(r'<li class="EntityList-item EntityList-item--Regular'
                    r'(.*?)</article>',
                    re.DOTALL)
    ads = re.findall(rx, page_content)
    return ads

# Definirajte funkcijo, ki sprejme niz, ki predstavlja oglas, in izlušči
# podatke o imenu, lokaciji, datumu objave in ceni v oglasu.


def get_dict_from_ad_block(block):

    """Funkcija iz niza za posamezen oglasni blok izlušči podatke o imenu,
    lokaciji, datumu objave in ceni ter vrne slovar, ki vsebuje ustrezne
    podatke"""
    rx = re.compile(r'<h3.*>(?P<name>.*?)</a></h3>'
                    r'.*?"pubdate">(?P<time>.*?)</time>'
                    r'.*?<strong class="price price--hrk">\s*?(?P<price>\d*)&',
                    re.DOTALL)
    data = re.search(rx, block)
    ad_dict = data.groupdict()

    # Ker nimajo vsi oglasi podatka o lokaciji, to rešimo z dodatnim vzorcem
    rloc = re.compile(r'Lokacija: </span>(?P<location>.*?)<br />')
    locdata = re.search(rloc, block)
    if locdata is not None:
        ad_dict['location'] = locdata.group('location')
    else:
        ad_dict['location'] = 'Unknown'

    return ad_dict

# Definirajte funkcijo, ki sprejme ime in lokacijo datoteke, ki vsebuje
# besedilo spletne strani, in vrne seznam slovarjev, ki vsebujejo podatke o
# vseh oglasih strani.


def ads_from_file(filename, directory):
    """Funkcija prebere podatke v datoteki "directory"/"filename" in jih
   pretvori (razčleni) v pripadajoč seznam slovarjev za vsak oglas posebej."""
    page = read_file_to_string(filename, directory)
    blocks = page_to_ads(page)
    ads = [get_dict_from_ad_block(block) for block in blocks]
    return ads


def ads_frontpage():
    return ads_from_file(cat_directory, frontpage_filename)

###############################################################################
# Obdelane podatke želimo sedaj shraniti.
###############################################################################


def write_csv(fieldnames, rows, directory, filename):
    """
    Funkcija v csv datoteko podano s parametroma "directory"/"filename" zapiše
    vrednosti v parametru "rows" pripadajoče ključem podanim v "fieldnames"
    """
    os.makedirs(directory, exist_ok=True)
    path = os.path.join(directory, filename)
    with open(path, 'w', encoding='utf-8') as csv_file:
        writer = csv.DictWriter(csv_file, fieldnames=fieldnames)
        writer.writeheader()
        for row in rows:
            writer.writerow(row)
    return None

# Definirajte funkcijo, ki sprejme neprazen seznam slovarjev, ki predstavljajo
# podatke iz oglasa mačke, in zapiše vse podatke v csv datoteko. Imena za
# stolpce [fieldnames] pridobite iz slovarjev.


def write_cat_ads_to_csv(ads, directory, filename):
    """Funkcija vse podatke iz parametra "ads" zapiše v csv datoteko podano s
    parametroma "directory"/"filename". Funkcija predpostavi, da so ključi vseh
    slovarjev parametra ads enaki in je seznam ads neprazen."""
    # Stavek assert preveri da zahteva velja
    # Če drži se program normalno izvaja, drugače pa sproži napako
    # Prednost je v tem, da ga lahko pod določenimi pogoji izklopimo v
    # produkcijskem okolju
    assert ads and (all(j.keys() == ads[0].keys() for j in ads))
    write_csv(ads[0].keys(), ads, directory, filename)


# Celoten program poženemo v glavni funkciji

def main(redownload=True, reparse=True):
    """Funkcija izvede celoten del pridobivanja podatkov:
    1. Oglase prenese iz bolhe
    2. Lokalno html datoteko pretvori v lepšo predstavitev podatkov
    3. Podatke shrani v csv datoteko
    """
    # Najprej v lokalno datoteko shranimo glavno stran


    save_frontpage(cat_directory, frontpage_filename)

    # Iz lokalne (html) datoteke preberemo podatke
    ads = page_to_ads(read_file_to_string(cat_directory, frontpage_filename))
    # Podatke preberemo v lepšo obliko (seznam slovarjev)
    ads_nice = [get_dict_from_ad_block(ad) for ad in ads]
    # Podatke shranimo v csv datoteko
    write_cat_ads_to_csv(ads_nice, cat_directory, csv_filename)

    # Dodatno: S pomočjo parametrov funkcije main omogoči nadzor, ali se
    # celotna spletna stran ob vsakem zagon prenese (četudi že obstaja)
    # in enako za pretvorbo


if __name__ == '__main__':
    main()