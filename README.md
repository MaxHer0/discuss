#  Discuss

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix



Everything is ready....

Lets' rock and roll!!!
cool!

I should start at 53?
yes
happy coding!!!

thank you for everything...   no problem, im here if you need anything


ok, le folder Model, est rendu ici,...
le mot model est disparu de la structure, on utilise le context de l'application maintenant mais ca change rien sur les function
a l'interne du fichier que tu vois dans le video

Ils ont faite ca parce que dans les grosses applications, le folders model se remplissait de cochonerie tous le temps, maintenant on classe par "context"

je te montre vite vite
tu vois dans lapplication discuss, on a 5 context, accounts, customer... etc

donc quand tu ouvre le folder de l'application, tu peux comprendre une peux mieux ce que le site fais

dac, mais depuis le debut de phoenix les modules que jai touché etaient dans discuss_web avec le module DiscussWeb
yes

tu pourrais continuer en dessus du folder _web, mais pense a ceci

le site est dans le folder _web, le business logic(function et ce que lapplication fais finalement) est dans le folder dicusss

on garde le _web pour le site web seulement, on mets aucune logique dans cette section la, tous les function doivent etre dans le folder discuss dans le cas
present

donc imagine, la page topic:index ici, le controller comme le nom le dit, controller ce qui se passe quand tu appel la page de ton browser..
 =====

 # yes ca cest le fichier qui gere la table topics de la base de donnee qui lui appel model dans le cour...
  # model == schema maintenant au lieu de use Discuss.Model
  # tu veux savoir ou c'est le use Discuss.Model avant, regarde ici je te montre
  # ici je texplique vite vite
  # use Ecto.Schema, load tous ce que tu veux de voir, ca te donne access a la function schema ici qui te permet de definir les champs dans la base de donnnes
  # field est aussi une fnction qui viens de schema
  # Repo. cest le Module de Ecto(Connexion base de cdonne) qui te permet de lire, ecrire, deleter etc
  # Repo veut dire? cest le nom quils ont donner au module, mais attend le te montre
  # Repo cest la config de ton repositories(mot fancy pour dire base de donnee) mais  ca pourrait aussi etre example amazon,
  # tu peux configurer les options de Repo sur nimporte quelle base de donnees, excel, access, amazon etc
  # et la config est ici
  # quand ton application pars, Ecto se connecte a la base de donnee
  # dans la config tas vue pool_size => le nombre de connexion simultanne, dans le cas present, 10 je pense
  # oui, ok je ne suis pas trop embrouille cest bon signe ;)
  # imagine ca, la on peut aller par PGADMIN et change linfo, ajouter, modifger etc

  # tous ce que Phoenix fais en faite, cest de rendre ca simple pour le user, aussi si simple que ca
  # tu vas avoir une function dans le controller pour les 6 actions de bases, listes les topics, show 1 topic, new topic, create topic, edit, update et delete...
  # simple... ok ca passe tout par le controller
  # toujours, router gere le traffic et dirige la demande au controller, qui lui assure la bonne excution,,,
  # router cest le garde de securite, le controler cest le VP vente disons pour le topic..., tu peux avoir 100 controller qui ont chacun un poste different
  # topic_controller, payment controller, inventaire etc...
  # et dans change controler normalemtn tu vas voir ceci...

  # controller cest pas standard, mais tu peux combiner des fonctioner ici genre
  ## Question? non, good la tu vas voir le conn et les params, comment dealer avec ca, le reste cest comme tu as vu deja dans la premiere partie
  # function .
  # dac, la suite demain , je viens de voir l heure... ;) cest pas tough cest ptite bete la lol
  #  lol hahahaha