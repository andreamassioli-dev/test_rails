# README

## Setup:

```bash
bundle install
yarn install

rails db:create db:migrate
rails db:seed
```

Per avviare il server:
```bash
rails server
bin/webpack-dev-server
```

Per avviare i test:

```bash
bundle exec rspec
```

### Compiti:

a) L'api corrente /api/posts ha un problema di performance molto comune. Qual è? Come si potrebbe risolvere?

b) Implementare una nuova API nel PostsController che, ricevendo in GET un parametro "term" permetta di cercare per nome e per tag i post.

Ad esempio, cercando "gatto", verrà trovato un post che contiene la parola gatto o che ha almeno un tag che si chiama "gatto".

Per l'implementazione, utilizzare l'approccio "TDD". Per farla semplice, implementa semplicemente un test nella cartella spec/requests similare a quello già fatto per l'index

c) Implementare in Vue un'input form, modificando il componente app.vue, che permetta di filtrare i post utilizzando l'API creata precedentemente.

### Risposte:

Nota preliminare: il corso che sto seguendo usa Rails 7 e mi sono installato in locale tutte le dipendenze del caso. Per evitare casini ho configurato un docker seguendo questa guida: https://docs.docker.com/samples/rails/ . Ho dovuto anche modificare la versione di ruby nel Gemfile a 2.7.5 perché il bundler non trovava alcune dipendenze con versioni compatibili. Infine, ammetto candidamente che per risolvere i problemi ho fatto ricorso a ricerche online, dato che mi sto ancora formando su Rails e che qui si usano Rails 5 ed Rspec, che non fanno parte del corso che seguo. D'altro canto ci tenevo a dare un risultato entro oggi :)
In ogni caso ho svolto tutto in un unico commit, quindi puoi vedere tutte le modifiche in un colpo solo.

a) oltre alla query per il post viene eseguita un'ulteriore query per reperirne i tag, per un totale di N+1 query dove N è il numero di post. Il problema si risolve concettualmente con un left join, ovvero sostituendo @posts = Post.all con @posts = Post.includes(:tags)

b) come da implementazione. Si è gestito il caso di term mancante o vuoto restituendo un array vuoto

c) non richiesto