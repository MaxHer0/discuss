defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.Post
  alias Discuss.Post.Topic

  # ici on dit au controller, passe dans plug max avant de faire laction index, tu pourrait juste lappliquer sur une action
  # la la function plug_max va sexecuter seulement sur Index...refresh ta page
  plug :plug_max when action in [:index]

  def index(conn, _params) do
    # comment je peux envoye la variable data dans le fichier index.html?
    #
    # COOL

    topics = Post.list_topics()

    render(conn, "index.html", topics: topics)
  end

  def new(conn, _params) do
    changeset = Post.change_topic(%Topic{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic_params}) do
    case Post.create_topic(topic_params) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic created successfully.")
        |> redirect(to: Routes.topic_path(conn, :show, topic))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    topic = Post.get_topic!(id)
    render(conn, "show.html", topic: topic)
  end

  def edit(conn, %{"id" => id}) do
    topic = Post.get_topic!(id)
    changeset = Post.change_topic(topic)
    render(conn, "edit.html", topic: topic, changeset: changeset)
  end

  def update(conn, %{"id" => id, "topic" => topic_params}) do
    old_topic = Post.get_topic!(id)

    case Post.update_topic(old_topic, topic_params) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic updated successfully.")
        |> redirect(to: Routes.topic_path(conn, :show, topic))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", topic: old_topic, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    topic = Post.get_topic!(id)
    {:ok, _topic} = Post.delete_topic(topic)

    conn
    |> put_flash(:info, "Topic deleted successfully.")
    |> redirect(to: Routes.topic_path(conn, :index))
  end

  def plug_max(conn, _) do
    IO.inspect("Im here")
    data = 1 + 1

    # va sur new disons...
    # pas de plug here...see! retourne sur index
    # donc tu as modifier la plug/conn avec une fonction,... tous le module plug est bati comme ca.. recois une conn, retourne la conn
    # Phoenix te donne une serie de plug deja monte GRATIS, donc tu as pas a te casserr la tete avec ca quand tu utilise Phoenix
    # Si les videos que tu fais sont pas claire a cause de Pheonxi 1.4, je te switch sur Pragmatic Studio
    # la tu vas passer a travers dun server Web comme phoenix, en fait tu monte une server Phoenix de zero
    # la ca va entre et ca va etre supert claire, quand tu vas revenir a phoenix, tu vas rire tellement cest simple
    # bonne question, te rendu a quelle video? #90 je comprend, cest plus le rapport avec lancienne arborescence, mais la ca va
    # ok, ca cest juste le look de la structure et une difference majeur avec les routes...
    # avant on ecrivais topic_path maintenent on met Routes.topic_path...
    # le reste cest juste des modules, comme tu as fais deja dans le cour davant
    # pour les templates, est ce que cest clair ce bout la...
    # je crois que oui, la seule differnce avec ce que tu as fait pour le site du resto, c'est les
    # <%= %>
    # en appelant le fichier ...html.eex -> Phoenix compile le fichier et cheche les balise <% %> dans le code, cest aussi simple que ca..
    # toute les fonctions que tu mets entre ces balises cest les meme fonction que tu peux utlise dans tes modules regarde
    # simple right? oui elixir se retrouve entre les % %  yes, aussi lautre chose que tu dois savoir, cest comment envoye linfo du
    # controlleru vers le template?
    # comment on fais ca?
    # render, oui render va execute le fichier "index.html", mais comment je peux envoye une donne, ok check...
    # est ce que ca va marche ca tu pense?
    # wow aucune idee, refresh... MAGIE...;) refresh

    conn = conn |> assign(:data, data) |> assign(:max, "Max")
    IO.inspect(conn.assigns)

    # see the idea here!! assign cest une fonctione qui est import par le module controller que tu vois ici
    # tu peux mettre ce que tu veux dans la map conn, assign met linfo dans la section assigns de la map conn. et ca deviens disponible sur le site
    # donc imagine le site cancer... tu entre ton email, tu te log, le server load ton info et la met dans conn.assigns.
    # la je peux utiliser @user.email partout sur le site, sans mettre rien dans mes controlleur..
    # CONN cest on meilleur ami quand tu fais linterface client, quand les boys comprennent pas conn, je vois du code en double partout
    # cest fort, la navbar du site cest une bonne exmaple de code qui reviens partout...
    # trust me you dont want to recode the useranme everuwhere...
    # ok donc je continue avec Phoenix?  Si tu te sens willing de te bruler le cerveau, je mettrais sur le server tous de suite...
    # okidoo, ok that good, let's rock and roll...
    conn
  end
end

# yes, conn, ok, check ben... Quamd la requete arrive... 1 sec..

# Question, est ce que le server web qui a la page, est live avec le client ou est toujrous deconnecte du client?

# live quand mix phx.server, ok, je vais clarifier la question
# disons que tu viens sur le site google.com, est ce que ton browsers et toujours connecte sur le server ou tu es deconnecte?
# je pense quil connect a ch request, yesss
# le protocol HTTP est stateless => stateless veut dire que le server garde AUCUNE info sur le client
# disons que tu veux le topic 1, ton browser connect sur localhostT:4000/topics/1 => on envoie un GET request ... le serveyr prepare la page et retourne au client
# rendu la, la connection est ferme sur le serveur...

#  Donc, quesse qui se passe avec CONN quand la request arrive sur le server ==>
# Tu te souviens des pipelines?
# oui
# Ok, Elixir comme tu sais transforme les donnees sright so, quand ton browser se connect, Google chrome envoie une requeste, quand ca arrive sur le serveur,
# elixir recois la requete et mets l'>info dans la MAP CONN
# et utilse cette map jusqua la fin du cycle... donc CONN est juste une MAP
# tu vois la structure de base de Plug.Conn en bas...
# Chaque fois que le server recois une demande sur le port 4000, http://localhost:4000
# quand tu part elixir avec loption phx.server, le port 4000 est en mode ecoute
# aussitot que le port 4000 recois une demande, il passe au travers le pipeline, check ben
# tu vois lidee... Conn est la du debut a la fin, cest ca qui tiens linfo du debut du cycle jusqua la fin...
# aussitot que le controller a fini sa job, comme tu vois dans index, faut que tu retourne le conn absolument sinon le pipeline stop...
# et le client revois pas son info...
# ok, vas y
# cest ok tu as vu le mot plug souvens, plug cest le nom que Phoenix a donne a son pipeline Web, thats it, quand tu vois le mot plug, cest
# TOUJORUS relie a une request  HTTP.

# Donc si cest clair, voici la question qui tue

# How the fuck we keep the information about the user when you logged if if the server dont maintain data after he send back the request?

# le serveur doit enregistrer le user dans une database?, yes, mais si le concept du conn est clair, comment le server sais quand la demande entre
# que cest toi? si tu entre ton user / pass cest facile, mais si tu change de page, le server lui vois chaque request comme une nouvelle requete
# il te connais pas
# il doit avoir un lien avec IP adress, quesse qui arrive si 2 ordi meme maison... meme ip right?
# oui, ,mais il y a plusieur couche, sen fait tu sors de ton router, tous les ordis utilise le meme IP cdonc ca marche pas ca, pense aussi au cell
# quand tu voyages en auto, tu change d'ip a toute les tour que tu connectes.. probleme ici la...

# donc comment on gere ca.... COOKIE ou SESSION sur LE CLIENT, ton google chrome va gerer ca....
# watch...
# SFMyNTY.g3QAAAACbQAAAAtfY3NyZl90b2tlbm0AAAAYZjlvQkp0b1cwdmRLYUc2dERjWFRPQT09bQAAABZndWFyZGlhbl9kZWZhdWx0X3Rva2VubQAAAVxleUpoYkdjaU9pSklVelV4TWlJc0luUjVjQ0k2SWtwWFZDSjkuZXlKaGRXUWlPaUpqWVc1alpYSndZVzVqY21WaGN5SXNJbVY0Y0NJNk1UVTBNekF6TlRRd05Td2lhV0YwSWpveE5UUXlPVFE1TURBMUxDSnBjM01pT2lKallXNWpaWEp3WVc1amNtVmhjeUlzSW1wMGFTSTZJakZqWVdGak1UZzVMVFJqTXpBdE5EWXpaUzA0TmpWbUxUZzBZakkyWXpZeFl6WmhaaUlzSW01aVppSTZNVFUwTWprME9UQXdOQ3dpYzNWaUlqb2lOQ0lzSW5SNWNDSTZJbUZqWTJWemN5SjkuVFBYNEozQ3AtcTZxWWtnXzJKRnE4cVpuVkNyb3R6RElqU0l2Yl96b05DeDlfYzZSNHVvT1BuLTdXN3dZQllJcGppUHJSaTcyck1JbXNvRFBxZDdWemc.OPKzUD7BtZK_8wGR4GZrSfGOCp8vxuXIra_XZ4Vh2cY

# ca cest ton ID, ton browser garde ca en memoire tant que tu click pas sur logout...

# so pourquoi je parle de ca.. CONN, a une section qui s'appel assign...
# On utilise assigns quand le user se connecte, on verifie la session savoir sil est connu
# la tu peux aller dans la base de donnee loader l'info du user, et le mettre dans conn.assigns... et la ca suit le user mais tous ca
# ca se produit CHAQUE fois que le client clique ou reload la page...
# VRAIMENT IMPORTANT QUE CONN sois compris a 20000%
# Question? javais vu la structure de conn, je comprend quil faut passer conn toujours, mais cest un peu mlade de tout retenir ce quil y a dedans (toutes les possibililt/es)

# impossible de retenir tous ca et cest pas necessaires, limportant cest de comprendre comment ca marche
# on utilise assigns et tu sors linfo parfois de remote_ip si tu veux savoir dou le user arrive disons

# la tu peux voir la map avant apres...
# cest la meme map... juste rempli par le pipepline
# donc tu peux imagine la puissance de ca...
# tu peux bloque un user, ajoute de linfo, valider, anylyser etc etc a chaque etape
# example, envoie une message a lecran au user qui sont en europe(base sur le IP du conn), affiche un autre message aux users de californie pour le legal
# tu vois lideee, ya juste elixir/phoenix qui te permet de faire ca
# hum, si tu comprend le concept du pipeline, la conn passe au travers dun pipeline, aussi simple que ca... les details de la map sont pas important pour linstant
# ok et cest plug qui fait ca, y^es, plug cest juste le nom du pipeline... check
# une plug cest juste une fonctione qui recois une conn, et retourne une conn...thats it...
# ok et la def francais de fetch? fetch ca veut dire en francais, extraction disons. donc fetch cest sors le cookie de la requete dans ce cas precis
# mais check, la fonction pourrait sappeler comme tu veux
# on va en faire une check ben/..
