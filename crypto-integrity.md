# Intégriter d'un fichier

CREE UNE CLE PRIVÉE
```
openssl genrsa -out <private-out> 2048
```

PERMET DE CREER CLE PUBLIC GRACE A CLE PRIVE
```
openssl rsa -in <private key> -pubout -out <public key> 
```

PERMET DE CREER UN FICHIER
```
echo coucou > <file>
```

PERMET DE CREER UNE EMPREINTE QUI SERA UTILISER DANS LA SIGNATURE
```
openssl dgst -sha1 <file> > <empreint>
```

ON SIGN POUR VERIFIER L INTEGRITE DU FICHIER A L INSTANT T
```
openssl rsautl -sign -out <signature> -in <empreint> -inkey <private key> 
```

**A PARTIR DE LA SI ON MODIFIE LE FICHIER L'INTEGRITE NE SERAT PLUS BONNE DONC LES HASHS SERONT DIFFERENT**

LE BINOME RECUPERE LES FICHIERS UTILES :
FICHIER A RECUPERER POUR TESTER LES FICHIERS (<file>, <signature>, <public key>)
```
scp <user>@<ip>:/<repertoire> <mon_repertoire>
```

LE BINOME TEST LES FICHIERS POUR VOIR SI LES HASHS CORRESPONDENT:
  
PERMET DE CALCULER LA VALEUR DU HACHAGE DU FICHIER SHA1
```
openssl dgdt -sha1 <file>
```

PERMET DE VERIFIER SI LA SIGNATURE A CHANGER ET DONC SI LE FICHIER A ETE MODIFIER
```
openssl rsautl -verify -in <signature> -inkey <public key> -pubin
```

  
Si le hash correspond le fichier n'a pas été modifier sinon il à été modifier
