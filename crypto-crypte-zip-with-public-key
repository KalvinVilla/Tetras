# Chiffrer gros fichier

#PRE REQUIS
CELUI QUI RECOIT LE FICHIER CHIFFRER DOIT AVOIR GENERER UNE CLE PRIVEE ET UNE CLE PUBLIQUE
```
openssl genrsa -out <private key> 2048
openssl rsa -in <private key> -pubout -out <public key> 
```


# CHIFFRER

FICHIER A RECUPERER POUR CHIFFRER (<public_key du binome>)
CETTE CLE EST OBLIGATOIRE POUR CHIFFRER ET QUE VOTRE BINOME PUISSE DECHIFFRER  
```
scp <user>@<ip>:/<repertoire>/<public key> <mon_repertoire>
```


```
echo "password" > <password_file> 
```

CHIFFRER LE FICHIER
```
openssl enc -aes-256-cbc -in <file>.pdf -out <crypted_file> -kfile <password_file> -pbkdf2 
```

CHIFFRE LE MOT DE PASSE
```
openssl rsautl -in password -out <crypted_password> -inkey <public key> -pubin -encrypt
```

# DECHIFFRER 
FICHIER A RECUPERER POUR TESTER LES FICHIERS (<crypted_file, crypted_password>)
```
scp <user>@<ip>:/<repertoire> <mon_repertoire>
```

DECHIFFRER LE MOT DE PASSE AVEC VOTRE CLE PRIVEE 
```
openssl rsault -in <private_password> -out <password_2> -inkey -<private key> -decrypt
```

DECHIFFRER LE FICHIER AVEC LE MOT DE PASSE 
```
openssl enc -aes-256-cbc -in <crypted_file> -out <file_2> -kfile <password_2> -d -pbkdf2
```

Le fichier file est déchiffrer.
