### Depuración SaaS que usan Rails
## Preguntar
- Preguntar (Ask): Dependiendo del entorno de trabajo podemos distribuir o no el mensaje afuera
- Buscar (Search): Buscar el error presentado en google utilizando palabras clave o el mensaje de error.
- Postea (Post): Podemos optar por postear una pregunta en estos sitios o foros, hay que ser lo más específico posible acerca de lo que fue mal, el entorno y como reproducir este problema.

Podemos obtener información acerca del problema cuando se detiene una aplicación revisando el log, por lo general el log/development.log

## Otro caso
Otro problema sería que la aplicación sigue en ejecución, pero se comporta incorrectamente. Uno de los métodos para identificar estos parámetros son:

- Mostrar la descripción de un objeto en una vista (view) insertando `= debug(@movie)` o `= @movie.inspect`

``` ruby
-# in app/views/movies/show.html.haml

%h2 Details about #{@movie.title}

%ul#details
  %li
    Rating:
    = @movie.rating
  %li
    Released on:
    = @movie.release_date.strftime("%B %d, %Y")

%h3 Description:
= link_to 'Edit info', edit_movie_path(@movie)
= link_to 'Back to movie list', movies_path


= debug(@movie)
= @movie.inspect
```

Insertamos las últimas dos líneas y nos muestra:

![](/img/img1.png)

Donde podemos visualizar los parámetros del objeto movie

- Detén la aplicación lanzando una excepción, por ejemplo `raise params.inspect`

Dentro de MoviesController
``` ruby
def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    raise @movie.inspect
    # will render render app/views/movies/show.html.haml by default
```

Nos muestra la siguiente pantalla con los parámetros de movie

![](/img/img2.png)

Donde podemos visualizar los parámetros al momento de detener la aplicación

- Podemos usar `logger.debug(mensaje)` para imprimir el mensaje al fichero loggin.

Dentro de MoviesController
```ruby
def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    logger.debug("Mostrando mensaje en el logger")
    # will render render app/views/movies/show.html.haml by default
```

Nos muestra lo siguiente en el development.log
![](/img/img3.png)

El log difiere dependiendo del entorno:

Dentro del entorno de production tenemos el siguiente fragmento:
```ruby
  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require "syslog/logger"
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new "app-name")

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end
```

Mientras que el entorno de development captura los deprecation messages:
```ruby
  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log
```

Otro método es utilizando la gema `debug`. Procedemos a instalarla utilizando el comando `gem install debug`.

Editamos el siguiente fragmento de código en MoviesController:
```ruby
  def show    
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    debugger
    # will render render app/views/movies/show.html.haml by default
  end
```
Agregamos la línea `debugger` y ahora corremos el servidor usando `rails server` lo cual nos mostrará lo siguiente

![](/img/img4.png)

En este caso se detiene la ejecución y nos muestra un mensaje en el terminal antes de continuar.
