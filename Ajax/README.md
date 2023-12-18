# AJAX

Los pasos necesarios para la programación AJAX on Rails:

Indicamos los pasos necesarios para la programación `AJAX` on Rails:

1. Crear una acción del controlador o modificar una existente para gestionar las peticiones AJAX hechas por el código JavaScript. En lugar de procesar una vista completa, la acción procesará una parcial para generar un fragmento HTML que se insertará en la página.


2. Construir un URI REST en JavaScript y utilizar XHR (XmlHttpRequest) para enviar la petición HTTP al servidor. Como habrás supuesto, jQuery dispone de atajos útiles para muchos casos habituales, por lo que utilizaremos las funciones de más alto nivel y más potentes que ofrece jQuery en lugar de llamar a XHR directamente.


3. Dado que JavaScript, por definición, se ejecuta en un hilo único (single-threaded ), sólo puede trabajar en una tarea cada vez hasta que dicha tarea se completa, la interfaz de usuario del navegador se quedaría congelada mientras JavaScript esperara la respuesta del servidor. Por ello, XHR en cambio vuelve inmediatamente de la llamada a la función y permite proporcionar una función callback para manejar el evento que se activará cuando responda el servidor o si se produce un error.


4. Cuando la respuesta llega al navegador, el contenido de la respuesta se pasa a la función callback. Puede utilizar la función replaceWith() de jQuery para reemplazar un
elemento existente por completo, text() o html() para actualizar el contenido de un elemento in situ o una animación como hide() para ocultar o mostrar elementos. Puesto que las funciones JavaScript son clausuras (como los bloques de Ruby), la función callback tiene acceso a todas las variables visibles en el momento en el que se realizó la llamada XHR, aun cuando se ejecuta más tarde y en un entorno distinto.

   
## Parte 0

Agregamos unas vistas para el `MoviesController#edit` y `MoviesController#new` para que funcionen correctamente.

La vista de `MoviesController#new` sería la siguiente:

```rhtml
<h2>Create New Movie</h2>

<%= form_tag movies_path, :class => 'form' do %>
  <%= label :movie, :title, 'Title', :class => 'col-form-label' %>
  <%= text_field :movie, :title, :class => 'form-control' %>

  <%= label :movie, :rating, 'Rating', :class => 'col-form-label'  %>
  <%= select :movie, :rating, ['G','PG','PG-13','R','NC-17'], {}, {:class => 'form-control col-1'} %>

  <%= label :movie, :release_date, 'Released On', :class => 'col-form-label'  %>
  <%= date_select :movie, :release_date, {}, :class => 'form-control col-2 d-inline' %>
  <br/>
  <%= submit_tag 'Creat Movie', :class => 'btn btn-primary' %>
  <%= link_to 'Back to Movies', movies_path, :class => 'btn btn-secondary' %>
<% end %>
```

Y la vista de `MoviesController#edit` sería la siguiente:

```rhtml
<h2>Edit Movie</h2>
<%= form_tag movie_path(@movie), :method => :put do %>
  <%= label :movie, :title, 'Title', :class => 'col-form-label' %>
  <%= text_field :movie, 'title', :class => 'form-control' %>

  <%= label :movie, :rating, 'Rating', :class => 'col-form-label'  %>
  <%= select :movie, :rating, ['G','PG','PG-13','R','NC-17'], {}, {:class => 'form-control col-1'} %>

  <%= label :movie, :release_date, 'Released On', :class => 'col-form-label'  %>
  <%= date_select :movie, :release_date, {}, :class => 'form-control col-2 d-inline' %>
  <br/>

  <%= submit_tag 'Edit Movie', :class => 'btn btn-primary' %>
  <%= link_to 'Back to Movie', movies_path, :class => 'btn btn-secondary' %>
<% end %>
```

## Parte 1

Comenzaremos utilizando la acción del `MoviesController#show` editándolo para agregar el renderizado de la vista parcial.

Editamos el método show de `movies_controller.rb`, en este caso editando la ruta donde se encontrará la vista parcial:

```ruby
def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    render(:partial => 'movies/partial_show', :object => @movie) if request.xhr?
    #  will render app/views/movies/show.<extension> by default
end
```

Luego creamos la vista parcial llamada `_partial_show.html.erb`:

```rhtml
<p> <%= movie.description %> </p>
<%= link_to 'Edit Movie', edit_movie_path(movie), :class => 'btn btn-primary' %>
<%= link_to 'Close', '', :id => 'closeLink', :class => 'btn btn-secondary' %>
```

¿Cómo sabe la acción de controlador si `show` fue llamada desde código JavaScript o mediante una petición HTTP normal iniciada por el usuario?

Normalmente se puede ver como parámetros del URL o en el cuerpo de la solicitud.

## Parte 2

Nos solicitan explicar el siguiente código que estará en `app/assets/javascript/show.js`:

```javascript
//= require jquery
//= require rails-ujs
var MoviePopup = {
  setup: function() {
    // add hidden 'div' to end of page to display popup:
                                                    let popupDiv = $('<div id="movieInfo"></div>');
    popupDiv.hide().appendTo($('body'));
    $(document).on('click', '#movies a', MoviePopup.getMovieInfo);
  }
  ,getMovieInfo: function() {
    $.ajax({type: 'GET',
            url: $(this).attr('href'),
            timeout: 5000,
            success: MoviePopup.showMovieInfo,
            error: function(xhrObj, textStatus, exception) { alert('Error!'); }
           // 'success' and 'error' functions will be passed 3 args
    });
    return(false);
    }
  ,showMovieInfo: function(data, requestStatus, xhrObject) {
    // center a floater 1/2 as wide and 1/4 as tall as screen
    let oneFourth = Math.ceil($(window).width() / 4);
    $('#movieInfo').
      css({'left': oneFourth,  'width': 2*oneFourth, 'top': 250}).
      html(data).
      show();
    // make the Close link in the hidden element work
    $('#closeLink').click(MoviePopup.hideMovieInfo);
    return(false);  // prevent default link action
  }
  ,hideMovieInfo: function() {
    $('#movieInfo').hide();
    return(false);
  }
};

$(MoviePopup.setup);
```

`MoviePopup.setup`: Esta parte está destinada a la configuración del popup que se va a mostrar en la página. El `let pop`

`MoviePopup.getMovieInfo`: Esta función se ejecuta al momento de hacer click en el enlace perteneciente a una movie.

`MoviePopup.showMovieInfo`: Esta función tomando en cuenta el tamaño de la ventana, la muestra dentro de la misma.

`MoviePopup.hideMovieInfo`: Esta función se encarga de cerrar el Popup.

Tener en cuenta que tenemos que agregar el `gem 'jquery-rails'` en el Gemfile.

También tenemos que agregar el `<%= javascript_include_tag 'show' %>` al final del archivo `index.html.erb`.

También agregamos el código css en `app/assets/stylesheets/application.css`

```css
#movieInfo {
  padding: 2ex;
  position: absolute;
  border: 2px double grey;
  background: wheat;
}
```

## Parte 3

Conviene mencionar una advertencia a considerar cuando se usa JavaScript para crear nuevos elementos dinámicamente en tiempo de ejecución, aunque no surgió en este ejemplo en concreto. Sabemos que `$(.myClass).on(click,func)` registra `func` como el manejador de eventos de clic para todos los elementos actuales que coincidan con la clase CSS myClass. Pero si se utiliza JavaScript para crear nuevos elementos que coincidan con `myClass` después de la carga inicial de la página y de la llamada inicial a `on`, dichos elementos no tendrán el manejador asociado, ya que `on` sólo puede asociar manejadores a elementos existentes.

¿Cuál es solución que brinda jQuery a este problema? 

La solución que nos brinda JQuery es colocar la clase como parámetro de la siguiente manera:

```javascript
$('body').on('click', '.myClass', function() {
  // Manejar el evento
});
```