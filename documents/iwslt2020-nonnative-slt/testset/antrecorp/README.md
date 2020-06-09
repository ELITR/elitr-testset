# Antrecorp translated for SLT purposes

Antrecorp files 01 and 02 serve in devset.

## Comments on .OS

"OS" denotes original speech.

The speech was recorded in very noisy conditions
with head microphones. One of the head microphones was unfortunately
misfunctioning, so one of the speakers in the pair is often too quiet.

The original recording format was wav, e.g.:

```
Input File     : '01_teddy.wav'
Channels       : 2
Sample Rate    : 44100
Precision      : 16-bit
Duration       : 00:01:15.07 = 3310400 samples = 5629.93 CDDA sectors
File Size      : 13.2M
Bit Rate       : 1.41M
Sample Encoding: 16-bit Signed Integer PCM
```

We converted the wav files to AAC, so that they would fit into github repositories.


## Overview of Linecounts

As the table indicates, TTde does not always perfectly match. This needs to be
fixed. Also the files which *do* match should be checked.

```
                          OSt TTcs1 TTcs2 TTde TTcs3
01_teddy                  11  11    11    12   -
02_autocentrum-oa         12  12    12    12   -
03_botel-proti-proudu     25  25    25    25   -
04_g-t                    15  15    15    15   -
05_i-dodge                27  27    27    27   -
06_masaze-petr-klic       14  14    14    17   -
07_bucherinsel-west       12  12    12    13   -
08_jizeran                10  10    10    10   -
09_il-gabbiano            21  21    21    17   -
10_magic-travel           17  17    17    15   -
11_trefa                  18  18    18    18   -
12_fictionalcine          8   8     8     10   -
13_don-bosco-barcelona    12  12    12    14   -
14_llibres-i-revistes-edb 21  21    21    20   -
15_brnkni                 18  18    18    24   -
16_develop-most           12  12    12    14   -
17_tf-smart-team          17  17    17    17   -
18_tf-magic-world         14  14    14    13   -
19_be-beauty              11  11    11    20   -
20_mela-e-piu             13  13    13    12   13
21_hat-cap                21  21    21    18   -
22_new-design-world       22  22    22    21   -
23_pillowdream            20  20    20    12   -
24_mole-g-p-technologies  14  14    14    17   -
25_folkstyle              12  12    12    12   -
26_tabacco-shop           7   7     7     10   -
27_f-e-international-tour 11  11    11    17   -
28_samanka                10  10    10    10   -
29_salon-n-g              16  16    16    17   -
30_appolonas              9   9     9     8    -
31_devil-chocolate        13  13    13    14   -
32_ck-remoa               18  18    18    19   -
33_logistic-servis        10  10    10    14   -
34_kol_action_accessoires 15  15    15    14   -
35_f-e-time-travel-agency 13  13    13    14   -
36_step-house             12  12    12    13   -
37_caspowalk              35  35    35    34   -
38_seta                   12  12    12    12   -
39_total-regal            16  16    16    17   -
```



## Comments to .OSt

OSt are the transcripts.

Compared to the released version of Antrecorp, we added special tags to indicate where the recordings was censored to avoid releasing real person names and real city names. The names of the ficious companies were preserved.

when removing named entities, specifically:

```
<NAME> ... person's real name
<CITY> ... person's real city
```

The recordings are **cut** at these positions, i.e. the speech is a little non-naturally shortened there.

The total number of occurrences of these special tags is low, 27 occurrences on 24 lines out of 594 total lines.

## Comments to .TTde

TTde is the German translation of OSt. It was constructed with access to the OSt, OS (the sound; but we are not sure how much was that used) and also to the Czech translations (below), but we expect these were not used at all.

Unfortunately, the German translation came without preserving linebreaks, so we had to recreate it.

## Comments to .TTcs1

TTcs1 is the first version of translation into Czech.

Here are notes from the translator:

název podniku			<FIRMA>
adresa firmy			<ADRESA>

Nepřekládám názvy firem.
Většinou nepoznám z textu gender mluvčího.
Data píši ve formě: 1. ledna 2000.
Občas měním interpunkci, aby byla 


V místech, kde se mluvčí nedrží předepsaného textu, toho tlumočník řekne tak o čtvrtinu méně, protože ho napadají lepší formulace a protože je tlačen časem.
(Musela jsem se jako překladatel hodně krotit, abych neopravovala chyby, které jsem si mohla ověřit na internetu.)
Jako tlumočník bych se vyvarovala opakování nedořečených vět. Buď bych mlčela, dokud by mluvčí neřekl celou větu, nebo bych pak začátek neopakovala znovu.
„Doprčic“ apod. by tlumočník nikdy nezopakoval, vynechávám.

Pokus o rekonstrukci přemýšlení tlumočníka:
„According to customers according to customer regards... rega... requirements we are able to create the application that suits everyone.“
Tlumočník spustí v půlce věty: „Na základě požadavků zákazníka můžeme vyrobit aplikaci,...“ Nemůže však dokončit: „která bude vhodná pro každého“, protože to v češtině nedává smysl (-každému zákazníkovi právě vyhovuje jiná aplikace). Takže to opíše něčím, co se původnímu textu moc nepodobá. Například: „... tak aby mu dokonale vyhovovala.“ To se pak samozřejmě nebude shodovat s překladačem, ačkoli nevím, jak ten to bude řešit. (Asi tu mírnou logickou nesmyslnost přehlédne.)

Shrnuto a podtrženo, chtělo by to zápis skutečného tlumočení nebo alespoň překlad z rukou tlumočníka, který se bude snažit vžít do situace, kdy simultánně tlumočí.


(Pozor, názvy souborů 16 a 17 jsou zpřeházené.)


2
- moc nechápu 
  - meaningful connections
  - smysluplných kontaktů

6
- vynechávám „doprčic“

9
- nechávám dva volné řádky namísto:
  - I'm.
  - I'm.

14
- předpokládám, že je třeba doplnit <FIRMA> do věty:
  - Do you know about the company <FIRMA>...
  - Znáte firmu <FIRMA>?
- nepochopila jsem větu:
  - Well, we sell books, magazines, events like Oktoberfest, Tomorrowland, that they are so popular.
  - Prodáváme knihy, časopisy, akce, jako je Oktoberfest, Tomorrowland, které jsou tak populární.

15
- nepochopila jsem roli druhého mluvčího
- nevím, zda se na konci loučit za jednoho či za dva mluvčí („Přeji Vám.../Přejeme Vám...“)

16
- ne vždy jsem pochopila, co chtěl mluvčí říct
- ponechávám chybný pravopis:
  - Vysoké školy ekonomické Mariy Teiulenu (správně TeiuleAnu)
- promote the tourist potential
  - podporovat turistický potenciál (správnější by však bylo „vytěžit turistický potenciál“)
- „The Canyon of The Seven Stairs“ – chyba a nepřeložitelné, vyhledala jsem si původní název

17
- poslední věta: „Rádi kdykoliv zodpovíme vaše dotazy.“ – snažím se víc držet textu, jinak bych tam ale dala spíš: „Rádi zodpovíme jakékoliv dotazy.“ nebo „Pokud máte jakékoliv dotazy, rádi je zodpovíme.“
  - problém idiomů, vžitých frází apod. – ve více příspěvcích

19
- nepochopila jsem jedno místo v textu:
- The company was founded on the fifteen of May in twenty seventeen. **The... and** it was taken over by Mrs. on the first of ...

22
- bohužel nechápu dvě místa:
  - This **train serving** is so exhausting.
  - To obsluhování ve vlaku je tak vyčerpávající.
  - ... and so, we want to offer our sophisticated products, and **utterances of users**.
  - A tak bychom rádi nabídli své sofistikované produkty. (vynechávám, nevím, co to znamená)

23
- několik možných výkladů:
  - As a matter of fact, we got all people need to sleep well.
  - Ve skutečnosti se každý potřebuje dobře vyspat.

29
- nesouvislý text: 
- Hello, it seems to me that we have already met before, we might have visited the same college few years ago. 
  **I'm, and you?**
  **I'm**, what do you do for a living?
- Dobrý den, mám pocit, že už jsme se někdy potkali, možná jsme před pár lety chodili na stejnou školu.
  Ano, a vy?
  Ano, čím se teď živíte?
- „EO“ – předpokládám, že je to překlep „CEO“

33
- hodně kryptické, možná vynechat, trochu jsem v překladu bájila

34
- nesmyslné:
- Our collection is meant for men, women, young and old **who ever want to know accessory**.
- Naše kolekce je určená pro muže, ženy, mladé a staré, kdokoliv touží po tom vlastnit doplňky.

38
- nepochopila:
- It's important to notice that we also grant **trade discounts only the trade**, but also quantity discounts for orders over thirty products.
- Je důležité poznamenat, že máme také množstevní slevy na objednávky nad třicet produktů.

39
- asi chyba:
- But we actually might **crack up** our traditional clothes at some of the countless parties that we have, to have one beer or something.
- Popravdě se ale může stát, že vytáhneme tradiční oblečení při jedné z nespočetných party, které pořádáme, abychom si dali jedno pivo nebo tak.


## Comments to .TTcs2 and .TTcs3

An alternative translation into Czech.

Comments from the translator:

- U souborů, kde nešlo vyčíst z kontextu, je zvoleno generické maskulinum. Většina dialogů je pojatá jako rozhovor muže a ženy (pokud z kontextu nešlo vyčíst jinak).
- U souborů, kde v textu nebyly indikace neformálního jazyka, jsem volila formální registr (spisovný, neutrální jazyk a vykání).
- Přeřeky, opakování a gramatické chyby jsou z překladu vypuštěny, pokud nenarušují strukturu (počet řádků apod.).
- České výrazy obsažené v anglických textech jsou zachovány.
- Cizojazyčné fráze a slovní spojení zůstaly beze změny.
- Anglické názvy výrobků a jména firem zůstaly beze změny.
- Problémy:
  - 20. Mela e Piu: Prezentace je podaná formou rýmované písně, proto nabízím dva překlady, z nichž jeden rým zachovává. (``20_mela-e-piu.TTcs3``)
  - 38. SETA: Nešel zachovat akronym SETA.

