# SI - Christmas Tree
Toate fisierele de interes pentru tema sunt explicate mai jos. Imaginea
generata folosind utilitarul *bitbake* este `rpi-xmas-tree-raspberry.ext3`.
Aceasta a fost creata plecand de la imaginea creata la laboratorul 6,
`rpi-basic-image`


## Accesarea si rularea imaginii
Pentru a rula imaginea de *QEMU* creata, se poate folosi scriptul `launch.sh`.
Credentialele folosite atat pentru login cat si pentru a accesa imaginea prin
*SSH* (`ssh root@tema2.local`) sunt urmatoarele:
```
utilizator: root
parola: labsi
```


## Interfata web
Pagina web poate fi accesata la URL-ul `tema2.local/index.html`. Fisierul
`index.html` este prezent in arhiva temei. Interfata ofera utilizatorilor
instructiuni de interactiune cu aplicatia si contine 2 butoane. Unul este
folosit pentru incarcarea unui fisier text, care va fi folosit pentru a genera
scrie un brad de Craciun in terminalul din *QEMU*, iar celalalt face sa se
apeleze scriptul care genereaza bradul antementionat.

Interfata web a fost implementata plecand de la reteta din
`poky/meta/recipes-extended/lighttpd`. Astfel, din fisierul `.bbappend` se
instaleaza fisierul `index.html` mentionat mai sus, precum si configuratia
serverului de *lighttpd*. Din moment ce imaginea *rpi-basic-image* contine deja
un server *SSH*, nu a mai fost nevoie ca acesta sa fie instalat separat.


## Generarea bradului
Bradul este scris la `/dev/tty0` de catre scriptul `display_tree.py`, care 
citeste structura acestuia din fisierul `tree_file.txt`. Daca acest fisier este
gasit de script, pe pagina web se afiseaza un indiciu care trimite utilizatorul
sa se uite in terminalul din *QEMU*. In caz contrar, adica atunci cand
utilizatorul nu incarca un fisier text cu structura bradului, pagina web
afiseaza un mesaj care explica faptul ca utilizatorul nu a incarcat un fisier.


## Implementare
Am adaugat urmatoarele module in fisierul `build/conf/local.conf`:
```
python-modules
lighttpd
avahi-daemon
dhcp-server
dhcp-client
dhcp-omshell
dhcp-relay
dhcp-server-config
```
