# MT19937 in COBOL

Implementation of MT19937 in COBOL. This is a toy project meant for learning. Please don't use for serious business.

## Compilation

Should compile fine using cobc (GnuCOBOL) 3.2.

```shell
$ cobc -x mt19937.cob
```

## Usage

The seed (default=5489) and number of values to generate (default=10) can be set using the `SEED` and `N` environment variables respectively.

```shell
$ ./mt19937

MT19937 (Seed: 5489)
Generating 10 values

5CBB91D0 : 3499211612
F69EAE22 : 581869302
ECEBE9A3 : 2750016492
7B0ECB91 : 2446003835
2C358220 : 545404204
DFB707F8 : 4161255391
0500D3E9 : 3922919429
E3BE9D7C : 2090712803
BA4BE2A1 : 2715962298
2B09E44E : 1323567403

$ SEED=1337 N=5 ./mt19937

MT19937 (Seed: 1337)
Generating 5 values

970C1443 : 1125387415
BDE07E8F : 2407456957
5E92976C : 1821872734
E8246C36 : 913057000
A74C3347 : 1194544295
```