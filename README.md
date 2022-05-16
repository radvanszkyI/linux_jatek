# linux beadandó - játék

### Játék indítása:<br/>
A játék Linux operációs rendszeren indítható a "harcolosJatek.sh" szkripttel.<br/>
Azonban az összes többi fájl is szükséges. A megfelelő működéshez mindent másoljon ugyan abba a mappába. A játék angolul kommunikál a felhasználóval.<br/>
A harcolosJatek.sh indítása után begépelheti a monogramját vagy csak egyszerűen nyomjon ENTER-t.
Ezután elindul maga a játék.

### Játék menete:<br/>
A játék a sárga (falak színe) színnel jelölt térképen zajlik.<br/>
A monogramként megadott hős kék színnel van jelölve. A hős aktuális adatai a pályától balra jelennek meg. <br/>
Ezek rendre a következők: Name (a hősmonogramja) Moves (az eddig megtett lépések száma) HP (életerő pontok száma, mely a megjelenő szív karakterek számával egyenlő)<br/>
A hőst a WASD billentyűkel lehet mozogatni (rendre: fel, balra, le, jobbra) olyan helyekre ahol nincsen fal. (A falak színe sárga.)<br/>
A pályán véletlenszerűen generált szörnyek találhatók melyek piros háttérrel, egy nagy ’M’-el és a rájuk jellemző életerő számmal vannak jelölve.<br/>
Ha a hős közvetlen közelébe (alatta, felette vagy mellette) szörny kerül, akkor harcra kerül a sor.
Ez alól kivételt képez a legelső lépés, amikor még el lehet távolodni a szörnyek mellől.<br/>
A harcban az nyer, akinek nagyobb az életereje. Ha több szörny veszi körbe a hőst, azok életereje összegezve számit.
Amennyiben a hős alulmarad, az életerőpontok tekintetében, a hős meghal és a játék véget ér. 
Azonban ha sikerül életben maradnia, minden legyőzött szörny után, egy plusz életerő pontot kap.
Ha a hős és a szörny életereje megegyezik, a hős nyer, mert ő ügyesebb.<br/>
Ha a pályán nem maradt több szörny, akkor a játékos nyert és a játék véget ér.<br/><br/>
### Utasítások
A játék alatt, a mozgáshoz használt 4 billentyűn kívül, további **4 utasítás** adható ki melyekhez tartozó billentyű a pálya feletti menüben található (K: mentés, L: betöltés, Q: kilépés, H: súgó).<br/>
Az utasítások a következők szerint működnek:<br/>
**Mentés:** elmenti a játék állapotát, de felülírja az előző mentést.<br/>
**Betöltés:** betölti az előzőekben mentett játék (ha van ilyen) állapotát és felülírja a jelenlegit.<br/>
**Kilépés:** kilép a játékból, de még van lehetőség menteni is<br/>
**Súgó:** megjeleníti vagy elrejti a súgót<br/>
