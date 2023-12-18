# PC4

### a) Modifica la lista index para incluir el número de fila de cada fila de la perícula

Para realizar este proceso cambiamos la sentencia del bucle each
```rhtml
<% @movies.each do |movie| %>
``` 

a un each_with_index, incluyendo en la sentencia do el index y agregándole + 1 dentro del <td> para que el número de filas inicie con 1

```rhtml
<% @movies.each_with_index do |movie, index| %>
      <tr>
        <td>
          <%= index + 1 %>
        </td>
```

### b) Modifica la vista Index para que cuando se sitúe el ratón sobre una fila de la tabla, dicha tabla cambie temporalmente de color

Agregamos `table-hover` dentro de class al momento de declarar la tabla

```rhtml
<table class="table table-striped col-md-12 table-hover" id="movies">
```

Y para modificar el color, cambiamos el código css ubicado en `app/assets/stylesheets/applicatioin.css`

```css
.table-hover tbody tr:hover td {
    background-color: palegoldenrod;
}
```

Tomando la clase .table-hover e ingresando al tbody -> tr:hover -> td donde se encuentra la fila

### c) Modifica la acción Index del controlador
Modifica la acción Index del controlador para que devuelva las películas ordenadas
alfabéticamente por título, en vez de por fecha de lanzamiento. No intentes ordenar el
resultado de la llamada que hace el controlador a la base de datos. Los gestores de
bases de datos ofrecen formas para especificar el orden en que se quiere una lista de
resultados y, gracias al fuerte acoplamiento entre ActiveRecord y el sistema gestor debases de datos (RDBMS) que hay debajo, los métodos find y all de la biblioteca de

Modificamos el controlador `app/controllers/movies_controller.rb` agregando el ordenamiento por título

```ruby
  def index
    @all_ratings = Movie.all_ratings
    ratings_form = params[:ratings] || {}
    @ratings_to_show = ratings_form.keys

    if @ratings_to_show.empty?
      @ratings_to_show = @all_ratings
    end
    @movies = Movie.where(rating: @ratings_to_show).order(:title)
  end
```

### d) Modifica la acción Index del controlador
Simula que no dispones de ese fuerte acoplamiento de ActiveRecord, y que no puedes
asumir que el sistema de almacenamiento que hay por debajo pueda devolver la
colección de ítems en un orden determinado. Modifique la acción Index del controlador
para que devuelva las películas ordenadas alfabéticamente por título. Utiliza el método
sort del módulo Enumerable de Ruby.

Modificamos el controlador `app/controllers/movies_controller.rb` agregando el ordenamiento por título

```ruby
@movies = Movie.where(rating: @ratings_to_show)
@movies = @movies.sort_by{|m| m.title}
```

Primero traemos los datos que cumplan con los ratings establecidos, luego los ordenamos usando la función sort_by de enumerable.

