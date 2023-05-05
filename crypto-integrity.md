# Intégriter d'un fichier

CREE UNE CLE PRIVÉE
```
openssl genrsa -out <private-out> 2048
```

PERMET DE CREER CLE PUBLI GRACE A CLE PUBLIC
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

LE BINOME RECUPERE LES FICHIERS UTILIES :
FICHIER A RECUPERER POUR TESTER LES FICHIERS (<file>, <signature>, <public key>)
```
scp <user>@<ip>:/<repertoire> <mon_repertoire>
```

LE BINOME TEST LES FICHIERS POUR VOIR SI LES HASHS CORRESPONDENT
```
openssl dgdt -sha1 <file>
openssl rsault -verify -in <signature> -inkey <public key> -pubin
```

Si le hash correspond le fichier n'a pas été modifier sinon il à été modifier
