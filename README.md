# linux beadandó - játék

### Játék indítása:<br/>
A játék Linux operációs rendszereken, parancssorból indítható, a **"harcolosJatek.sh"** szkripttel.<br/>
Azonban a megfelelő működéshez, a repository-ban található összes többi fájl (kivéve a "README.md") is szükséges. Minden fájlt ugyanabba a mappába helyezzen el. A játék angolul kommunikál a felhasználóval.<br/>
A harcolosJatek.sh indítása után begépelheti a monogramját vagy csak egyszerűen nyomjon ENTER-t.
Ezután elindul maga a játék.

### Játék menete:<br/>
A játék a sárga színnel jelölt, téglalap alakú térképen (későbbiekben pálya) zajlik.<br/>
A monogramként megadott hős kék színnel van jelölve. A hős aktuális adatai a pályától balra jelennek meg. <br/>
Ezek rendre a következők: Name (a hős monogramja), Moves (az eddig megtett lépések száma), HP (az életerő pontok száma, mely a megjelenő szív karakterek számával egyenlő)<br/>
A hőst a WASD billentyűkel lehet mozogatni egy-egy egységnyit, bármely irányba (renred: fel, balra, le, jobbra) olyan helyekre ahol nincsen fal. (A falak színe sárga.)<br/>
A pályán véletlenszerűen generált szörnyek találhatók melyek piros háttérrel, egy nagy ’M’-el és a rájuk jellemző életerő számmal vannak jelölve.<br/>
Ha a hős közvetlen közelében (alatta, felette vagy mellette) szörny van, akkor harcra kerül a sor.
Ez alól kivételt képez a legelső lépés, amikor még el lehet távolodni a szörnyek mellől.<br/>
A harcban az nyer, akinek nagyobb az életereje. Ha több szörny veszi körbe a hőst, azok életereje összegezve számit.
Amennyiben a hős alulmarad, az életerőpontok tekintetében, a hős meghal és a játék véget ér. 
Azonban ha sikerül életben maradnia, minden legyőzött szörny után, egy plusz életerő pontot kap.
Ha a hős és a szörny életereje megegyezik, a hős nyer, mert ő ügyesebb.<br/>
Ha a pályán nem maradt több szörny, akkor a játékos nyert és a játék véget ér.<br/><br/>
### Utasítások
A játék alatt, a mozgáshoz használt 4 billentyűn kívül, további **4 utasítás** adható ki, melyekhez tartozó billentyűk a pálya feletti menüben találhatók (K: mentés, L: betöltés, Q: kilépés, H: súgó).<br/>
Az utasítások a következők szerint működnek:<br/>
**Mentés:** elmenti a játék állapotát, de felülírja az előző mentést.<br/>
**Betöltés:** betölti az előzőekben mentett játék (ha van ilyen) állapotát és felülírja a jelenlegit.<br/>
**Kilépés:** kilép a játékból, de még van lehetőség menteni is<br/>
**Súgó:** megjeleníti vagy elrejti a súgót<br/>
### Kommunikáció a felhasználóval
A pálya alatt vannak elhelyezve a felhasználó tájékoztatását szolgáló üzenetek, illetve a parancs billentyűk hatása megjelenő, eldöntendő kérdések. Az utóbbiakra Y (igen) és N (nem) billentyűkel lehet válaszolni.
